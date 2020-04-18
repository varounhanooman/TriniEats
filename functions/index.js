const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp();


exports.addMessage = functions.https.onRequest(async (req, res) => {
    // [END addMessageTrigger]
      // Grab the text parameter.
      const original = req.query.text;
      // [START adminSdkAdd]
      // Push the new message into Cloud Firestore using the Firebase Admin SDK.
      const writeResult = await admin.firestore().collection('test').add({original: original});
      // Send back a message that we've succesfully written the message
      res.json({result: `Message with ID: ${writeResult.id} added.`});
      // [END adminSdkAdd]
    });
    // [END addMessage]