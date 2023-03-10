import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';

class FavoriteProduct {
  String id;
  Product? product;
  Variant? variant;

  FavoriteProduct(
      {required this.id, required this.product, required this.variant});

  factory FavoriteProduct.fromMap(Map<String, dynamic> map) {
    return FavoriteProduct(
        id: map['id'] ?? "",
        product: map['product'] != null ? Product.fromMap(map['product']) : null,
        variant:map['variant'] != null ? Variant.fromMap(map['variant']) : null
    );
  }

  Map<String, dynamic> toMap() {
    if(product != null) {
      if(variant == null) {
        return {'product': product!.toMap(), 'id': id};
      }
      else{
        return {'product': product!.toMap(), 'id': id, 'variant' : variant!.toMap()};
      }
    }
    else{
      return {'id': id};
    }
  }
}
