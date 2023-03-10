import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/repository/cart_repository/cart_repository.dart';
import 'package:flutter_noel/src/repository/favorite_repository/favorite_repository.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductUserController extends GetxController {
  static ProductUserController get instance => Get.find();

  final _favoriteRepository = Get.put(CartRepository());

  void removeProductFromCart(CartProduct cartProduct) async {
    await _favoriteRepository.removeProductFromCart(cartProduct);
  }
  void incrementQuantity(CartProduct cartProduct) async {
    await _favoriteRepository.incrementQuantity(cartProduct);
  }
  void decrementQuantity(CartProduct cartProduct) async {
    await _favoriteRepository.decrementQuantity(cartProduct);
  }
}