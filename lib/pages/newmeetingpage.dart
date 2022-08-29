import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarterchat/services/video_calling_services.dart';

class NewMeetingPage extends StatefulWidget {
  const NewMeetingPage({Key? key}) : super(key: key);

  @override
  State<NewMeetingPage> createState() => _NewMeetingPageState();
}

class _NewMeetingPageState extends State<NewMeetingPage> {
  bool enableAudio = true;

  bool enableVideo = true;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _meetingRoomIdController = TextEditingController();
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child:
                                  StatefulBuilder(builder: (context, setState) {
                                return ScreenUtilInit(builder: () {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: Form(
                                        key: _globalKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name :',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: .01.sh,
                                            ),
                                            SizedBox(
                                              child: TextFormField(
                                                controller: _nameController,
                                                validator: (v) {
                                                  if (v!.isEmpty) {
                                                    return "Field is required";
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Username",
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: .01.sh,
                                            ),
                                            Text(
                                              'Email :',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              height: .005.sh,
                                            ),
                                            SizedBox(
                                              child: TextFormField(
                                                validator: (v) {
                                                  if (v!.isEmpty) {
                                                    return "Field is required";
                                                  }
                                                },
                                                controller: _emailController,
                                                decoration: InputDecoration(
                                                  hintText: "Email",
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.zero),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: .01.sh,
                                            ),
                                            // Text(
                                            //   'Meeting Room Id:',
                                            //   style: TextStyle(
                                            //     fontSize: 15.sp,
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   height: .01.sh,
                                            // ),
                                            // SizedBox(
                                            //   child: TextFormField(
                                            //     validator: (v) {
                                            //       if (v!.isEmpty) {
                                            //         return "Field is required";
                                            //       }
                                            //     },
                                            //     controller:
                                            //         _meetingRoomIdController,
                                            //     decoration: InputDecoration(
                                            //       hintText: "Meeting Room Id",
                                            //       contentPadding:
                                            //           EdgeInsets.symmetric(
                                            //               horizontal: 10),
                                            //       border: OutlineInputBorder(
                                            //           borderRadius:
                                            //               BorderRadius.zero),
                                            //     ),
                                            //   ),
                                            // ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Enable Audio :'),
                                                Switch(
                                                    value: enableAudio,
                                                    onChanged: (a) {
                                                      setState(() {
                                                        enableAudio = a;
                                                      });
                                                    })
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Enable Video :'),
                                                Switch(
                                                    value: enableVideo,
                                                    onChanged: (a) {
                                                      setState(() {
                                                        enableVideo = a;
                                                      });
                                                    })
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    _nameController.clear();
                                                    _emailController.clear();

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: .1.sw,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (_globalKey.currentState!
                                                        .validate()) {
                                                      String id =
                                                          _emailController.text
                                                              .split('@')
                                                              .first;
                                                      VideoCallingServices()
                                                          .joinMeeting(
                                                              _nameController
                                                                  .text,
                                                              _emailController
                                                                  .text,
                                                              id,
                                                              enableAudio,
                                                              enableVideo);
                                                    }
                                                  },
                                                  child: Text(
                                                    'Join Meeting',
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }),
                            );
                          });
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
                          FittedBox(
                            child: Text(
                              'New Meeting',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
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
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return ScreenUtilInit(builder: () {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Form(
                                      key: _globalKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name :',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: .01.sh,
                                          ),
                                          SizedBox(
                                            child: TextFormField(
                                              controller: _nameController,
                                              validator: (v) {
                                                if (v!.isEmpty) {
                                                  return "Field is required";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Username",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.zero),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: .01.sh,
                                          ),
                                          Text(
                                            'Email :',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: .005.sh,
                                          ),
                                          SizedBox(
                                            child: TextFormField(
                                              validator: (v) {
                                                if (v!.isEmpty) {
                                                  return "Field is required";
                                                }
                                              },
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                hintText: "Email",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.zero),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: .01.sh,
                                          ),
                                          Text(
                                            'Meeting Room Id:',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            height: .01.sh,
                                          ),
                                          SizedBox(
                                            child: TextFormField(
                                              validator: (v) {
                                                if (v!.isEmpty) {
                                                  return "Field is required";
                                                }
                                              },
                                              controller:
                                                  _meetingRoomIdController,
                                              decoration: InputDecoration(
                                                hintText: "Meeting Room Id",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.zero),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Enable Audio :'),
                                              Switch(
                                                  value: enableAudio,
                                                  onChanged: (a) {
                                                    setState(() {
                                                      enableAudio = a;
                                                    });
                                                  })
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Enable Video :'),
                                              Switch(
                                                  value: enableVideo,
                                                  onChanged: (a) {
                                                    setState(() {
                                                      enableVideo = a;
                                                    });
                                                  })
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              OutlinedButton(
                                                onPressed: () {
                                                  _nameController.clear();
                                                  _emailController.clear();
                                                  _meetingRoomIdController
                                                      .clear();
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                ),
                                              ),
                                              SizedBox(
                                                width: .1.sw,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (_globalKey.currentState!
                                                      .validate()) {
                                                    VideoCallingServices()
                                                        .joinMeeting(
                                                            _nameController
                                                                .text,
                                                            _emailController
                                                                .text,
                                                            _meetingRoomIdController
                                                                .text,
                                                            enableAudio,
                                                            enableVideo);
                                                  }
                                                },
                                                child: Text(
                                                  'Join Meeting',
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            }),
                          );
                        });
                  },
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
                          FittedBox(
                            child: Text(
                              'Join Meeting',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
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
                        FittedBox(
                          child: Text(
                            'User Settings',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
