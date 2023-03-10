class UserData {
  String id;
  String email;
  String name;
  String surname;
  int housenumber;
  String street;
  String city;
  int codepostal;


  UserData(
      {
        required this.id,
        required this.email,
        required this.name,
        required this.surname,
        required this.housenumber,
        required this.street,
        required this.city,
        required this.codepostal
      });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? "",
      email: map['email'] ?? "",
      name: map['name'] ?? "",
      surname: map['surname'] ?? "",
      housenumber: map['housenumber'] ?? "",
      street: map['street'] ?? "",
      city: map['city'] ?? "",
      codepostal: map['codepostal'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'housenumber': housenumber,
      'street': street,
      'city': city,
      'codepostal': codepostal,
    };
  }
}