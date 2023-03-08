import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_noel/src/common_widgets/snackbar/snackbar_information_widget.dart';
import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final productsCollection = FirebaseFirestore.instance.collection('products');

  Future<void> addVariant(Product product, Variant variant) async {
    final productDoc = FirebaseFirestore.instance.doc('products/${product.id}');
    final variantsCollection = productDoc.collection('variants');

    final variantDoc = variantsCollection.doc(variant.id);
    await variantDoc
        .set(variant.toMap())
        .then((value) => print("Variant added"))
        .catchError(
            (error) => print("Failed to add variant: $error"));
  }

  Future<List<Variant>> getVariants(Product product) async {
    List<Variant> variants = [];
    final productDoc = FirebaseFirestore.instance.doc('products/${product.id}');
    final variantsCollection = productDoc.collection('variants');

    QuerySnapshot<Object?> query = await variantsCollection.get();
    if (query.docs.isNotEmpty) {
      for (var variant in query.docs) {
        final variantJson = variant.data() as Map<String, dynamic>;
        variants.add(Variant.fromMap(variantJson));
      }
    }
    return variants;
  }

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

  Future<void> deleteProduct(String productId) {
    final productDoc = productsCollection.doc(productId);
    return productDoc.delete().whenComplete(
          () => SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.deletedProduct,
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

  Future<void> deleteVariant(String productId, String variantId){
    final productDoc = FirebaseFirestore.instance.doc('products/$productId');
    final variantsCollection = productDoc.collection('variants');
    final variantDoc = variantsCollection.doc(variantId);
    return variantDoc.delete()
        .catchError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> updateProduct(Product product) {
    final productDoc = productsCollection.doc(product.id);
    return productDoc.update(product.toMap())
        .whenComplete(
          () => SnackBarInformationWidget(
        text: AppLocalizations.of(Get.context!)!.updatedProduct,
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsSnapshotsByCategories(String category) {
    if(category == ''){
      return productsCollection.snapshots();
    }
    else {
      return productsCollection.where('category', isEqualTo: category).snapshots();
    }
  }

  Future<Product?> getProductById(String productId) async {
    try {
      final result = await productsCollection.doc(productId).get();
      final productJson = result.data() as Map<String, dynamic>;
      return Product.fromMap(productJson);
    } catch (e) {
        print(e);
        return null;
    }
  }

  Future<List<Product>> getProductsStartsByProductName(String productName) async {
    List<Product> products = [];
    QuerySnapshot<Object?> query = await productsCollection.where('name', isEqualTo: productName).get();
    if (query.docs.isNotEmpty) {
      for (var product in query.docs) {
        final productJson = product.data() as Map<String, dynamic>;
        products.add(Product.fromMap(productJson));
      }
    }
    return products;
  }

}