import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/strings.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddVariantController extends GetxController {
  static AddVariantController get instance => Get.find();

  final TextEditingController colorController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Rx<File?> image = Rx<File?>(null);

  final productPictureRef = FirebaseStorage.instance.ref().child(productPictureFolder);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void addValues(Variant? variant, File? image) async {
    if (variant != null) {
      if(variant.color != null){
        if(colorController.text.isEmpty) {
          colorController.text = variant.color!;
        }
      }
      if(variant.size != null){
        if(sizeController.text.isEmpty) {
          sizeController.text = variant.size!;
        }
      }
      if(priceController.text.isEmpty){
        priceController.text = variant.price.toString();
      }
    }
    if(image != null){
      if(this.image.value == null) {
        this.image.value = image;
      }
    }
  }

  void selectImage() async {
    image.value = await buildShowModalBottomSheet();
  }

  String? validateColor(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.colorIsRequired;
    }
    return null;
  }

  String? validateSize(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.sizeIsRequired;
    }
    return null;
  }

  String? validatePrice(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.priceIsRequired;
    }
    return null;
  }

  void addVariant() async {
    if (formKey.currentState!.validate()) {
      var uuid = const Uuid();
      String id = uuid.v4();
      Variant variant = Variant(
        id: id,
        color: colorController.text,
        size: sizeController.text,
        price: double.parse(priceController.text),
      );
      final result = {
        "variant": variant,
        "image": image.value,
      };
      Get.back(result: result);
    }
  }
}
