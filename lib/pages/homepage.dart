import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:smarterchat/pages/chats_page.dart';
import 'package:smarterchat/pages/newmeetingpage.dart';
import 'package:smarterchat/pages/userslist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.animateToPage(
            1,
            duration: Duration(milliseconds: 400),
            curve: Curves.linear,
          );
        },
        backgroundColor: Theme.of(context).primaryColor.withGreen(150),
        child: Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // setState(() {
                  //   index = 2;
                  // });
                  _controller.animateToPage(
                    0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.linear,
                  );
                },
                icon: Icon(
                  CupertinoIcons.person,
                  color: index == 0 ? Colors.white : Colors.white70,
                ),
              ),
              IconButton(
                onPressed: () {
                  // setState(() {
                  //   index = 2;
                  // });
                  _controller.animateToPage(
                    2,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.linear,
                  );
                },
                icon: Icon(
                  CupertinoIcons.chat_bubble,
                  color: index == 2 ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        children: [
          UsersListPage(),
          NewMeetingPage(),
          ChatsPage(),
        ],
      ),
    );
  }
}
