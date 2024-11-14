import 'person.dart';

class Office extends Person {
  Office({
    int? id,
    required String name,
    required String password,
  }) : super(
          id: id,
          email: 'no-email@office.com',
          password: password,
          name: name,
        );

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      name: json['name'],
      password: json['password'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
