class User {
  final int id;
  final String firstName;
  final String? lastName; // Nullable
  final String? email;
  final String role;

  User(
      {required this.id,
      required this.firstName,
      this.lastName,
      this.email,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?, // Handle null
      email: json['email'] as String?,
      role: json['role'] as String,
    );
  }
}
