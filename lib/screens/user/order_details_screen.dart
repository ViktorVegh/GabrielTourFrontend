import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/services/tee_time_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';
import 'package:gabriel_tour_app/widgets/services_card_widget.dart';
import 'package:gabriel_tour_app/widgets/transportation_slider_widget.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderNumber;
  final OrderService? orderService;
  final TeeTimeService? teeTimeService;

  const OrderDetailsScreen({
    Key? key,
    required this.orderNumber,
    this.orderService,
    this.teeTimeService,
  }) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<OrderDTO?> _orderDetails;
  late Future<List<TeeTimeDTO>> _teeTimes;

  @override
  void initState() {
    super.initState();

    final orderService = widget.orderService ?? OrderService(JwtService());
    final teeTimeService =
        widget.teeTimeService ?? TeeTimeService(JwtService());

    _orderDetails = _fetchOrderDetails(orderService);
    _teeTimes = _fetchTeeTimes(teeTimeService);
  }

  Future<OrderDTO?> _fetchOrderDetails(OrderService service) async {
    try {
      final result = await service.getOrderDetailsForUser();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TeeTimeDTO>> _fetchTeeTimes(TeeTimeService service) async {
    try {
      final result = await service.getTeeTimesForUser();
      return result ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final sliderTop = screenHeight * 0.06;
    // final sliderHeight = screenHeight * 0.8;
    final mainContentPadding = sliderTop + screenHeight * 0.30;

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
                'Detaily Zájazdu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.021,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<OrderDTO?>(
                future: _orderDetails,
                builder: (context, orderSnapshot) {
                  if (orderSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (orderSnapshot.hasError ||
                      orderSnapshot.data == null) {
                    return const Center(
                        child: Text('Error loading order details.'));
                  }

                  final order = orderSnapshot.data!;
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

                  return FutureBuilder<List<TeeTimeDTO>>(
                    future: _teeTimes,
                    builder: (context, teeTimeSnapshot) {
                      if (teeTimeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (teeTimeSnapshot.hasError) {
                        return const Center(
                            child: Text('Error loading tee times.'));
                      }

                      final teeTimes = teeTimeSnapshot.data!;

                      return SingleChildScrollView(
                        child: Stack(
                          children: [
                            // Hotel image
                            Container(
                              height: screenHeight * 0.25,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/icons/hotel.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Transportation slider
                            Positioned(
                              top: sliderTop,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                height: screenHeight * 0.28,
                                child: TransportationSlider(
                                  transportations: order
                                      .transportationReservations
                                      .map((transport) => {
                                            'departureTime': TimeOfDay(
                                              hour: DateTime.parse(
                                                      transport.pickupTime)
                                                  .hour,
                                              minute: DateTime.parse(
                                                      transport.pickupTime)
                                                  .minute,
                                            ),
                                            'departurePlace': transport
                                                    .departureAirportName ??
                                                'Unknown',
                                            'arrivalTime': TimeOfDay(
                                              hour: DateTime.parse(
                                                      transport.dropoffTime)
                                                  .hour,
                                              minute: DateTime.parse(
                                                      transport.dropoffTime)
                                                  .minute,
                                            ),
                                            'arrivalPlace':
                                                transport.arrivalAirportName ??
                                                    'Unknown',
                                            'date':
                                                '${DateTime.parse(transport.pickupTime).day}.${DateTime.parse(transport.pickupTime).month}.${DateTime.parse(transport.pickupTime).year}',
                                            'type':
                                                transport.transportType == 40
                                                    ? 'flight'
                                                    : 'bus',
                                          })
                                      .toList(),
                                ),
                              ),
                            ),

                            // Main content
                            Padding(
                              padding: EdgeInsets.only(top: mainContentPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.04),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                resortName,
                                                style: TextStyle(
                                                  fontSize:
                                                      screenHeight * 0.035,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (stars > 0)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: screenWidth * 0.02),
                                                child: Text(
                                                  '★' * stars,
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenHeight * 0.025,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text(
                                          location,
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.02,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          travelDates,
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.018,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  ServicesCard(
                                    orderNumber: order.id.toString(),
                                    accommodations:
                                        order.accommodationReservations,
                                    services: order.prices,
                                    teeTimes: teeTimes,
                                    transportations:
                                        order.transportationReservations,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
