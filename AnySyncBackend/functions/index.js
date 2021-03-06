"use strict";
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.requestMatch = functions.firestore
  .document("/buttons/{activityId}/presses/{pressId}")
  .onCreate(async (snapshot, context) => {
    // timestamp and id
    const { time_pressed: currTime, uuid: currUuid } = snapshot.data();
    if (!currTime) {
      functions.logger.log("No time pressed??");
      functions.logger.log(snapshot.data());
      return;
    }
    const activityId = context.params.activityId;
    functions.logger.log(activityId);
    const pressesData = await admin
      .firestore()
      .collection("buttons/" + activityId + "/presses")
      .get();
    const presses = pressesData.docs.map(elem => elem);
    if (!presses || presses.length == 0) {
      functions.logger.log("No prior presses");
      return;
    }

    const toDelete = [];
    const fields = await admin
      .firestore()
      .doc("/buttons/" + activityId)
      .get();
    const { time_interval: timeInterval, name: activityName } = fields.data();

    const recentWithDups = presses
      .filter(elem => {
        const { time_pressed: timePressed, uuid } = elem.data();
        if (currTime - timePressed > timeInterval) {
          toDelete.push(elem.ref.delete());
          return false;
        }
        return uuid != currUuid;
      })
      .map(elem => elem.data().uuid);
    const recent = [...new Set(recentWithDups)]; // remove duplicates
    const numMatches = recent.length;

    functions.logger.log("Got " + numMatches + " matches.");
    if (numMatches == 0) {
      return Promise.all(toDelete);
    }

    // https://github.com/firebase/functions-samples/blob/master/fcm-notifications/functions/index.js
    const matchedPeopleTokens = Array.from(recent, uuid =>
      admin
        .firestore()
        .doc("/buttons/" + activityId + "/subscribers/" + uuid)
        .get()
    );
    matchedPeopleTokens.push(
      admin
        .firestore()
        .doc("/buttons/" + activityId + "/subscribers/" + currUuid)
        .get()
    );
    const temp = await Promise.all(matchedPeopleTokens);
    const tokens = temp.map(elem => (elem ? elem.data().token : ""));

    // Check if there are any device tokens.
    if (tokens.length == 0) {
      functions.logger.log("There are no notification tokens to send to.");
      return Promise.all(toDelete);
    }

    functions.logger.log("There are ", tokens.length, " tokens to notify.");

    const payload = {
      notification: {
        title: "You have a match!",
        body:
          (numMatches > 1
            ? numMatches + " people want "
            : numMatches + " person wants ") +
          activityName +
          " with you.",
      },
      tokens: tokens,
    };

    admin
      .messaging()
      .sendMulticast(payload)
      .then(response =>
        functions.logger.log(
          response.successCount +
            " messages were sent successfully.\n" +
            response.failureCount +
            " failed."
        )
      );
    return Promise.all(toDelete);
  });
