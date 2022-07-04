import 'package:flutter/material.dart';
import 'package:smarterchat/models/chatroom.dart';
import 'package:smarterchat/models/user.dart';
import 'package:smarterchat/pages/conversation_page.dart';
import 'package:smarterchat/services/auth_services.dart';
import 'package:intl/intl.dart';

class ChatWidget extends StatefulWidget {
  final String userId;
  final Chatroom chatroom;
  const ChatWidget({Key? key, required this.userId, required this.chatroom})
      : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  DateFormat _format = DateFormat('dd/MM/yyyy hh:mm a');
  AppUser? user;
  AuthServices _authServices = AuthServices();
  @override
  void initState() {
    _authServices.getUser(widget.userId).then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? SizedBox()
        : ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ConversationPage(
                  peerUser: user!,
                );
              }));
            },
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              backgroundImage: user!.profilePicUrl.isEmpty
                  ? null
                  : NetworkImage(user!.profilePicUrl),
              radius: 40,
              child: user!.profilePicUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 40,
                    )
                  : null,
            ),
            title: Text(user!.fullName),
            subtitle: Text(widget.chatroom.recentMessageText),
            trailing: Text(
              _format.format(DateTime.parse(widget.chatroom.recentMessageTime)),
              style: TextStyle(fontSize: 10),
            ),
          );
  }
}
