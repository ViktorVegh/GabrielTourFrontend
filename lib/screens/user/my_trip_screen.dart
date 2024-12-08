import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/widgets/order_card_widget.dart';

class MyTripScreen extends StatelessWidget {
  final OrderService orderService;

  MyTripScreen({Key? key, required this.orderService}) : super(key: key);

  Future<OrderDTO?> fetchOrderDetails() async {
    return await orderService.getOrderDetailsForUser();
  }

  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Môj zájazd',
            key: ValueKey('userTrips_screen'),
          ),
        ),
        body: FutureBuilder<OrderDTO?>(
          future: fetchOrderDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text('Chyba pri načítavaní údajov.'));
            } else {
              final order = snapshot.data!;
              final startDate = DateTime.parse(order.startDate);
              final endDate = DateTime.parse(order.endDate);
              final travelDates =
                  '${startDate.day.toString().padLeft(2, '0')}.${startDate.month.toString().padLeft(2, '0')} - ${endDate.day.toString().padLeft(2, '0')}.${endDate.month.toString().padLeft(2, '0')}';

              final year = startDate.year.toString();
              final location = order.accommodationReservations.isNotEmpty
                  ? [
                      order.accommodationReservations[0].hotel.region,
                      order.accommodationReservations[0].hotel.country
                    ].where((part) => part != null).join(', ')
                  : 'Unknown';

              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OrderCard(
                    year: year,
                    resortName: order.name,
                    location: location.isNotEmpty ? location : 'N/A',
                    orderNumber: order.id.toString(),
                    travelDates: travelDates,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
