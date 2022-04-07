import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key}) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

enum MessageType { Sent }

class _MessageWidgetState extends State<MessageWidget> {
  final MessageType _messageType = MessageType.Sent;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
            child: Text('Message Text Here.'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '04:46 pm',
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
