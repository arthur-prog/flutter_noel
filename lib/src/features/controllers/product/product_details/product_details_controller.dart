import 'package:get/get.dart';

import '../../../../repository/product_repository/product_repository.dart';
import '../../../models/Product.dart';

class ProductDetailsController extends GetxController {
  static ProductDetailsController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  void back(){
    Get.back();
  }

}