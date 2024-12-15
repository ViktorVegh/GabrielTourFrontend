class GolfCourseDTO {
  final int id;
  final String name;

  GolfCourseDTO({
    required this.id,
    required this.name,
  });

  factory GolfCourseDTO.fromJson(Map<String, dynamic> json) {
    return GolfCourseDTO(
      id: json['id'], // Convert 'id' to String if it's an int
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}