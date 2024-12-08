import 'package:gabriel_tour_app/dtos/accommodation_dto.dart';
import 'package:gabriel_tour_app/dtos/price_dto.dart';
import 'package:gabriel_tour_app/dtos/transportation_reservation_dto.dart';

class OrderDTO {
  final int id;
  final double totalPrice;
  final String startDate;
  final String endDate;
  final int numberOfNights;
  final int adults;
  final int children;
  final String currency;
  final String paymentStatus;
  final String name;
  final List<AccommodationReservationDTO> accommodationReservations;
  final List<TransportationReservationDTO> transportationReservations;
  final List<PriceDTO> prices;

  OrderDTO({
    required this.id,
    required this.totalPrice,
    required this.startDate,
    required this.endDate,
    required this.numberOfNights,
    required this.adults,
    required this.children,
    required this.currency,
    required this.paymentStatus,
    required this.name,
    required this.accommodationReservations,
    required this.transportationReservations,
    required this.prices,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      id: json['orderDetail']['id'],
      totalPrice: json['orderDetail']['totalPrice'],
      startDate: json['orderDetail']['startDate'],
      endDate: json['orderDetail']['endDate'],
      numberOfNights: json['orderDetail']['numberOfNights'],
      adults: json['orderDetail']['adults'],
      children: json['orderDetail']['children'],
      currency: json['orderDetail']['currency'],
      paymentStatus: json['orderDetail']['paymentStatus'],
      name: json['orderDetail']['name'],
      accommodationReservations:
          (json['orderDetail']['accommodationReservations'] as List)
              .map((item) => AccommodationReservationDTO.fromJson(item))
              .toList(),
      transportationReservations:
          (json['orderDetail']['transportationReservations'] as List)
              .map((item) => TransportationReservationDTO.fromJson(item))
              .toList(),
      prices: (json['orderDetail']['prices'] as List)
          .map((item) => PriceDTO.fromJson(item))
          .toList(),
    );
  }
}
