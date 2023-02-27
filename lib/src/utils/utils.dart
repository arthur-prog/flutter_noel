import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_noel/src/common_widgets/modal_bottom_sheet/modal_btn_widget.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<File> urlToFile(String imageUrl) async {
  var rng = Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.png');
  Uri uri = Uri.parse(imageUrl);
  http.Response response = await http.get(uri);
  await file.writeAsBytes(response.bodyBytes);
  return file;
}

Future<String> getImageUrl(String imageUrl) async {
  return await FirebaseStorage.instance
      .ref()
      .child(imageUrl)
      .getDownloadURL();
}

Future<void> deleteImage(String imageUrl) async {
  return await FirebaseStorage.instance.refFromURL(imageUrl).delete();
}

Future<File?> cropImage({required File imageFile}) async {
  CroppedFile? croppedImage =
  await ImageCropper().cropImage(sourcePath: imageFile.path);
  if (croppedImage == null) return null;
  return File(croppedImage.path);
}

Future<File?> pickImage(ImageSource source) async {
  try {
    final thisImg = await ImagePicker().pickImage(source: source);
    if (thisImg == null) return null;
    File? img = File(thisImg.path);
    img = await cropImage(imageFile: img);
    return img;
  } on PlatformException catch (e) {
    print(e);
    Navigator.of(Get.context!).pop();
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
                Get.back(result: pickImage(ImageSource.gallery));
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
                Get.back(result: pickImage(ImageSource.camera));
              },
            ),
          ],
        ),
      ));
}