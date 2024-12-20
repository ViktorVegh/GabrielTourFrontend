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
    final screenHeight = MediaQuery.of(context).size.height;

    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
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
            SizedBox(height: screenHeight * 0.015),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(201, 146, 96, 52),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
              child: Text(
                'Môj zájazd',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.021,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Main content
            Expanded(
              child: FutureBuilder<OrderDTO?>(
                future: fetchOrderDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return const Center(
                        child: Text('Chyba pri načítavaní údajov.'));
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
          ],
        ),
      ),
    );
  }
}
