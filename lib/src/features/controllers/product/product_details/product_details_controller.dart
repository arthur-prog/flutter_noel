
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductDetailsController extends GetxController {
  static ProductDetailsController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());
  Rx<String> image = ''.obs;
  Rx<String> price = ''.obs;

  void back(){
    Get.back();
  }

  void displayVariant(Variant variant) async{
    image.value = variant.urlPicture!;
    price.value = variant.price.toString();
  }

  ListView buildVariants(
      List<Variant> variants
      )
  {
    List<Widget> children = [];

    variants.forEach((variant) {
      children.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              height: 200,
              child: FutureBuilder(
                  future: getImageUrl(variant.urlPicture!),
                  builder: (BuildContext context,
                      AsyncSnapshot imageSnapshot) {
                    if (imageSnapshot.connectionState ==
                        ConnectionState.done) {
                      if (imageSnapshot.hasData) {
                        return ListTile(
                          leading: Image.network(
                            imageSnapshot.data,
                          ),
                          title: variant.color!.isNotEmpty ? Text(variant.color!) : Text(variant.size!),
                          subtitle: variant.size!.isNotEmpty ? Text(variant.size!) : const Text(''),
                          onTap: () {displayVariant(variant);},
                        );
                      } else {
                        return ListTile(
                          leading: const NoImageWidget(height: 75, width: 75),
                          title: variant.color!.isNotEmpty ? Text(variant.color!) : Text('Taille'),
                          subtitle: variant.size!.isNotEmpty ? Text(variant.size!) : const Text(''),
                          onTap: () {displayVariant(variant);},
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
              ),
            ),
          )
      );
    });
    return ListView(
            scrollDirection: Axis.horizontal,
            children: children,
    );
  }
}