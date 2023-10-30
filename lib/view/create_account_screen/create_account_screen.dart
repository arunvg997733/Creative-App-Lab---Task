import 'package:chatapp/controller/auth_controller.dart';
import 'package:chatapp/core/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController confirmPassWord = TextEditingController();

  final getAuth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(text: 'Create Account', size: 25, color: kBlack),
              kHeight20,
              TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: kGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              kHeight20,
              TextField(
                controller: passWord,
                decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: kGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              kHeight20,
              TextField(
                controller: confirmPassWord,
                decoration: InputDecoration(
                    hintText: 'Confirm password',
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
                  getAuth.createAccount(
                      email.text, passWord.text, confirmPassWord.text);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [kRed, kOrange])),
                  child: Center(
                      child: textWidget(
                          text: 'Create',
                          size: 15,
                          color: kwhite,
                          weight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
