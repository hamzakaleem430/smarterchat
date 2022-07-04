import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarterchat/models/message.dart';
import 'package:intl/intl.dart';

enum MessageType { Sent, Received }

class MessageWidget extends StatefulWidget {
  final Message message;
  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  MessageType? _messageType;
  DateFormat _format = DateFormat('hh:mm a');
  @override
  void initState() {
    _messageType =
        widget.message.sentBy == FirebaseAuth.instance.currentUser!.uid
            ? MessageType.Sent
            : MessageType.Received;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _messageType == null
        ? SizedBox()
        : Padding(
            padding: _messageType == MessageType.Sent
                ? EdgeInsets.only(left: .2 * size.width, right: 10)
                : EdgeInsets.only(left: 10, right: .2 * size.width),
            child: Column(
              crossAxisAlignment: _messageType == MessageType.Sent
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _messageType == MessageType.Sent
                        ? Colors.blue.withOpacity(.15)
                        : Theme.of(context).primaryColor.withOpacity(.15),
                  ),
                  child: Text(widget.message.messageText),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _format.format(DateTime.parse(widget.message.sendingTime)),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
