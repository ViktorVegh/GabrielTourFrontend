class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String profilePicture;
  final String role;

  RegisterRequest({
    required this.email,
    required this.password,
    this.name = "",
    this.profilePicture = "",
    this.role = "user",
  });

  // Convert DTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'profilePicture': profilePicture,
      'role': role,
    };
  }

  // Create DTO from JSON (if necessary)
  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      email: json['email'],
      password: json['password'],
      name: json['name'] ?? "",
      profilePicture: json['profilePicture'] ?? "",
      role: json['role'] ?? "user",
    );
  }
}
