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
import 'package:uuid/uuid.dart';

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

    final cartProductsDoc;

    if (cartProduct.variant != null){
      cartProductsDoc = cartProductsCollection.doc(cartProduct.variant?.id);
    }
    else{
      cartProductsDoc = cartProductsCollection.doc(product.id);
    }
    final cartProductsSnapshot = await cartProductsDoc.get();

    if (cartProductsSnapshot.exists) {
      print("Le produit est déjà dans le panier.");
    } else {
      await cartProductsDoc
          .set(cartProduct.toMap())
          .whenComplete(
            () => SnackBarInformationWidget(
          text: AppLocalizations.of(Get.context!)!.addedToCart,
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

  Future<void> removeProductFromCart(CartProduct cartProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');

    final cartProductsDoc;
    if(cartProduct.variant != null){
      cartProductsDoc = cartProductsCollection.doc(cartProduct.variant?.id);
    }
    else{
      cartProductsDoc = cartProductsCollection.doc(cartProduct.product?.id);
    }
    await cartProductsDoc.delete();
  }

  Future<void> incrementQuantity(CartProduct cartProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');
    final cartProductsDoc;
    if(cartProduct.variant != null){
      cartProductsDoc = cartProductsCollection.doc(cartProduct.variant?.id);
    }
    else{
      cartProductsDoc = cartProductsCollection.doc(cartProduct.product?.id);
    }
    int currentQuantity = cartProduct.quantity;
    await cartProductsDoc.update({
      'quantity': currentQuantity + 1,
    });
  }

  Future<void> decrementQuantity(CartProduct cartProduct) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');

    final cartProductsDoc;
    if(cartProduct.variant != null){
      cartProductsDoc = cartProductsCollection.doc(cartProduct.variant?.id);
    }
    else{
      cartProductsDoc = cartProductsCollection.doc(cartProduct.product?.id);
    }
    int currentQuantity = cartProduct.quantity ?? 0;

    if (currentQuantity > 1) {
      await cartProductsDoc.update({
        'quantity': currentQuantity - 1,
      });
    } else {
      await cartProductsDoc.delete();
    }
  }

  Future<void> deleteCart(String cartProductId) {
    final cartProductDoc = cartCollection.doc(cartProductId);
    return cartProductDoc.delete().whenComplete(() => print('YESSSSSSSSSSSSSSSSSSSSSS'))
        .catchError((error, stackTrace) {
      SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(error.toString());
    });
  }

  Future<void> deleteCartProduct(String cartProductId, String userId) {
    final cartDoc = cartCollection.doc(userId);
    final cartProductDoc = cartDoc.collection('cartProducts').doc(cartProductId);
    return cartProductDoc.delete().whenComplete(() => print('YESSSSSSSSSSSSSSSSSSSSSS'))
        .catchError((error, stackTrace) {
      SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.somethingWentWrong,
        title: AppLocalizations.of(Get.context!)!.error,
        type: "error",
      );
      print(error.toString());
    });
  }

  Future<void> createCart() async {
    final cartDoc = FirebaseFirestore.instance.doc('cart/1');
    cartDoc.set({'title' : 'GNEU'});
  }


  Future<void> validateOrder(double total) async {
    var uuid = const Uuid();
    var id = uuid.v4();
    final user = FirebaseAuth.instance.currentUser;

    final cartDoc = FirebaseFirestore.instance.doc('cart/${user?.uid}');
    final cartProductsCollection = cartDoc.collection('cartProducts');

    final ordersProductDoc =  FirebaseFirestore.instance.doc('orders/${user?.uid}/order/${id}');
    final orderProductCollection = ordersProductDoc.collection('orderProducts');

    await cartProductsCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((productDoc) {
        orderProductCollection.doc(productDoc.id).set(productDoc.data());
        deleteCartProduct(productDoc.id ,user!.uid);

      });
    });

    await ordersProductDoc.set({
      'totalPrice': total,
    });



  }

  List<double> calculTotal(AsyncSnapshot<dynamic> productsSnapshot)  {
    double price = 0;
    double fizz = 0;
    productsSnapshot.data!.docs.forEach((doc) {
      Map<String, dynamic> productJson = doc.data();
      CartProduct cartProduct = CartProduct.fromMap(productJson);
      if (cartProduct.variant == null) {
        price += cartProduct.product!.price! * cartProduct.quantity;
      } else {
        price += cartProduct.variant!.price * cartProduct.quantity;
      }
      if(cartProduct.product!.category == 'glove'){
        fizz += 1.50 * cartProduct.quantity;
      }
      else if(cartProduct.product!.category == 'sweater'){
        fizz += 3 * cartProduct.quantity;
      }
      else if(cartProduct.product!.category == 'hat'){
        fizz += 2 * cartProduct.quantity;
      }
    });
    double total = price + fizz;
    return [total, price, fizz];
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
