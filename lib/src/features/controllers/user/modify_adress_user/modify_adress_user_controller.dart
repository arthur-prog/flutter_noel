import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModifyUserAdressController extends GetxController {
  static ModifyUserAdressController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());


  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    // Récupérer les informations de l'utilisateur depuis Firestore
    FirebaseFirestore.instance
        .collection('usersAdress')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // Utiliser les données récupérées pour initialiser les champs de texte
        final Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        cityController.text = data['city'] ?? '';
        CPController.text = data['codepostal'].toString() ?? '';
        houseNumberController.text = data['housenumber'].toString() ?? '';
        streetController.text = data['street'] ?? '';
      }
    }).catchError((error) {
      print('Erreur lors de la récupération des données: $error');
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController CPController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

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

  void modifyUserAdress() async {
    if (formKey.currentState!.validate()) {
      int houseNumber = int.parse(houseNumberController.text);
      int codePostal = int.parse(CPController.text);

      Map<String, dynamic> data = {
        'housenumber': houseNumber,
        'street': streetController.text,
        'city': cityController.text,
        'codepostal': codePostal,
      };
      await _userRepository.modifyUserAdress(user, data);


    }
  }
}
