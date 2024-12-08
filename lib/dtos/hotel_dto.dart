class HotelDTO {
  final int id;
  final String name;
  final int stars;
  final String? region;
  final String? country;
  final String? area;

  HotelDTO({
    required this.id,
    required this.name,
    required this.stars,
    this.region,
    this.country,
    this.area,
  });

  factory HotelDTO.fromJson(Map<String, dynamic> json) {
    return HotelDTO(
      id: json['id'],
      name: json['name'],
      stars: json['stars'],
      region: json['region'],
      country: json['country'],
      area: json['area'],
    );
  }
}
