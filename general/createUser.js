// https://hundredacretech.com/
// https://www.youtube.com/@StevenNoCode

const functions = require('firebase-functions');
const admin = require('firebase-admin');
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.createUser = functions.https.onCall(async (data, context) => {
  const {
    displayName,
    contactEmail,
    password,
  } = data;

  try {
    // Create a new user in Firebase Authentication
    const userRecord = await admin.auth().createUser({
      email: contactEmail, // Using contactEmail as the Firebase Auth email
      password: password,
    });

    // Store user details in Firestore
    await admin.firestore().collection('users').doc(userRecord.uid).set({
      displayName: displayName,
      email: contactEmail,
      created_time: admin.firestore.FieldValue.serverTimestamp()
      //add other fields to users doc accordingly
    });

    return true;
  } catch (error) {
    console.error('Error creating user:', error);
    return false;
  }
});
