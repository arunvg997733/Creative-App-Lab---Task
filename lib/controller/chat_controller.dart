import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  sentMassage(
    String message,
    String receverId,
  ) async {
    print(message);
    List<String> chatIdList = [receverId, auth.currentUser!.uid];
    chatIdList.sort();
    final chatId = chatIdList[0] + chatIdList[1];
    print(chatId);
    Timestamp time = Timestamp.now();
    final data = {
      'Message': message,
      'Time': time,
      'sender': auth.currentUser!.uid,
      'receiver': receverId
    };
    final chatdata = firestore
        .collection('chatData')
        .doc(chatId)
        .collection('SingleUserMessage')
        .add(data);
  }

  Stream<QuerySnapshot> getMessage(
    String receiverid,
  ) {
    List<String> chatIdList = [receiverid, auth.currentUser!.uid];
    chatIdList.sort();
    final chatId = chatIdList[0] + chatIdList[1];
    final chatdata = firestore
        .collection('chatData')
        .doc(chatId)
        .collection('SingleUserMessage')
        .orderBy('Time')
        .snapshots();
    return chatdata;
  }
}
