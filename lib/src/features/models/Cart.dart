import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/User.dart';

class Cart {
  String id;

  Cart(
      {
        required this.id
      });

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? "",
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
    };
  }
}