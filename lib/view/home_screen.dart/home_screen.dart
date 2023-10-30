import 'package:chatapp/controller/auth_controller.dart';
import 'package:chatapp/core/constant.dart';
import 'package:chatapp/view/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final getAuth = Get.put(AuthController());
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    getAuth.getUserList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        centerTitle: true,
        title: textWidget(text: 'Messages', size: 20, color: kBlack),
        actions: [
          IconButton(
              onPressed: () {
                getAuth.signOut();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: kBlack,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: GetBuilder<AuthController>(
            builder: (controller) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final data = controller.userList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      onTap: () {
                        Get.to(ChatScreen(
                          user: data,
                        ));
                      },
                      title:
                          textWidget(text: data.name, size: 15, color: kBlack),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: getAuth.userList.length);
            },
          ))
        ],
      )),
    );
  }
}
