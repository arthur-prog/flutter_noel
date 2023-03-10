import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/features/screens/home/home_screen.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUser(UserData user, String email, String password, String name, String surname) async {
    try {
     UserCredential userCredential =  await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
     await userCredential.user!.updateDisplayName('$name $surname');
     user.id = userCredential.user!.uid;
      Map<String, dynamic> userMap = user.toMap();
      await usersCollection.doc(userCredential.user!.uid).set(userMap);
    } catch (error) {
      SnackBarInformationWidget(
        text: 'mail déja utilisé',
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(error.toString());
    }
  }

  Future<void> loginUser(
      TextEditingController email, TextEditingController password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        SnackBarInformationWidget(
          text: AppLocalizations.of(Get.context!)!.connectionMessage,
          title: AppLocalizations.of(Get.context!)!.connectionDone,
          type: "success",
        );
        Get.to(HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarInformationWidget(
          text: AppLocalizations.of(Get.context!)!.connectionMessage,
          title: AppLocalizations.of(Get.context!)!.connectionEmailWrong,
          type: "error",
        );
      } else if (e.code == 'wrong-password') {
        SnackBarInformationWidget(
          text: AppLocalizations.of(Get.context!)!.connectionMessage,
          title: AppLocalizations.of(Get.context!)!.connectionPasswordWrong,
          type: "error",
        );
      }
    }
  }

  Future<void> modifyUserAdress(User? user, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('usersAdress')
          .doc(user?.uid)
          .set(data, SetOptions(merge: true));
      SnackBarInformationWidget(
        text: 'c ok',
        title: AppLocalizations.of(Get.context!)!.success,
        type: "success",
      );
    } catch (error) {
      SnackBarInformationWidget(
        text: 'mail déja utilisé',
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(error.toString());
    }

  }
}
