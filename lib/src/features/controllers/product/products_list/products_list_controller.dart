import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_noel/src/constants/strings.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_noel/src/features/screens/product/product_details/product_details_screen.dart';

import '../../../models/Product.dart';


class ProductsListController extends GetxController {
  static ProductsListController get instance => Get.find();

  void toProductDetails(Product product){
    Get.to(() => ProductDetailsScreen(product: product));
  }
}