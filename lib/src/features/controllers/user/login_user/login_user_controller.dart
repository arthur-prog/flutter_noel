import 'package:flutter/material.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginUserController extends GetxController{
  static LoginUserController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());


  final GlobalKey<FormState >formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void changeEmail(value){
    emailController.value = value;
  }

  String? validateEmail(String value){
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.emailIsRequired;
    }
    else if(!emailRegex.hasMatch(value)){
      print('allo');
      return AppLocalizations.of(Get.context!)!.validEmailIsRequired;
    }
    return null;
  }

  void changePassword(value){
    passwordController.value = value;
  }

  String? validatePassword(String value){
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.passwordIsRequired;
    }
    return null;
  }


  void loginUser() async {
    if (formKey.currentState!.validate()) {
      await _userRepository.loginUser(emailController, passwordController);
    }
  }

}