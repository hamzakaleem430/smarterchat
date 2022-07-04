import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarterchat/models/message.dart';
import 'package:smarterchat/models/user.dart';
import 'package:smarterchat/services/chat_services.dart';
import 'package:smarterchat/widgets/messagewidget.dart';

class ConversationPage extends StatefulWidget {
  final AppUser peerUser;
  const ConversationPage({Key? key, required this.peerUser}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool sending = false;
  bool? isfirstMessage;
  ChatServices _chatServices = ChatServices();
  String? chatDocName;
  TextEditingController _messageTextController = TextEditingController();
  @override
  void initState() {
    _chatServices.isFirstMessage(widget.peerUser.id).then((value) {
      if (!value) {
        _chatServices.getChatName(widget.peerUser.id).then((docName) {
          chatDocName = docName;
          setState(() {});
        });
      }
      isfirstMessage = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white24,
              backgroundImage: widget.peerUser.profilePicUrl.isEmpty
                  ? null
                  : NetworkImage(widget.peerUser.profilePicUrl),
              child: widget.peerUser.profilePicUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      color: Colors.grey.shade700,
                    )
                  : null,
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.peerUser.fullName),
          ],
        ),
        actions: [
          Icon(Icons.more_vert),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: ScreenUtilInit(
          builder: () {
            return isfirstMessage == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      isfirstMessage ?? true
                          ? Center(
                              child:
                                  Text('Send a message to start conversation.'))
                          : Padding(
                              padding: EdgeInsets.only(bottom: .1.sh),
                              child: StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection('chats')
                                      .doc(chatDocName)
                                      .collection('Messages')
                                      .orderBy('sendingTime', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? ListView.builder(
                                            reverse: true,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              return MessageWidget(
                                                key: UniqueKey(),
                                                message: Message.fromJson(
                                                    snapshot.data!.docs[index]
                                                        .data()),
                                              );
                                            },
                                          )
                                        : SizedBox();
                                  }),
                            ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: .1.sh,
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: _messageTextController,
                                    decoration: InputDecoration(
                                      hintText: 'Write your message',
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius: BorderRadius.zero),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.zero),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.send,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: sending
                                            ? null
                                            : () async {
                                                if (_messageTextController
                                                    .text.isNotEmpty) {
                                                  if (isfirstMessage ?? true) {
                                                    setState(() {
                                                      sending = true;
                                                    });
                                                    await _chatServices
                                                        .sendFirstMessage(
                                                            widget.peerUser.id,
                                                            Message(
                                                                messageText:
                                                                    _messageTextController
                                                                        .text,
                                                                sentBy: _firebaseAuth
                                                                    .currentUser!
                                                                    .uid,
                                                                sendingTime: DateTime
                                                                        .now()
                                                                    .toIso8601String(),
                                                                messageType:
                                                                    "Text"))
                                                        .then((value) {
                                                      setState(() {
                                                        _messageTextController
                                                            .text = '';
                                                        sending = false;
                                                        if (isfirstMessage ??
                                                            true) {
                                                          isfirstMessage =
                                                              false;
                                                        }
                                                      });
                                                    });
                                                  } else {
                                                    setState(() {
                                                      sending = true;
                                                    });
                                                    await _chatServices
                                                        .sendMessage(
                                                            widget.peerUser.id,
                                                            Message(
                                                                messageText:
                                                                    _messageTextController
                                                                        .text,
                                                                sentBy: _firebaseAuth
                                                                    .currentUser!
                                                                    .uid,
                                                                sendingTime: DateTime
                                                                        .now()
                                                                    .toIso8601String(),
                                                                messageType:
                                                                    "Text"))
                                                        .then((value) {
                                                      setState(() {
                                                        _messageTextController
                                                            .text = '';
                                                        sending = false;
                                                      });
                                                    });
                                                  }
                                                }
                                              },
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   height: double.infinity,
                                //   margin: EdgeInsets.all(5),
                                //   color: Theme.of(context)
                                //       .primaryColor
                                //       .withOpacity(.15),
                                //   child: IconButton(
                                //     icon: Icon(Icons.attachment),
                                //     color: Theme.of(context).primaryColor,
                                //     onPressed: () {
                                //       showModalBottomSheet(
                                //         context: context,
                                //         barrierColor: Colors.transparent,
                                //         backgroundColor: Colors.transparent,
                                //         constraints: BoxConstraints(
                                //           maxHeight: .1.sh + 100,
                                //           maxWidth: 50,
                                //         ),
                                //         builder: (context) {
                                //           return Padding(
                                //             padding:
                                //                 EdgeInsets.only(bottom: .1.sh),
                                //             child: Column(children: [
                                //               IconButton(
                                //                 onPressed: () {},
                                //                 highlightColor: Colors.grey,
                                //                 icon: Icon(Icons.videocam),
                                //               ),
                                //             ]),
                                //           );
                                //         },
                                //       );
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
