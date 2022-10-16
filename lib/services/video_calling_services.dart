import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:smarterchat/pages/detectScreen.dart';

class VideoCallingServices {
  joinMeeting(
      String name, String email, String id, bool enableAudio, bool enableVideo,
      {required BuildContext context}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: id)
        // Required, spaces will be trimmed
        ..serverURL = "https://meet.jit.si/"
        ..userDisplayName = name
        ..userEmail = email

        //..userAvatarURL = "https://someimageurl.com/image.jpg" // or .png
        ..audioMuted = !enableAudio
        ..videoMuted = !enableVideo;
      Navigator.pop(context);
      FirebaseFirestore.instance
          .collection("meetings")
          .doc(id)
          .snapshots()
          .listen((event) {
        Fluttertoast.showToast(
            msg: event.data()!['sign'],
            backgroundColor: Colors.white60,
            textColor: Colors.black);
      });
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
