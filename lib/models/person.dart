class Person {
  int? id;
  String email;
  String password;
  String? name;
  String? profilePicture;

  Person({
    this.id,
    required this.email,
    required this.password,
    this.name,
    this.profilePicture,
  });

  // Method to convert from JSON
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      profilePicture: json['profilePicture'],
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'profilePicture': profilePicture,
    };
  }
}
