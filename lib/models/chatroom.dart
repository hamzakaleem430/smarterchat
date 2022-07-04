class Chatroom {
  Chatroom({
    required this.recentMessageText,
    required this.recentMessageTime,
    required this.chatMembers,
    required this.lastMessageReadBy,
  });
  late final String recentMessageText;
  late final String recentMessageTime;
  late final List<String> chatMembers;
  late final List<String> lastMessageReadBy;

  Chatroom.fromJson(Map<String, dynamic> json) {
    recentMessageText = json['recentMessageText'];
    recentMessageTime = json['recentMessageTime'];
    chatMembers = List.castFrom<dynamic, String>(json['chatMembers']);
    lastMessageReadBy =
        List.castFrom<dynamic, String>(json['lastMessageReadBy']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['recentMessageText'] = recentMessageText;
    _data['recentMessageTime'] = recentMessageTime;
    _data['chatMembers'] = chatMembers;
    _data['lastMessageReadBy'] = lastMessageReadBy;
    return _data;
  }
}
