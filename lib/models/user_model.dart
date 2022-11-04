class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory User.getDummyUser() {
    return User(
      id: "0",
      name: "John Doe",
      email: "john@gmail.com",
      phone: "9100910091",
      token: "0",
    );
  }

  factory User.fromJson(var json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "token": token,
    };
  }
}
