import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarterchat/pages/chatpage.dart';
import 'package:smarterchat/pages/newmeetingpage.dart';
import 'package:smarterchat/pages/userslist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        unselectedItemColor: Colors.white30,
        onTap: (v) {
          setState(() {
            index = v;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble), label: ''),
        ],
      ),
      body: index == 0
          ? UsersListPage()
          : index == 1
              ? NewMeetingPage()
              : ChatPage(),
    );
  }
}
