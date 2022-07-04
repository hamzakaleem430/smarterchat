import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:smarterchat/services/video_calling_services.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  void initState() {
    VCServices().startACall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(child: RtcLocalView.SurfaceView()),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mic),
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.videocam),
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.chat),
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.gesture),
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
