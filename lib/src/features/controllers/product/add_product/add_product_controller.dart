import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/strings.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:flutter_noel/src/features/screens/product/admin/add_variant/add_variant_screen.dart';
import 'package:flutter_noel/src/features/screens/product/admin/product_list/product_list_screen.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());
  final productPictureRef = FirebaseStorage.instance.ref().child(productPictureFolder);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Rx<bool> isVariable = false.obs;
  Rx<bool> isColorSelected = true.obs;
  Rx<bool> isSizeSelected = false.obs;
  Rx<bool> isSameImageSelected = false.obs;

  Rx<File?> image = Rx<File?>(null);
  RxList<File?> variantImages = RxList<File?>([]);

  RxList<Variant> variants = RxList<Variant>([]);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Product? product;
  final List<Variant> oldVariants = [];

  void modifyVariant(index) async{
    final result = await Get.to(() => AddVariantScreen(
      color: isColorSelected.value,
      size: isSizeSelected.value,
      sameImage: isSameImageSelected.value,
      variant: variants[index],
      image: variantImages[index],
    ));
    if (result != null){
      variants[index]= result["variant"];
      if(result["image"] != null){
        variantImages[index]= result["image"];
      }
    }
  }

  void addValues(Product? thisProduct) async {
    if (thisProduct != null) {
      product = thisProduct;
      nameController.text = product!.name;
      descriptionController.text = product!.description;
      categoryController.text = product!.category;
      final variantList = await _productRepository.getVariants(product!);
      if(variantList.isNotEmpty){
        isVariable.value = true;
        if(variantList[0].color != ""){
          isColorSelected.value = true;
        } else {
          isColorSelected.value = false;
        }
        if(variantList[0].size != ""){
          isSizeSelected.value = true;
        } else {
          isSizeSelected.value = false;
        }
        if(variantList[0].urlPicture != ""){
          isSameImageSelected.value = false;
        } else {
          isSameImageSelected.value = true;
        }
        variants.value = variantList;
        oldVariants.addAll(variantList);
        //variant images
        for (int i = 0; i < variantList.length; i++){
          if(variantList[i].urlPicture != ""){
            final imageUrl = await getImageUrl(variantList[i].urlPicture!);
            File file = await urlToFile(imageUrl);
            variantImages.add(file);
          }
        }
      } else {
        priceController.text = product!.price.toString();
      }
    }
  }


  void selectImage() async {
    image.value = await buildShowModalBottomSheet();
  }

  void addVariant() async{
    final result = await Get.to(() => AddVariantScreen(
      color: isColorSelected.value,
      size: isSizeSelected.value,
      sameImage: isSameImageSelected.value,
    ));
    if (result != null){
      variants.add(result["variant"]);
      variantImages.add(result["image"]);
    }
  }

  void removeVariant(int index){
    variants.removeAt(index);
  }

  Future<void> storeProductImage(String productId) async {
    final idProductPictureRef = productPictureRef.child(productId);
    try {
      await idProductPictureRef.putFile(image.value!);
    } catch (e) {
      print("_storeImage error: $e");
    }
  }

  Future<void> storeVariantImages(String productId) async {
    for (int i = 0; i < variants.length; i++) {
      final idProductPictureRef = productPictureRef.child("$productId/${variants[i].id}");
      try {
        await idProductPictureRef.putFile(variantImages[i]!);
      } catch (e) {
        print("_storeImage error: $e");
      }
    }
  }

  void changeCategory(value) {
    categoryController.text = value;
  }

  void changeIsVariable(bool value) {
    isVariable.value = value;
  }

  void changeIsSameImageSelected(bool value) {
    isSameImageSelected.value = value;
  }

  void changeIsColorSelected(bool value) {
    if(!(value == false && isSizeSelected.value == false)){
      isColorSelected.value = value;
    }
  }

  void changeIsSizeSelected(bool value) {
    if(!(value == false && isColorSelected.value == false)){
      isSizeSelected.value = value;
    }
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
      var uuid = const Uuid();
      String id = uuid.v4();
      Product product = Product(
        id: id,
        name: nameController.text,
        description: descriptionController.text,
        category: categoryController.text,
        price: !isVariable.value ? double.parse(priceController.text) : null,
        urlPicture: !isVariable.value || (isVariable.value && isSameImageSelected.value) ? "$productPictureFolder/$id" : "$productPictureFolder/$id/${variants[0].id}",
      );
      await _productRepository.addProduct(product);
      if (isVariable.value){
        storeVariantImages(product.id);
        for (var variant in variants) {
          variant.urlPicture = "$productPictureFolder/${product.id}/${variant.id}";
          _productRepository.addVariant(product, variant);
        }
      } else {
        storeProductImage(product.id);
      }
      Get.to(() => ProductListScreen());
    }
  }

  void updateProduct() async{
    if (formKey.currentState!.validate()) {
      product!.name = nameController.text;
      product!.description = descriptionController.text;
      product!.category = categoryController.text;
      product!.price = !isVariable.value ? double.parse(priceController.text) : null;
      product!.urlPicture = !isVariable.value || (isVariable.value && isSameImageSelected.value) ? "$productPictureFolder/${product!.id}" : "$productPictureFolder/${product!.id}/${variants[0].id}";
      await _productRepository.updateProduct(product!);
      if(isVariable.value){
        if(variants == oldVariants){
          storeVariantImages(product!.id);
        } else {
          for (var variant in oldVariants) {
            deleteImage(variant.urlPicture!);
            _productRepository.deleteVariant(product!.id, variant.id);
          }
          storeVariantImages(product!.id);
          for (var variant in variants) {
            variant.urlPicture = "$productPictureFolder/${product!.id}/${variant.id}";
            _productRepository.addVariant(product!, variant);
          }
        }
      } else {
        storeProductImage(product!.id);
      }
      Get.to(() => ProductListScreen());
    }
  }
}
