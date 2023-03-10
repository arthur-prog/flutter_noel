import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/User.dart';

class CartProduct {
  String id;
  Product? product;
  int quantity;

  CartProduct(
      {required this.id, required this.product, required this.quantity});

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
        id: map['id'] ?? "",
        product: map['product'] != null ? Product.fromMap(map['product']) : null,
        quantity: map['quantity'] ?? "");
  }

  Map<String, dynamic> toMap() {
    if(product != null) {
      return {'product': product!.toMap(), 'quantity': quantity, 'id': id};
    }
    else{
      return {'quantity': quantity, 'id': id};
    }
  }
}
