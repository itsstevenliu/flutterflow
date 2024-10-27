// https://youtube.com/@StevenNoCode
// video on example use case: https://www.youtube.com/watch?v=R9an74QQFkU

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const moment = require('moment-timezone');

// At every minute. set the timezone you want to run the cloud function based on. hourly is 0 * * * * 
exports.myScheduledCloudFunction = functions.pubsub.schedule('* * * * *').timeZone('Australia/Sydney').onRun(async (context) => { 
  console.log("CRON job started running");
  // insert own code to do whatever you want. For exmaple below sends a push notification to the user using FF's push notification system. Push must be enabled from FF.
 try {
    // Define the static quote
    const staticQuote = {
      title: "Stay Focused",
      body: "The key to success is to stay focused on your goals and keep moving forward."
    };

    // Query the users collection
    const usersSnapshot = await admin.firestore().collection('users').get();

    // Loop through each user
    usersSnapshot.forEach((doc) => {
      const userData = doc.data();
      const userTimezone = userData.userTimezone; // assume timezone is stored in user document

      if (userTimezone) {
        // Calculate the current time in the user's timezone
        const today = moment().tz(userTimezone);
        const currentTime = today.format('HH:mm');

        // Check if it's exactly 9:00 AM in the user's timezone
        if (currentTime === '09:00') {
          const notificationData = {
            notification_title: staticQuote.title,
            notification_text: staticQuote.body,
            initial_page_name: "HabitsNew",
            notification_sound: "default",
            target_audience: "All",
            user_refs: `/${doc.ref.path}`, // Add '/' in front of the path
            timestamp: admin.firestore.FieldValue.serverTimestamp()
          };

          // Add the notification to Firestore
          admin.firestore().collection('ff_push_notifications').add(notificationData)
            .then(() => {
              console.log(`Push notification created for user: ${doc.id} at 9:00 AM in their timezone. Static quote sent - Title: "${staticQuote.title}", Body: "${staticQuote.body}"`);
            })
            .catch((error) => {
              console.error("Error creating push notification:", error);
            });
        }
      }
    });

  } catch (error) {
    console.error("Error in CRON job:", error);
  }

  console.log("CRON job finished");
};
