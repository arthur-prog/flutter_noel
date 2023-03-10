import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/User.dart';
import 'package:flutter_noel/src/features/models/Variant.dart';

class CartProduct {
  String id;
  Product? product;
  Variant? variant;
  int quantity;

  CartProduct(
      {required this.id, required this.product, required this.quantity, required this.variant});

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
        id: map['id'] ?? "",
        product: map['product'] != null ? Product.fromMap(map['product']) : null,
        variant: map['variant'] != null ? Variant.fromMap(map['variant']) : null,
        quantity: map['quantity'] ?? "");
  }

  Map<String, dynamic> toMap() {
    if(product != null) {
      if(variant == null) {
        return {'product': product!.toMap(), 'quantity': quantity, 'id': id};
      }
      else{
        return {'product': product!.toMap(), 'quantity': quantity, 'id': id, 'variant' : variant!.toMap()};
      }
    }
    else{
      return {'quantity': quantity, 'id': id};
    }
  }
}
