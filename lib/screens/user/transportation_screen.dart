import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/transportation_card.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';

class TransportationScreen extends StatefulWidget {
  const TransportationScreen({Key? key}) : super(key: key);

  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  late Future<OrderDTO?> _orderDetails;
  final OrderService _orderService = OrderService(JwtService());

  @override
  void initState() {
    super.initState();
    _orderDetails = _orderService.getOrderDetailsForUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plán zájazdu'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<OrderDTO?>(
        future: _orderDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
                child: Text('Error loading transportation details.'));
          }

          final transportations = snapshot.data!.transportationReservations;

          return ListView.builder(
            itemCount: transportations.length,
            itemBuilder: (context, index) {
              final transport = transportations[index];
              return TransportationCard(
                type: transport.transportType == 40
                    ? 'flight'
                    : 'bus', // Determine type
                date: DateTime.parse(transport.startDate)
                    .toLocal()
                    .toString()
                    .split(' ')[0], // Format date
                departureTime:
                    transport.pickupTime.split('T')[1], // Extract time
                departurePlace: transport.departureAirportName ?? 'Unknown',
                arrivalTime:
                    transport.dropoffTime.split('T')[1], // Extract time
                arrivalPlace: transport.arrivalAirportName ?? 'Unknown',
              );
            },
          );
        },
      ),
    );
  }
}
