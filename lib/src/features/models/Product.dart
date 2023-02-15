class Product {
  String name;
  String urlPicture;
  String description;
  String category;
  double? price;

  Product(
      {
        required this.name,
        required this.urlPicture,
        required this.description,
        required this.category,
        this.price
      });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? "",
      urlPicture: map['urlPicture'] ?? "",
      description: map['description'] ?? "",
      category: map['category'] ?? "",
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'urlPicture': urlPicture,
      'description': description,
      'category': category,
      'price': price,
    };
  }
}
