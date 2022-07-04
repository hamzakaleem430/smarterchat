class Message {
  Message({
    required this.messageText,
    required this.sentBy,
    required this.sendingTime,
    required this.messageType,
  });
  late final String messageText;
  late final String sentBy;
  late final String sendingTime;
  late final String messageType;

  Message.fromJson(Map<String, dynamic> json) {
    messageText = json['messageText'];
    sentBy = json['sentBy'];
    sendingTime = json['sendingTime'];

    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['messageText'] = messageText;
    _data['sentBy'] = sentBy;
    _data['sendingTime'] = sendingTime;

    _data['messageType'] = messageType;

    return _data;
  }
}
