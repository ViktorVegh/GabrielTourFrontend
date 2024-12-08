class TransportationReservationDTO {
  final int id;
  final String pickupTime;
  final String dropoffTime;
  final String startDate;
  final int transportType;
  final String? departureAirportName;
  final String? arrivalAirportName;
  final String? routeName;

  TransportationReservationDTO({
    required this.id,
    required this.pickupTime,
    required this.dropoffTime,
    required this.startDate,
    required this.transportType,
    this.departureAirportName,
    this.arrivalAirportName,
    this.routeName,
  });

  factory TransportationReservationDTO.fromJson(Map<String, dynamic> json) {
    return TransportationReservationDTO(
      id: json['id'],
      pickupTime: json['pickupTime'],
      dropoffTime: json['dropoffTime'],
      startDate: json['startDate'],
      transportType: json['transportType'],
      departureAirportName: json['departureAirportName'],
      arrivalAirportName: json['arrivalAirportName'],
      routeName: json['routeName'],
    );
  }
}
