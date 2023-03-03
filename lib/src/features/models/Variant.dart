class Variant {
  String id;
  String? size;
  String? color;
  String? urlPicture;
  double price;

  Variant(
      {
        required this.id,
        this.size,
        this.color,
        this.urlPicture,
        required this.price,
      });

  factory Variant.fromMap(Map<String, dynamic> map) {
    return Variant(
      id: map['id'] ?? "",
      size: map['size'] ?? "",
      color: map['color'] ?? "",
      urlPicture: map['urlPicture'] ?? "",
      price: map['price'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': size,
      'color': color,
      'urlPicture': urlPicture,
      'price': price,
    };
  }
}
