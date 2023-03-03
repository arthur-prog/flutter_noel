class UserInfoAdress {
  String id;
  int housenumber;
  String street;
  String city;
  int codepostal;


  UserInfoAdress(
      {
        required this.id,
        required this.housenumber,
        required this.street,
        required this.city,
        required this.codepostal
      });

  factory UserInfoAdress.fromMap(Map<String, dynamic> map) {
    return UserInfoAdress(
      id: map['id'] ?? "",
      housenumber: map['housenumber'] ?? "",
      street: map['street'] ?? "",
      city: map['city'] ?? "",
      codepostal: map['codepostal'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'housenumber': housenumber,
      'street': street,
      'city': city,
      'codepostal': codepostal,
    };
  }
}