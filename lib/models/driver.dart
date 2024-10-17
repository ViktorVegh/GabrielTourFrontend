import 'person.dart';

class Driver extends Person {
  Driver({
    int? id,
    required String email,
    required String password,
    String? name,
    String? profilePicture,
  }) : super(
          id: id,
          email: email,
          password: password,
          name: name,
          profilePicture: profilePicture,
        );

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      profilePicture: json['profilePicture'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
