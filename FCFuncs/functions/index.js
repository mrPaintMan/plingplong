const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// http request method
exports.sendHttpPushNotification = functions.https.onRequest((req, res) => {
  const user = req.body.user; // get params like this
  const msg = req.body.msg ? req.body.msg : "Mälski vill ha uppmärksamhet!!";
  const title = req.body.title ? req.body.title : "Uppmärksamhets Alert";

  const payload = {
    notification: {
      title: title,
      body: msg,
    },
    android: {
      notification: {
        sound: "default",
      },
    },
    apns: {
      payload: {
        aps: {
          sound: "default",
        },
      },
    },
  };
  return admin
    .database()
    .ref(`/FCMTokens/${user}`)
    .once("value")
    .then(
      (snapshot) => {
        payload.token = snapshot.val();

        return admin
          .messaging()
          .send(payload)
          .then((response) => {
            // Response is a message ID string.
            res.status = 200;
            res.json({ result: "Message sent" });
            return { success: true };
          })
          .catch((error) => {
            res.status = 500;
            res.json({ result: "Message not sent", error: error });
            return { error: error.code };
          });
      },
      (error) => {
        res.status = 400;
        res.json({ result: "User not found" });
        return { error: error.code };
      }
    );
});
