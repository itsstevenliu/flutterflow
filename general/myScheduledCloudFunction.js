// https://youtube.com/@StevenNoCode

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const moment = require('moment-timezone'); //make sure this is added to your package.json

// Scheduled function to run hourly at the top of the hour, in the specified timezone (Australia/Sydney)
exports.myScheduledCloudFunction = functions.pubsub.schedule('0 * * * *')
  .timeZone('Australia/Sydney')
  .onRun(async (context) => { 
    console.log("CRON job started running");
    // example below sends push notification to user every day at 9am
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
              initial_page_name: "Profile", // change page to navigate to
              notification_sound: "default",
              target_audience: "All",
              user_refs: `/${doc.ref.path}`, 
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
  });
