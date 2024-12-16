// import 'package:flutter/material.dart';
// import 'package:gabriel_tour_app/widgets/transportation_card.dart';
// import 'package:gabriel_tour_app/services/order_service.dart';
// import 'package:gabriel_tour_app/services/jwt_service.dart';
// import 'package:gabriel_tour_app/dtos/order_dto.dart';

// class TransportationScreen extends StatefulWidget {
//   const TransportationScreen({Key? key}) : super(key: key);

//   @override
//   _TransportationScreenState createState() => _TransportationScreenState();
// }

// class _TransportationScreenState extends State<TransportationScreen> {
//   late Future<OrderDTO?> _orderDetails;
//   final OrderService _orderService = OrderService(JwtService());

//   @override
//   void initState() {
//     super.initState();
//     _orderDetails = _orderService.getOrderDetailsForUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plán zájazdu'),
//         backgroundColor: Colors.orange,
//       ),
//       body: FutureBuilder<OrderDTO?>(
//         future: _orderDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError || !snapshot.hasData) {
//             return const Center(
//                 child: Text('Error loading transportation details.'));
//           }

//           final transportations = snapshot.data!.transportationReservations;

//           return ListView.builder(
//             itemCount: transportations.length,
//             itemBuilder: (context, index) {
//               final transport = transportations[index];
//               return TransportationCard(
//                 type: transport.transportType == 40
//                     ? 'flight'
//                     : 'bus', // Determine type
//                 date: DateTime.parse(transport.startDate)
//                     .toLocal()
//                     .toString()
//                     .split(' ')[0], // Format date
//                 departureTime:
//                     transport.pickupTime.split('T')[1], // Extract time
//                 departurePlace: transport.departureAirportName ?? 'Unknown',
//                 arrivalTime:
//                     transport.dropoffTime.split('T')[1], // Extract time
//                 arrivalPlace: transport.arrivalAirportName ?? 'Unknown',
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/transportation_card.dart';
import 'package:gabriel_tour_app/dtos/transportation_reservation_dto.dart';

class TransportationScreen extends StatelessWidget {
  final List<TransportationReservationDTO> transportations;

  const TransportationScreen({Key? key, required this.transportations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Image.asset(
            'assets/icons/gabrieltour-logo-2023.png',
            height: screenHeight * 0.04,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.015), // Relative gap
          Container(
            width: double.infinity,
            color: const Color.fromARGB(201, 146, 96, 52), // Brown background
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            child: Text(
              'Doprava',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: transportations.isEmpty
                ? const Center(
                    child: Text(
                      'No transportation details available.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: transportations.length,
                    itemBuilder: (context, index) {
                      final transport = transportations[index];
                      return TransportationCard(
                        type: transport.transportType == 40 ? 'flight' : 'bus',
                        date: DateTime.parse(transport.startDate)
                            .toLocal()
                            .toString()
                            .split(' ')[0],
                        departureTime: transport.pickupTime.split('T')[1],
                        departurePlace:
                            transport.departureAirportName ?? 'Unknown',
                        arrivalTime: transport.dropoffTime.split('T')[1],
                        arrivalPlace: transport.arrivalAirportName ?? 'Unknown',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
