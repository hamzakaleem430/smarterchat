import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarterchat/models/user.dart';
import 'package:smarterchat/pages/conversation_page.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenUtilInit(builder: () {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return snapshot.data!.docs[index].id !=
                                  _auth.currentUser!.uid
                              ? Card(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(
                                        snapshot.data!.docs[index]['fullName']),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ConversationPage(
                                                peerUser: AppUser.fromJson(
                                                  snapshot.data!.docs[index]
                                                      .data(),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        CupertinoIcons.chat_bubble,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox();
                          // return Card(
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Row(
                          //           children: [
                          //             CircleAvatar(
                          //               backgroundImage: NetworkImage(
                          //                   'https://scontent.flhe3-2.fna.fbcdn.net/v/t39.30808-6/241157377_2899159100399323_1941323188069831640_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeEjFBqrGRQ6F1-pZAPxzh1l3QOOfAK0hMzdA458ArSEzLOFCYHkoy-ulFTJC2LHbMv5bKTmZuy0DCx_u-wW4_WH&_nc_ohc=6m6VZbGypy8AX9KE90E&_nc_ht=scontent.flhe3-2.fna&oh=00_AT_EwsIuVq2MCpmMEyGESbZd8rlUKiuco-gMxyoHOnsvyw&oe=6249B1E3'),
                          //             ),
                          //             SizedBox(
                          //               width: .025.sw,
                          //             ),
                          //             Text('Ali Usama Don'),
                          //           ],
                          //         ),
                          //         IconButton(
                          //           onPressed: () {},
                          //           icon: Icon(
                          //             CupertinoIcons.chat_bubble,
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              });
        }),
      ),
    );
  }
}
