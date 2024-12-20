class DriveDTO {
  final int id;
  final String date;
  final String? pickupTime;
  final String? dropoffTime;
  final String? customReason;
  final int? driverId;
  final String departurePlace;
  final String arrivalPlace;
  final List<int> userIds;

  DriveDTO({
    required this.id,
    required this.date,
    this.pickupTime,
    this.dropoffTime,
    this.customReason,
    this.driverId,
    required this.departurePlace,
    required this.arrivalPlace,
    required this.userIds,
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
      userIds: (json['userIds'] as List<dynamic>).map((e) => e as int).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'pickupTime': pickupTime,
      'dropoffTime': dropoffTime,
      'customReason': customReason,
      'driverId': driverId,
      'departurePlace': departurePlace,
      'arrivalPlace': arrivalPlace,
      'userIds': userIds,
    };
  }

  DriveDTO copyWith({
    String? departurePlace,
    String? arrivalPlace,
    String? customReason,
    String? date,
    String? pickupTime,
    String? dropoffTime,
    int? driverId,
    List<int>? userIds,
  }) {
    return DriveDTO(
      id: id,
      departurePlace: departurePlace ?? this.departurePlace,
      arrivalPlace: arrivalPlace ?? this.arrivalPlace,
      customReason: customReason ?? this.customReason,
      date: date ?? this.date,
      pickupTime: pickupTime ?? this.pickupTime,
      dropoffTime: dropoffTime ?? this.dropoffTime,
      driverId: driverId ?? this.driverId,
      userIds: userIds ?? this.userIds,
    );
  }
}
