import 'package:flutter/material.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/repository/favorite_repository/favorite_repository.dart';
import 'package:flutter_noel/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteUserController extends GetxController {
  static FavoriteUserController get instance => Get.find();

  final _favoriteRepository = Get.put(FavoriteRepository());

  void removeProductFromFavorite(FavoriteProduct favoriteProduct) async {
    await _favoriteRepository.removeProductFromFavorite(favoriteProduct);
  }
}
