import 'package:chatapp/controller/auth_controller.dart';
import 'package:chatapp/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({super.key});

  TextEditingController name = TextEditingController();

  final getAuth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    name.text = getAuth.auth.currentUser!.displayName!;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            kHeight30,
            textWidget(text: 'Create Account', size: 25, color: kBlack),
            kHeight20,
            TextField(
              controller: name,
              decoration: InputDecoration(
                  hintText: 'Name',
                  fillColor: kGrey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            kHeight20,
            InkWell(
              onTap: () {
                getAuth.addUser(name.text);
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [kRed, kOrange])),
                child: Center(
                    child: textWidget(
                        text: 'Submit',
                        size: 15,
                        color: kwhite,
                        weight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
