import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/models/Cart.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/Favorite.dart';
import 'package:flutter_noel/src/features/models/FavoriteProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:flutter_noel/src/features/screens/home/home_screen.dart';
import 'package:get/get.dart';


class FavoriteRepository extends GetxController {
  static FavoriteRepository get instance => Get.find();

  final favoriteCollection = FirebaseFirestore.instance.collection('favorite');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(String email, Favorite favorite) async {
    User? user = await auth.fetchSignInMethodsForEmail(email).then((value) {
      if (value.isEmpty) {
        return null;
      } else {
        return auth.currentUser!;
      }
    });
    if (user == null) {
      return null;
    } else {
      favorite.id = user.uid;
      await favoriteCollection.doc(user.uid).set(favorite.toMap());
    }
  }

  Future<void> addProductToFavorite(FavoriteProduct favoriteProduct, Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('favorite/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('favoriteProducts');
    final cartProductsDoc;

    if (favoriteProduct.variant != null){
      cartProductsDoc = cartProductsCollection.doc(favoriteProduct.variant?.id);
    }
    else{
      cartProductsDoc = cartProductsCollection.doc(product.id);
    }
    final cartProductsSnapshot = await cartProductsDoc.get();

    if (cartProductsSnapshot.exists) {
      print("Le produit est déjà dans le favoris.");
    }
    else {
      await cartProductsDoc
          .set(favoriteProduct.toMap())
          .whenComplete(
            () => SnackBarInformationWidget(
          text: AppLocalizations.of(Get.context!)!.addedToFavorite,
          title: AppLocalizations.of(Get.context!)!.success,
          type: "success",
        ),
      )
          .catchError((error, stackTrace) {
        SnackBarInformationWidget(
          text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
          title: AppLocalizations.of(Get.context!)!.error,
          type: "error",
        );
        print(error.toString());
      });
    }
  }

  Future<void> removeProductFromFavorite(FavoriteProduct favoriteProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final favoriteDoc = FirebaseFirestore.instance.doc('favorite/${user?.uid}');
    final favoriteProductsCollection = favoriteDoc.collection('favoriteProducts');
    final favoriteProductDoc;
   if(favoriteProduct.variant != null){
     favoriteProductDoc = favoriteProductsCollection.doc(favoriteProduct.variant?.id);
   }
   else{
     favoriteProductDoc = favoriteProductsCollection.doc(favoriteProduct.product?.id);
   }
    await favoriteProductDoc.delete();
  }



  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteProductsSnapshots() {

    final user = FirebaseAuth.instance.currentUser;
    final favoritesDocRef =
    FirebaseFirestore.instance.collection('favorite').doc(user?.uid);
    final favoritesCollectionRef = favoritesDocRef.collection('favoriteProducts');
    print(favoritesCollectionRef.snapshots());
    return favoritesCollectionRef.snapshots();

  }

}