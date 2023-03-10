import 'package:flutter/material.dart';
import 'package:flutter_noel/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());

  final GlobalKey<FormState >formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Rx<bool> isPasswordNotVisible = true.obs;

  void changePasswordVisibility(){
    isPasswordNotVisible.value = !isPasswordNotVisible.value;
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

  String? validatePassword(String value){
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.passwordIsRequired;
    }
    return null;
  }


  void loginUser() {
    if (formKey.currentState!.validate()) {
      _authRepository.signInWithEmailandPassword(emailController.text, passwordController.text);
    }
  }

}