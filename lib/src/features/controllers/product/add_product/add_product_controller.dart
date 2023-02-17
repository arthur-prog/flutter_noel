import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_noel/src/common_widgets/modal_bottom_sheet/modal_btn_widget.dart';
import 'package:flutter_noel/src/constants/strings.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductController extends GetxController {
  static AddProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Rx<bool> isVariable = false.obs;
  Rx<bool> isColorSelected = true.obs;
  Rx<bool> isSizeSelected = false.obs;

  Rx<File?> image = Rx<File?>(null);

  // RxList<Product> variants = <Product>[].obs;
  // RxList<TextEditingController> variantParametersController = <TextEditingController>[].obs;

  final productPictureRef = FirebaseStorage.instance.ref().child(productPictureFolder);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final thisImg = await ImagePicker().pickImage(source: source);
      if (thisImg == null) return;
      File? img = File(thisImg.path);
      img = await cropImage(imageFile: img);
      image.value = img;
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(Get.context!).pop();
    }
  }

  Future<void> storeImage(String productId) async {
    final idProductPictureRef = productPictureRef.child(productId);
    try {
      await idProductPictureRef.putFile(image.value!);
    } catch (e) {
      print("_storeImage error: $e");
    }
  }

  Future buildShowModalBottomSheet(){
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: Get.context!,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.selectPhotoTitle,
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                AppLocalizations.of(context)!.selectPhotoSubTitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 30,
              ),
              ModalBtnWidget(
                icon: Icons.image,
                iconSize: 40,
                title: AppLocalizations.of(context)!.galleryTitle,
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ModalBtnWidget(
                icon: Icons.camera_alt_outlined,
                iconSize: 40,
                title: AppLocalizations.of(context)!.cameraTitle,
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        ));
  }

  void changeCategory(value) {
    categoryController.text = value;
  }

  void changeIsVariable(bool value) {
    isVariable.value = value;
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
        price: double.parse(priceController.text),
        urlPicture: "$productPictureFolder/$id",
      );
      await _productRepository.addProduct(product);
      storeImage(product.id);
    }
  }
}
