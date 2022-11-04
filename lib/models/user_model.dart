class User {
  final String id;
  final String name;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.getDummyUser() {
    return User(
      id: "0",
      name: "John Doe",
      email: "john@gmail.com",
      phone: "9100910091",
    );
  }

  factory User.fromJson(var json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}
