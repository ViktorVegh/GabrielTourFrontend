import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';
import 'package:gabriel_tour_app/widgets/services_card_widget.dart';
import 'package:gabriel_tour_app/widgets/transportation_slider_widget.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderNumber;

  const OrderDetailsScreen({Key? key, required this.orderNumber})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<OrderDTO?> _orderDetails;
  final OrderService _orderService = OrderService(JwtService());

  @override
  void initState() {
    super.initState();
    _orderDetails = _fetchOrderDetails();
  }

  Future<OrderDTO?> _fetchOrderDetails() async {
    try {
      return await _orderService.getOrderDetailsForUser();
    } catch (e) {
      debugPrint('Error fetching order details: $e');
      return null;
    }
  }

  List<Map<String, dynamic>> _prepareTransportations(
      List<TransportationReservationDTO> transportationReservations) {
    return transportationReservations.map((transport) {
      try {
        // Parse pickup and dropoff times
        final pickupDateTime = DateTime.parse(transport.pickupTime);
        final dropoffDateTime = DateTime.parse(transport.dropoffTime);

        return {
          'departureTime': TimeOfDay(
            hour: pickupDateTime.hour,
            minute: pickupDateTime.minute,
          ),
          'departurePlace': transport.departureAirportName ?? 'Unknown',
          'arrivalTime': TimeOfDay(
            hour: dropoffDateTime.hour,
            minute: dropoffDateTime.minute,
          ),
          'arrivalPlace': transport.arrivalAirportName ?? 'Unknown',
          'date':
              '${pickupDateTime.day}.${pickupDateTime.month}.${pickupDateTime.year}',
          'type': transport.transportType == 40 ? 'flight' : 'bus',
        };
      } catch (e) {
        debugPrint('Error parsing transportation data: $e');
        return {
          'departureTime': const TimeOfDay(hour: 0, minute: 0),
          'departurePlace': 'Unknown',
          'arrivalTime': const TimeOfDay(hour: 0, minute: 0),
          'arrivalPlace': 'Unknown',
          'date': 'Unknown',
          'type': 'unknown',
        };
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail objednávky'),
        ),
        body: FutureBuilder<OrderDTO?>(
          future: _orderDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text('Error loading order details.'));
            }

            final order = snapshot.data!;

            final startDate = DateTime.parse(order.startDate);
            final endDate = DateTime.parse(order.endDate);
            final travelDates =
                '${startDate.day}.${startDate.month}.${startDate.year} - ${endDate.day}.${endDate.month}.${endDate.year}';

            final location = order.accommodationReservations.isNotEmpty
                ? [
                    order.accommodationReservations[0].hotel.region,
                    order.accommodationReservations[0].hotel.country
                  ].where((part) => part != null).join(', ')
                : 'Unknown';

            final resortName = order.name;
            final stars = order.accommodationReservations.isNotEmpty
                ? order.accommodationReservations[0].hotel.stars
                : 0;

            final transportations =
                _prepareTransportations(order.transportationReservations);

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/hotel.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  resortName,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (stars > 0)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '★' * stars,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            location,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                          ),
                          Text(
                            travelDates,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                    ),
                    SizedBox(
                      height: 200,
                      child: ServicesCard(
                        orderNumber: order.id.toString(),
                        accommodations: order.accommodationReservations,
                        services: order.prices,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 85,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 230,
                    child: TransportationSlider(
                      transportations: transportations,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
