import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class VideoCallingServices {
  joinMeeting(String name, String email, String id, bool enableAudio,
      bool enableVideo) async {
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

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
