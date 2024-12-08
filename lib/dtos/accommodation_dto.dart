import 'package:gabriel_tour_app/dtos/hotel_dto.dart';

class AccommodationReservationDTO {
  final int id;
  final String startDate;
  final int beds;
  final int extraBeds;
  final int numberOfNights;
  final String accommodationName;
  final String note;
  final String? mealType;
  final HotelDTO hotel;

  AccommodationReservationDTO({
    required this.id,
    required this.startDate,
    required this.beds,
    required this.extraBeds,
    required this.numberOfNights,
    required this.accommodationName,
    required this.note,
    this.mealType,
    required this.hotel,
  });

  factory AccommodationReservationDTO.fromJson(Map<String, dynamic> json) {
    return AccommodationReservationDTO(
      id: json['id'],
      startDate: json['startDate'],
      beds: json['beds'],
      extraBeds: json['extraBeds'],
      numberOfNights: json['numberOfNights'],
      accommodationName: json['accommodationName'],
      note: json['note'],
      mealType: json['mealType'],
      hotel: HotelDTO.fromJson(json['objednavkaHotel']),
    );
  }
}
