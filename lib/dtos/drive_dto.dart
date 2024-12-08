class DriveDTO {
  final int id;
  final String date;
  final String pickupTime;
  final String dropoffTime;
  final String? customReason;
  final int driverId;
  final String departurePlace;
  final String arrivalPlace;

  DriveDTO({
    required this.id,
    required this.date,
    required this.pickupTime,
    required this.dropoffTime,
    this.customReason,
    required this.driverId,
    required this.departurePlace,
    required this.arrivalPlace,
  });

  factory DriveDTO.fromJson(Map<String, dynamic> json) {
    return DriveDTO(
      id: json['id'],
      date: json['date'],
      pickupTime: json['pickupTime'],
      dropoffTime: json['dropoffTime'],
      customReason: json['customReason'],
      driverId: json['driverId'],
      departurePlace: json['departurePlace'],
      arrivalPlace: json['arrivalPlace'],
    );
  }
}
