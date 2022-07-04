import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarterchat/models/message.dart';

class ChatServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<bool> isFirstMessage(String peerUserId) async {
    String chatDocName = firebaseAuth.currentUser!.uid + "_" + peerUserId;
    if ((await firebaseFirestore.collection("chats").doc(chatDocName).get())
        .exists) {
      return false;
    } else {
      chatDocName = peerUserId + "_" + firebaseAuth.currentUser!.uid;
      if ((await firebaseFirestore.collection("chats").doc(chatDocName).get())
          .exists) {
        return false;
      }
    }
    return true;
  }

  Future<void> sendFirstMessage(String peerUserId, Message message) async {
    try {
      print('object');
      String chatDocName = firebaseAuth.currentUser!.uid + '_' + peerUserId;
      await firebaseFirestore.collection("chats").doc(chatDocName).set({
        "recentMessageText": message.messageText,
        "recentMessageTime": message.sendingTime,
        "chatMembers": [firebaseAuth.currentUser!.uid, peerUserId],
        "lastMessageReadBy": [firebaseAuth.currentUser!.uid],
      });
      await firebaseFirestore
          .collection("chats")
          .doc(chatDocName)
          .collection("Messages")
          .add(message.toJson());
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> getChatName(String peerUserId) async {
    String chatDocName = firebaseAuth.currentUser!.uid + '_' + peerUserId;
    if ((await firebaseFirestore.collection("chats").doc(chatDocName).get())
        .exists) {
      return chatDocName;
    }
    chatDocName = peerUserId + "_" + firebaseAuth.currentUser!.uid;
    return chatDocName;
  }

  Future<void> sendMessage(String peerUserId, Message message) async {
    try {
      String chatDocName = await getChatName(peerUserId);
      await firebaseFirestore.collection("chats").doc(chatDocName).update({
        "recentMessageText": message.messageText,
        "recentMessageTime": message.sendingTime,
        "lastMessageReadBy": [firebaseAuth.currentUser!.uid],
      });
      await firebaseFirestore
          .collection("chats")
          .doc(chatDocName)
          .collection("Messages")
          .add(message.toJson());
    } catch (e) {
      throw e;
    }
  }
}
