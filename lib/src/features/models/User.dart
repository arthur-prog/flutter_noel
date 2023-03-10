class UserData {
  String id;
  String email;
  bool isAdmin;
  String? name;
  String? surname;
  int? housenumber;
  String? street;
  String? city;
  int? codepostal;

  UserData(
      {
        required this.id,
        required this.email,
        required this.isAdmin,
        this.name,
        this.surname,
        this.housenumber,
        this.street,
        this.city,
        this.codepostal
      });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      email: map['email'],
      isAdmin: map['isAdmin'],
      name: map['name'],
      surname: map['surname'],
      housenumber: map['housenumber'],
      street: map['street'],
      city: map['city'],
      codepostal: map['codepostal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'isAdmin': isAdmin,
      'name': name,
      'surname': surname,
      'housenumber': housenumber,
      'street': street,
      'city': city,
      'codepostal': codepostal,
    };
  }
}