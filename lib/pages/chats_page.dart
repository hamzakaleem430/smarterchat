import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarterchat/models/chatroom.dart';
import 'package:smarterchat/models/user.dart';
import 'package:smarterchat/widgets/chat_widget.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenUtilInit(
        builder: () {
          return SafeArea(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return ChatWidget(
                                userId: getPeerUserId(
                                  snapshot.data!.docs[index]['chatMembers'],
                                ),
                                chatroom: Chatroom.fromJson(
                                    snapshot.data!.docs[index].data()),
                              );
                            },
                          );
                  }));
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     color: Theme.of(context).primaryColor,
      //     size: 30,
      //   ),
      //   elevation: 3,
      //   onPressed: () {},
      //   backgroundColor: Colors.white,
      //   shape: CircleBorder(
      //       side: BorderSide(color: Theme.of(context).primaryColor)),
      // ),
    );
  }

  String getPeerUserId(List chatMembers) {
    if (chatMembers.first != _firebaseAuth.currentUser!.uid)
      return chatMembers.first;
    return chatMembers.last;
  }
}
