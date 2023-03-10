import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/Cart.dart';
import 'package:flutter_noel/src/features/models/Favorite.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter_noel/src/repository/favorite_repository/favorite_repository.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:flutter_noel/src/repository/cart_repository/cart_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationUserController extends GetxController {
  static RegistrationUserController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _cartRepository = Get.put(CartRepository());
  final _favoriteRepository = Get.put(FavoriteRepository());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController CPController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  final regexPostCode = RegExp(r'^[0-9-]+$');
  final regexHouseNumber = RegExp(r'\d');
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');


  void changeEmail(value) {
    emailController.value = value;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.emailIsRequired;
    }
    else if (!emailRegex.hasMatch(value)){
      return AppLocalizations.of(Get.context!)!.validEmailIsRequired;
    }
    return null;
  }

  void changePassword(value) {
    passwordController.value = value;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.passwordIsRequired;
    }
    else if (value.length <6){
      return AppLocalizations.of(Get.context!)!.validPasswordIsRequired;
    }
    return null;
  }

  void changeCity(value) {
    cityController.value = value;
  }

  String? validateCity(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.cityIsRequired;
    }
    return null;
  }

  void changeCP(value) {
    CPController.value = value;
  }

  String? validateCP(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.postCodeIsRequired;
    }
    else if(!regexPostCode.hasMatch(value)){
      return AppLocalizations.of(Get.context!)!.validPostCodeIsRequired;
    }
    return null;
  }

  void changeHouseNumber(value) {
    houseNumberController.value = value;
  }

  String? validateHouseNumber(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.houseNumberIsRequired;
    }
    else if (!regexHouseNumber.hasMatch(value)){
      return AppLocalizations.of(Get.context!)!.validHouseNumberIsRequired;
    }
    return null;
  }

  void changeName(value) {
    nameController.value = value;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.userNameIsRequired;
    }
    return null;
  }

  void changeSurname(value) {
    surnameController.value = value;
  }

  String? validateSurname(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.userSurnameIsRequired;
    }
    return null;
  }

  void changeStreet(value) {
    streetController.value = value;
  }

  String? validateStreet(String value) {
    if (value.isEmpty) {
      return 'dsqd';
    }
    return null;
  }

  void addUser() async {
    if (formKey.currentState!.validate()) {
      int houseNumber = int.parse(houseNumberController.text);
      int codePostal = int.parse(CPController.text);

      UserData userData = UserData(
        id: '',
        email: emailController.text,
        isAdmin: false,
        name : nameController.text,
        surname : surnameController.text,
        housenumber: houseNumber,
        street: streetController.text,
        city: cityController.text,
        codepostal: codePostal,
      );

      _authRepository.createUserWithEmailandPassword(passwordController.text, userData);

      Cart cart = Cart(
        id: '',
      );

      await _cartRepository.addUser(emailController.text, cart);

      Favorite favorite = Favorite(id: '');

      await _favoriteRepository.addUser(emailController.text, favorite);
    }
  }
}
