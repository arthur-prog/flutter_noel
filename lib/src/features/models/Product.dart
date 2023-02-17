class Product {
  String id;
  String name;
  String urlPicture;
  String description;
  String category;
  double? price;

  Product(
      {
        required this.id,
        required this.name,
        required this.urlPicture,
        required this.description,
        required this.category,
        this.price
      });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      urlPicture: map['urlPicture'] ?? "",
      description: map['description'] ?? "",
      category: map['category'] ?? "",
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'urlPicture': urlPicture,
      'description': description,
      'category': category,
      'price': price,
    };
  }
}
