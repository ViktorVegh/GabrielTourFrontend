import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/widgets/order_card_widget.dart'; // Import OrderCard
import 'package:gabriel_tour_app/services/jwt_service.dart';

class MyTripScreen extends StatelessWidget {
  final OrderService _orderService = OrderService(JwtService());

  MyTripScreen({Key? key}) : super(key: key);

  Future<OrderDTO?> fetchOrderDetails() async {
    return await _orderService.getOrderDetailsForUser();
  }

  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Môj zájazd'),
        ),
        body: FutureBuilder<OrderDTO?>(
          future: fetchOrderDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              // Show error message if data fetch fails
              return const Center(child: Text('Chyba pri načítavaní údajov.'));
            } else {
              // Use the fetched data to populate the OrderCard
              final order = snapshot.data!;

              // Extract and format dates
              final startDate = DateTime.parse(order.startDate);
              final endDate = DateTime.parse(order.endDate);
              final travelDates =
                  '${startDate.day}.${startDate.month} - ${endDate.day}.${endDate.month}';

              // Extract year
              final year = startDate.year.toString();

              // Construct location (region, country)
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
