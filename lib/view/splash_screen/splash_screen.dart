import 'dart:async';

import 'package:chatapp/controller/auth_controller.dart';
import 'package:chatapp/core/constant.dart';
import 'package:chatapp/view/loging_screen.dart/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  final getAuth = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      getAuth.userstatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: textWidget(
            text: "Chat app", size: 30, color: kBlack, weight: FontWeight.bold),
      ),
    );
  }
}
