import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Rx<bool> isVariable = false.obs;

  RxList<Product> variants = <Product>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeCategory(value) {
    categoryController.text = value;
  }

  void changeIsVariable(bool value) {
    isVariable.value = value;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.nameIsRequired;
    }
    return null;
  }

  String? validateDescription(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.descriptionIsRequired;
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null) {
      return AppLocalizations.of(Get.context!)!.categoryIsRequired;
    }
    return null;
  }

  String? validatePrice(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(Get.context!)!.priceIsRequired;
    }
    return null;
  }

  void addProduct() async {
    if (formKey.currentState!.validate()) {
      Product product = Product(
        name: nameController.text,
        description: descriptionController.text,
        category: categoryController.text,
        price: double.parse(priceController.text),
        urlPicture: "",
      );
      await _productRepository.addProduct(product);
    }
  }
}
