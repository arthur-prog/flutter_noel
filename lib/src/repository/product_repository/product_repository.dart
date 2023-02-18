import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final productsCollection = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(Product product){
    final productDoc = productsCollection.doc(product.id);
    return productDoc.set(product.toMap())
        .whenComplete(
          () => SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.createdProduct,
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsSnapshots() {
    return productsCollection.snapshots();
  }

}