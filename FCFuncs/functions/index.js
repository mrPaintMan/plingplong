const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

//http request method
exports.sendHttpPushNotification = functions.https.onRequest((req, res) => {
  const user = req.body.user; //get params like this
  const FCMToken = admin.database().ref(`/FCMTokens/${user}`).once("value");

  const payload = {
    token: FCMToken,
    notification: {
      title: "cloud function demo",
      body: "Mälski vill ha uppmärksamhet!!",
    },
    data: {
      body: "Mälski vill ha uppmärksamhet!!",
    },
  };

  admin
    .messaging()
    .send(payload)
    .then((response) => {
      // Response is a message ID string.
      console.log("Successfully sent message:", response);
      return { success: true };
    })
    .catch((error) => {
      return { error: error.code };
    });
});
