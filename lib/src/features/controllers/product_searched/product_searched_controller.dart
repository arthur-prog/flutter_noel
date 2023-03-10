import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_noel/src/common_widgets/no_image/NoImageWidget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/product/WIdgets/CardProductWidget.dart';
import 'package:flutter_noel/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_noel/src/features/screens/product/product_details/product_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';



class ProductSearchedController extends GetxController {
  static ProductSearchedController get instance => Get.find();

  TextEditingController productController = TextEditingController();
  StreamController<String> productStream = StreamController<String>();

  void toProductDetails(Product product){
    Get.to(() => ProductDetailsScreen(product: product));
  }

  void back(){
    Get.back();
  }

  SizedBox buildProducts(
      ProductSearchedController controller,
      BuildContext context,
      List<Product> products
      ){
    List<Widget> children = [];

    products.forEach((product) {
      children.add(
          GestureDetector(
            onTap: () {controller.toProductDetails(product);},
            child: CardProductWidget(product: product, margin: 5,),
          )
      );
    });
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.2,
      child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1
          ),
          children: children
      ),
    );
  }
}