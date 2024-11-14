class PersonDTO {
  final int id;
  final String email;
  final String? name;
  final String? role;
  final String? profilePicture;

  PersonDTO({
    required this.id,
    required this.email,
    this.name,
    this.role,
    this.profilePicture,
  });

  // Factory method for JSON deserialization
  factory PersonDTO.fromJson(Map<String, dynamic> json) {
    return PersonDTO(
      id: json['id'] ?? 0, // Provide default if null
      email: json['email'] ?? '', // Provide default if null
      name: json['name'],
      role: json['role'],
      profilePicture: json['profilePicture'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'profilePicture': profilePicture,
    };
  }
}
