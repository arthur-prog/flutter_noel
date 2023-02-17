import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String> getImage(String imageUrl) async {
  return await FirebaseStorage.instance
      .ref()
      .child(imageUrl)
      .getDownloadURL();
}