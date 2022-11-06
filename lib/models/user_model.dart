class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  int booksPending;
  int booksCanceled;
  int booksCompleted;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
    this.booksPending = 0,
    this.booksCanceled = 0,
    this.booksCompleted = 0,
  });

  factory User.getDummyUser() {
    return User(
      id: 0,
      name: "John Doe",
      email: "john@gmail.com",
      phone: "9100910091",
      token: "0",
    );
  }

  factory User.fromJson(var json) {
    return User(
      id: json["user"]["id"],
      name: json["user"]["name"],
      email: json["user"]["email"],
      phone: json["user"]["phone_number"],
      token: json["token"],
    );
  }

  factory User.fromUser(User user) {
    return User(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      token: user.token,
      booksPending: user.booksPending,
      booksCompleted: user.booksCompleted,
      booksCanceled: user.booksCanceled,
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
