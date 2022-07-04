import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarterchat/pages/meeting_screen.dart';
import 'package:smarterchat/services/video_calling_services.dart';

class NewMeetingPage extends StatefulWidget {
  const NewMeetingPage({Key? key}) : super(key: key);

  @override
  State<NewMeetingPage> createState() => _NewMeetingPageState();
}

class _NewMeetingPageState extends State<NewMeetingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(builder: () {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 1.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MeetingScreen();
                      }));
                    },
                    child: Container(
                      width: .15.sh,
                      height: .15.sh,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                          Text(
                            'New Meeting',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: .1.sh,
                ),
                InkWell(
                  onTap: () {},
                  child: PhysicalModel(
                    color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                      width: .15.sh,
                      height: .15.sh,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                          Text(
                            'Join Meeting',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: .1.sh,
                ),
                PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  child: Container(
                    width: .15.sh,
                    height: .15.sh,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 158, 58, 183),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 40.sp,
                        ),
                        Text(
                          'User Settings',
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
