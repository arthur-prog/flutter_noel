import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/features/screens/home/home_screen.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProdileController extends GetxController {
  static EditProdileController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());


  User? user = FirebaseAuth.instance.currentUser;

  late UserData userData;

  @override
  void onInit() async {
    super.onInit();
    try {
      final thisUser = await _userRepository.getUserById(user!.uid);
      if(thisUser != null){
        userData = thisUser;

        if (userData.city != null) {
          if (userData.city != null) {
            cityController.text = userData.city!;
          }
          if (userData.codepostal != null) {
            CPController.text = userData.codepostal!.toString();
          }
          if (userData.housenumber != null) {
            houseNumberController.text = userData.housenumber!.toString();
          }
          if (userData.street != null) {
            streetController.text = userData.street!;
          }
          if (userData.name != null) {
            lastNameController.text = userData.name!;
          }
          if (userData.surname != null) {
            firstNameController.text = userData.surname!;
          }
        }
      } else {
        print("No user found");
        Get.back();
      }
    } catch (e) {
      print(e);
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController CPController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final regexPostCode = RegExp(r'^[0-9-]+$');
  final regexHouseNumber = RegExp(r'\d');
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

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

  void changeStreet(value) {
    streetController.value = value;
  }

  String? validateStreet(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.streetIsRequired;
    }
    return null;
  }

  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.firstNameIsRequired;
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.lastNameIsRequired;
    }
    return null;
  }

  void updateProfile() async {
    if (formKey.currentState!.validate()) {
      int houseNumber = int.parse(houseNumberController.text);
      int codePostal = int.parse(CPController.text);

      userData.city = cityController.text;
      userData.codepostal = codePostal;
      userData.housenumber = houseNumber;
      userData.street = streetController.text;
      userData.name = lastNameController.text;
      userData.surname = firstNameController.text;

      await _userRepository.updateUser(userData);

      Get.to(() => HomeScreen());
    }
  }
}
