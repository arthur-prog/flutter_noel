import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';


class ProductDetailsController extends GetxController {
  static ProductDetailsController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  void back(){
    Get.back();
  }

}