import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/user/favorite_user/favorite_user_controller.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/features/screens/user/favorite/Widgets/ProductLineFavoriteWidget.dart';
import 'package:flutter_noel/src/repository/favorite_repository/favorite_repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FavoriteUserScreen extends StatelessWidget {
  FavoriteUserScreen({Key? key}) : super(key: key);

  final _favoriteRepository = Get.put(FavoriteRepository());

  final _controller = Get.put(FavoriteUserController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: isDark ? Theme.of(context).cardColor : primaryColor,
          title: Text(AppLocalizations.of(context)!.favorites),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder(
                stream: _favoriteRepository.getFavoriteProductsSnapshots(),
                builder: (BuildContext context, AsyncSnapshot productsSnapshot) {
                  List<Widget> children = [];
                  if (productsSnapshot.hasData) {
                    if (productsSnapshot.data!.docs.isEmpty) {
                      return Center(child: Text(AppLocalizations.of(context)!.noProducts));
                    } else {
                      productsSnapshot.data!.docs.forEach((doc) {
                        Map<String, dynamic> productJson = doc.data();
                        FavoriteProduct favoriteProduct = FavoriteProduct.fromMap(productJson);
                        children.add(
                          ProductLineFavoriteWidget(favoriteProduct: favoriteProduct, removeProduct: () => _controller.removeProductFromFavorite(favoriteProduct),)
                        );
                      });
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: children,
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}
