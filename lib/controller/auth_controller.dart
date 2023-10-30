import 'package:chatapp/model/userModel.dart';
import 'package:chatapp/view/create_user/create_user.dart';
import 'package:chatapp/view/home_screen.dart/home_screen.dart';
import 'package:chatapp/view/loging_screen.dart/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firebasestore = FirebaseFirestore.instance;
  List<UserModel> userList = [];
  final GoogleSignIn google = GoogleSignIn();

  userstatus(BuildContext context) async {
    if (auth.currentUser == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    } else {
      final allUserData = await FirebaseFirestore.instance
          .collection('AllUser')
          .doc(auth.currentUser!.uid)
          .get();
      if (!allUserData.exists) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUserScreen(),
            ));
      } 
      else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
      }
    }
  }

  createAccount(String email, String passWord, String confirm) async {
    try {
      if (email.isEmpty || passWord.isEmpty || confirm.isEmpty) {
        Get.snackbar("Warning", 'Please fill all the field');
      } else if (passWord != confirm) {
        Get.snackbar("Warning", 'Please enter password correctly');
      } else {
        await auth.createUserWithEmailAndPassword(
            email: email, password: passWord);
        Get.offAll(LoginScreen());
        Get.snackbar("Success", 'User Created');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  login(String email, String passWord, BuildContext context) async {
    try {
      if (email.isEmpty || passWord.isEmpty) {
        Get.snackbar('Warning', 'Please fill all the field');
      } else {
        await auth.signInWithEmailAndPassword(email: email, password: passWord);
        userstatus(context);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  googleSigning(BuildContext context) async {
    final GoogleSignInAccount? googlesignin = await google.signIn();
    if (googlesignin != null) {
      final GoogleSignInAuthentication googlesigninauth =
          await googlesignin.authentication;
      final AuthCredential authcredential = GoogleAuthProvider.credential(
          accessToken: googlesigninauth.accessToken,
          idToken: googlesigninauth.idToken);

      await auth.signInWithCredential(authcredential);
      userstatus(context);
    }
  }

  addUser(String name) {
    final userData = {
      'Name': auth.currentUser!.displayName,
      'Email': auth.currentUser!.email,
      'Id': auth.currentUser!.uid
    };
    FirebaseFirestore.instance
        .collection('AllUser')
        .doc(auth.currentUser!.uid)
        .set(userData);
    Get.snackbar("Success", 'Name added');
    Get.offAll(HomeScreen());
  }

  signOut() {
    try {
      auth.signOut();
      google.signOut();
      Get.offAll(LoginScreen());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  getUserList() async {
    userList.clear();
    final userdata = await firebasestore.collection('AllUser').get();

    for (var element in userdata.docs) {
      final data = UserModel(
          name: element['Name'], email: element['Email'], id: element['Id']);
      if (element['Id'] != auth.currentUser!.uid) {
        userList.add(data);
      }
    }
    update();
  }
}
