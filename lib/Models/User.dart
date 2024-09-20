class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String cart_id;

  User(this.id, this.firstName, this.lastName, this.email, this.cart_id);
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['firstName'], json['lastName'], json['email'],
        json['cart']["uuid"]);
  }
}
