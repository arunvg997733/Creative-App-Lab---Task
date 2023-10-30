import 'package:chatapp/controller/auth_controller.dart';
import 'package:chatapp/core/constant.dart';
import 'package:chatapp/view/create_account_screen/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();

  final getAuth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kHeight30,
              textWidget(text: 'Login', size: 25, color: kBlack),
              kHeight20,
              TextField(
                controller: email,
                decoration:InputDecoration(
                  hintText: 'Email',
                  fillColor: kGrey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  )
                ) ,
              ),
              kHeight20,
              TextField(
                controller: passWord,
                decoration:InputDecoration(
                  hintText: 'PassWord',
                  fillColor: kGrey,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  )
                ) ,
              ),
              kHeight20,
              InkWell(
                onTap: () {
                  getAuth.login(email.text, passWord.text,context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      kRed,kOrange
                    ])
                  ),
                  child: Center(child: textWidget(text: 'Login', size: 15, color: kwhite,weight: FontWeight.bold)),
                ),
              ),
              kHeight20,
              InkWell(
                onTap: () {
                  print('A');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen(),));
                },
                child: textWidget(text: 'Create account', size: 15, color: kBlue)),
                kHeight20,
                textWidget(text: 'Or', size: 15, color: kBlack),
                kHeight20,
                InkWell(
                  onTap: () {
                    getAuth.googleSigning(context);
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(colors: [
                        kRed,kOrange
                      ])
                    ),
                    child: Center(child: textWidget(text: 'Google Signing', size: 15, color: kwhite,weight: FontWeight.bold)),
                  ),
                ),
      
      
            ],
          ),
        ),
      )),
    );
  }
}