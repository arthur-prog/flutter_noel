import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_noel/src/features/models/Cart.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/repository/cart_repository/cart_repository.dart';
import 'package:flutter_noel/src/repository/favorite_repository/favorite_repository.dart';
import 'package:flutter_noel/src/repository/product_repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';



class ProductDetailsController extends GetxController {
  static ProductDetailsController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());
  final _cartRepository = Get.put(CartRepository());
  final _favoriteRepository = Get.put(FavoriteRepository());

  void back() {
    Get.back();
  }

  void addProductToCart(Product product) async {
    var uuid = const Uuid();
    CartProduct cartProduct = CartProduct(product: product, quantity: 1, id : uuid.v4());
    await _cartRepository.addProductToCart(cartProduct, product);
  }

  void addProductToFavorite(Product product) async {
    var uuid = const Uuid();
    FavoriteProduct favoriteProduct = FavoriteProduct(product: product, id : uuid.v4(), variant: null);
    await _favoriteRepository.addProductToFavorite(favoriteProduct, product);
  }
}
