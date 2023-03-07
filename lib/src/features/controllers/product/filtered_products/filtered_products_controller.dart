
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/screens/product/product_details/product_details_screen.dart';
import 'package:flutter_noel/src/features/screens/product/product_searched/product_searched_screen.dart';
import 'package:get/get.dart';


class FilteredProductsController extends GetxController {
  static FilteredProductsController get instance => Get.find();

  void toProductSearched(){
    Get.to(() => ProductSearchedScreen());
  }

  void toProductDetails(Product product){
    Get.to(() => ProductDetailsScreen(product: product));
  }

  void back(){
    Get.back();
  }

}