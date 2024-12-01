// class OrderDTO {
//   final int id;
//   final double totalPrice;
//   final String startDate;
//   final String endDate;
//   final int numberOfNights;
//   final int adults;
//   final int children;
//   final String currency;
//   final String paymentStatus;
//   final String name;
//   final List<AccommodationReservationDTO> accommodationReservations;
//   final List<TransportationReservationDTO> transportationReservations;
//   final List<PriceDTO> prices;

//   OrderDTO({
//     required this.id,
//     required this.totalPrice,
//     required this.startDate,
//     required this.endDate,
//     required this.numberOfNights,
//     required this.adults,
//     required this.children,
//     required this.currency,
//     required this.paymentStatus,
//     required this.name,
//     required this.accommodationReservations,
//     required this.transportationReservations,
//     required this.prices,
//   });

//   factory OrderDTO.fromJson(Map<String, dynamic> json) {
//     return OrderDTO(
//       id: json['orderDetail']['id'],
//       totalPrice: json['orderDetail']['totalPrice'],
//       startDate: json['orderDetail']['startDate'],
//       endDate: json['orderDetail']['endDate'],
//       numberOfNights: json['orderDetail']['numberOfNights'],
//       adults: json['orderDetail']['adults'],
//       children: json['orderDetail']['children'],
//       currency: json['orderDetail']['currency'],
//       paymentStatus: json['orderDetail']['paymentStatus'],
//       name: json['orderDetail']['name'],
//       accommodationReservations:
//           (json['orderDetail']['accommodationReservations'] as List)
//               .map((item) => AccommodationReservationDTO.fromJson(item))
//               .toList(),
//       transportationReservations:
//           (json['orderDetail']['transportationReservations'] as List)
//               .map((item) => TransportationReservationDTO.fromJson(item))
//               .toList(),
//       prices: (json['orderDetail']['prices'] as List)
//           .map((item) => PriceDTO.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class AccommodationReservationDTO {
//   final int id;
//   final String startDate;
//   final int beds;
//   final int extraBeds;
//   final int numberOfNights;
//   final String accommodationName;
//   final String note;
//   final HotelDTO hotel;

//   AccommodationReservationDTO({
//     required this.id,
//     required this.startDate,
//     required this.beds,
//     required this.extraBeds,
//     required this.numberOfNights,
//     required this.accommodationName,
//     required this.note,
//     required this.hotel,
//   });

//   factory AccommodationReservationDTO.fromJson(Map<String, dynamic> json) {
//     return AccommodationReservationDTO(
//       id: json['id'],
//       startDate: json['startDate'],
//       beds: json['beds'],
//       extraBeds: json['extraBeds'],
//       numberOfNights: json['numberOfNights'],
//       accommodationName: json['accommodationName'],
//       note: json['note'],
//       hotel: HotelDTO.fromJson(json['hotel']),
//     );
//   }
// }

// class HotelDTO {
//   final int id;
//   final String name;
//   final int stars;
//   final String? region;
//   final String? country;
//   final String? area;

//   HotelDTO({
//     required this.id,
//     required this.name,
//     required this.stars,
//     this.region,
//     this.country,
//     this.area,
//   });

//   factory HotelDTO.fromJson(Map<String, dynamic> json) {
//     return HotelDTO(
//       id: json['id'],
//       name: json['name'],
//       stars: json['stars'],
//       region: json['region'],
//       country: json['country'],
//       area: json['area'],
//     );
//   }
// }

// class TransportationReservationDTO {
//   final int id;
//   final String pickupTime;
//   final String dropoffTime;
//   final String startDate;
//   final int transportType;
//   final String? departureAirportName;
//   final String? arrivalAirportName;
//   final String? routeName;

//   TransportationReservationDTO({
//     required this.id,
//     required this.pickupTime,
//     required this.dropoffTime,
//     required this.startDate,
//     required this.transportType,
//     this.departureAirportName,
//     this.arrivalAirportName,
//     this.routeName,
//   });

//   factory TransportationReservationDTO.fromJson(Map<String, dynamic> json) {
//     return TransportationReservationDTO(
//       id: json['id'],
//       pickupTime: json['pickupTime'],
//       dropoffTime: json['dropoffTime'],
//       startDate: json['startDate'],
//       transportType: json['transportType'],
//       departureAirportName: json['departureAirportName'],
//       arrivalAirportName: json['arrivalAirportName'],
//       routeName: json['routeName'],
//     );
//   }
// }

// class PriceDTO {
//   final int id;
//   final String name;
//   final double price;
//   final String currency;

//   PriceDTO({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.currency,
//   });

//   factory PriceDTO.fromJson(Map<String, dynamic> json) {
//     return PriceDTO(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'],
//       currency: json['currency'],
//     );
//   }
// }

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

class AccommodationReservationDTO {
  final int id;
  final String startDate;
  final int beds;
  final int extraBeds;
  final int numberOfNights;
  final String accommodationName;
  final String note;
  final String? mealType; // Optional field
  final HotelDTO hotel;

  AccommodationReservationDTO({
    required this.id,
    required this.startDate,
    required this.beds,
    required this.extraBeds,
    required this.numberOfNights,
    required this.accommodationName,
    required this.note,
    this.mealType, // Now optional
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
      mealType: json['mealType'], // Parse mealType, can be null
      hotel: HotelDTO.fromJson(json['objednavkaHotel']), // Fix the mapping here
    );
  }
}

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

class PriceDTO {
  final int id;
  final String name;
  final double price;
  final String currency;
  final int quantity;

  PriceDTO({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.quantity,
  });

  factory PriceDTO.fromJson(Map<String, dynamic> json) {
    return PriceDTO(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      quantity: json['quantity'],
    );
  }
}
