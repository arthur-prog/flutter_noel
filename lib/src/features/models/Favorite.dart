import 'package:flutter_noel/src/features/models/Product.dart';
import 'package:flutter_noel/src/features/models/User.dart';

class Favorite {
  String id;

  Favorite(
      {
        required this.id
      });

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] ?? "",
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
    };
  }
}