const functions = require('firebase-functions');
const admin = require('firebase-admin');

// At every minute. set the timezone you want to run the cloud function based on. hourly is 0 * * * * 
exports.myScheduledCloudFunction = functions.pubsub.schedule('* * * * *').timeZone('Australia/Sydney').onRun(async (context) => { 
  console.log("CRON job started running");
  // insert own code to do whatever you want
  console.log("CRON job finished");
});
