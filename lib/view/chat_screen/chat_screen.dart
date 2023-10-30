import 'package:chatapp/controller/chat_controller.dart';
import 'package:chatapp/core/constant.dart';
import 'package:chatapp/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user});
  UserModel user;
  final getChat = Get.put(ChatController());
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController messagectr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        centerTitle: true,
        title: textWidget(text: user.name, size: 20, color: kBlack),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: getChat.getMessage(user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return MessageTile(data: data, auth: auth);
                      },
                      separatorBuilder: (context, index) {
                        return kHeight10;
                      },
                      itemCount: snapshot.data!.docs.length),
                );
              },
            ),
            TextField(
              controller: messagectr,
              decoration: InputDecoration(
                  hintText: '    Messages...',
                  fillColor: kGrey,
                  filled: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        print(messagectr.text);
                        await getChat.sentMassage(messagectr.text, user.id);
                        messagectr.clear();
                      },
                      icon: Icon(Icons.send)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50))),
            )
          ],
        ),
      )),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.data,
    required this.auth,
  });

  final QueryDocumentSnapshot<Object?> data;
  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: data['receiver'] == auth.currentUser!.uid
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: data['receiver'] == auth.currentUser!.uid ? kOrange : kRed,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: textWidget(text: data['Message'], size: 15, color: kBlack),
          )),
    );
  }
}
