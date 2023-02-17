class Variant {
  String size;
  String color;
  String? imageUrl;
  double price;

  Variant(
      {
        required this.size,
        required this.color,
        this.imageUrl,
        required this.price,
      });

  factory Variant.fromMap(Map<String, dynamic> map) {
    return Variant(
      size: map['size'] ?? "",
      color: map['color'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
      price: map['price'] ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'color': color,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
