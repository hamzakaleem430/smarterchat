import 'package:agora_rtc_engine/rtc_engine.dart';

class VCServices {
  Future<void> startACall() async {
    RtcEngine engine = await RtcEngine.createWithContext(
        RtcEngineContext('4ec53eb2c51548dc96f61a68cecd33bd'));

    engine.setEventHandler(RtcEngineEventHandler(
        userJoined: (int uid, int elapsed) {},
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          engine.enableVideo();
        },
        userOffline: (int uid, UserOfflineReason reason) {}));
    engine.enableVideo();
  }
}
