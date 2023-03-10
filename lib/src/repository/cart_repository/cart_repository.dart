import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/models/Cart.dart';
import 'package:flutter_noel/src/features/models/CartProduct.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/features/screens/home/home_screen.dart';
import 'package:get/get.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final cartCollection = FirebaseFirestore.instance.collection('cart');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(String email, Cart cart) async {
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
      cart.id = user.uid;
      await cartCollection.doc(user.uid).set(cart.toMap());
    }
  }

  Future<void> addProductToCart(
      CartProduct cartProduct, Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');

    final cartProductsDoc = cartProductsCollection.doc(product.id);
    final cartProductsSnapshot = await cartProductsDoc.get();

    if (cartProductsSnapshot.exists) {
      print("Le produit est déjà dans le panier.");
    } else {
      await cartProductsDoc
          .set(cartProduct.toMap())
          .then((value) => print("Le produit a été ajouté au panier."))
          .catchError(
              (error) => print("Impossible d'ajouter le produit : $error"));
    }
  }

  Future<void> removeProductFromCart(CartProduct cartProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');

    final cartProductsDoc = cartProductsCollection.doc(cartProduct.product?.id);
    await cartProductsDoc.delete();
  }

  Future<void> incrementQuantity(CartProduct cartProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');
    final cartProductsDoc = cartProductsCollection.doc(cartProduct.product?.id);

    int currentQuantity = cartProduct.quantity;
    await cartProductsDoc.update({
      'quantity': currentQuantity + 1,
    });
  }

  Future<void> decrementQuantity(CartProduct cartProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');

    final cartProductsDoc = cartProductsCollection.doc(cartProduct.product?.id);

    int currentQuantity = cartProduct.quantity ?? 0;

    if (currentQuantity > 1) {
      await cartProductsDoc.update({
        'quantity': currentQuantity - 1,
      });
    } else {
      await cartProductsDoc.delete();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCartProductsSnapshots() {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc =
        FirebaseFirestore.instance.collection('cart').doc(user?.uid);
    final cartProductsCollection = cartDoc.collection('cartProducts');
    print(cartProductsCollection.snapshots());
    return cartProductsCollection.snapshots();
  }
}
