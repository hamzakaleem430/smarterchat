import 'package:flutter/material.dart';
import 'package:smarterchat/pages/messagespage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: 5,
          );
        },
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MessagesPage();
              }));
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.person),
            ),
            title: Text(
              'Username',
            ),
            subtitle: Text(
              'Last Message here..',
            ),
            trailing: Icon(
              Icons.circle,
              size: 10,
              color: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}
