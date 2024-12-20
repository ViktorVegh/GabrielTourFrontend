import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gabriel_tour_app/screens/user/order_details_screen.dart';
// import 'package:gabriel_tour_app/dtos/order_dto.dart';
// import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';
// import 'package:gabriel_tour_app/widgets/services_card_widget.dart';
import 'package:gabriel_tour_app/services/tee_time_service.dart';
import '../../../mocks/generate_mocks.mocks.dart';
// import 'package:gabriel_tour_app/dtos/accommodation_dto.dart';
// import 'package:gabriel_tour_app/dtos/hotel_dto.dart';
// import 'package:gabriel_tour_app/dtos/price_dto.dart';
// import 'package:gabriel_tour_app/dtos/transportation_reservation_dto.dart';
// import 'package:intl/intl.dart';

void main() {
  group('OrderDetailsScreen Tests', () {
    late MockOrderService mockOrderService;
    late TeeTimeService mockTeeTimeService;

    setUp(() {
      mockOrderService = MockOrderService();

      mockTeeTimeService = MockTeeTimeService();

      when(mockOrderService.getOrderDetailsForUser())
          .thenAnswer((_) async => null);

      when(mockTeeTimeService.getTeeTimesForUser())
          .thenAnswer((_) async => null);
    });

    // testWidgets('loads order details and tee times correctly',
    //     (WidgetTester tester) async {
    //   debugPrint("Test: loads order details and tee times correctly");

    //   // Mocking accommodation data
    //   final accommodations = [
    //     AccommodationReservationDTO(
    //       id: 1,
    //       startDate: '2023-12-01',
    //       beds: 2,
    //       extraBeds: 1,
    //       numberOfNights: 3,
    //       accommodationName: 'Hotel Mock',
    //       note: 'No special requests',
    //       hotel: HotelDTO(
    //         id: 101,
    //         name: 'Hotel Mock',
    //         stars: 4,
    //         region: 'Region Mock',
    //         country: 'Country Mock',
    //         area: 'Area Mock',
    //       ),
    //     ),
    //   ];

    //   // Mocking transportation data (correct DateTime formatting)
    //   final transportations = [
    //     TransportationReservationDTO(
    //       id: 1,
    //       pickupTime: DateFormat("yyyy-MM-ddTHH:mm:ss").format(
    //           DateFormat("hh:mm a")
    //               .parse('09:00 AM')), // Ensureing formats match
    //       dropoffTime: DateFormat("yyyy-MM-ddTHH:mm:ss").format(
    //           DateFormat("hh:mm a")
    //               .parse('11:30 AM')), // Ensuring formats match
    //       startDate: '2023-12-01',
    //       transportType: 1,
    //       departureAirportName: 'Airport A',
    //       arrivalAirportName: 'Airport B',
    //       routeName: 'Route A-B',
    //     ),
    //   ];

    //   // Mock services (prices)
    //   final services = [
    //     PriceDTO(
    //       id: 1,
    //       name: 'Service Mock',
    //       price: 100.0,
    //       currency: 'EUR',
    //       quantity: 2,
    //     ),
    //   ];

    //   // Mock teeTimes
    //   final teeTimes = [
    //     TeeTimeDTO(
    //       id: 1,
    //       teeTime: DateTime.parse('2023-12-01T08:00:00'),
    //       groupSize: 4,
    //       userIds: [1, 2, 3],
    //       golfCourseId: 101,
    //       green: true,
    //       transport: false,
    //       holes: 18,
    //       adults: 3,
    //       juniors: 1,
    //       note: 'Morning tee time',
    //     ),
    //   ];

    //   // Mock OrderDTO with all necessary fields
    //   final order = OrderDTO(
    //     id: 12345,
    //     name: 'Mock Resort',
    //     startDate: '2023-12-01',
    //     endDate: '2023-12-10',
    //     numberOfNights: 9,
    //     adults: 2,
    //     children: 1,
    //     currency: 'EUR',
    //     paymentStatus: 'Paid',
    //     totalPrice: 500.0,
    //     accommodationReservations: accommodations,
    //     transportationReservations: transportations,
    //     prices: services,
    //   );

    //   // Mock service calls
    //   when(mockOrderService.getOrderDetailsForUser()).thenAnswer((_) async {
    //     debugPrint("MockOrderService: Returning mocked order.");
    //     return order;
    //   });

    //   when(mockTeeTimeService.getTeeTimesForUser()).thenAnswer((_) async {
    //     debugPrint("MockTeeTimeService: Returning mocked tee times.");
    //     return teeTimes;
    //   });

    //   // Pump the widget
    //   await tester.pumpWidget(MaterialApp(
    //     home: OrderDetailsScreen(
    //       orderNumber: '12345',
    //       orderService: mockOrderService,
    //       teeTimeService: mockTeeTimeService,
    //     ),
    //   ));

    //   // Waiting for all asynchronous operations to complete
    //   await tester.pumpAndSettle();

    //   // Verifying service calls
    //   verify(mockOrderService.getOrderDetailsForUser()).called(1);
    //   verify(mockTeeTimeService.getTeeTimesForUser()).called(1);

    //   // Debugging the widget tree
    //   debugPrint(find.byType(Text).evaluate().toString());

    //   // Verifying UI for order details
    //   expect(find.text('Mock Resort'), findsOneWidget);

    //   // Verifying UI for ServicesCard
    //   final servicesCard =
    //       tester.widget<ServicesCard>(find.byType(ServicesCard));

    //   // Verifying if all data is passed correctly
    //   expect(servicesCard.accommodations, isNotEmpty);
    //   expect(servicesCard.transportations, isNotEmpty);
    //   expect(servicesCard.services, isNotEmpty);
    //   expect(servicesCard.teeTimes, isNotEmpty);

    //   // Verifying specific values in the data passed to ServicesCard
    //   expect(servicesCard.accommodations[0].accommodationName, 'Hotel Mock');
    //   expect(
    //     servicesCard.transportations[0].pickupTime,
    //     '1970-01-01T09:00:00', // Matching expected format
    //   );
    //   expect(servicesCard.services[0].name, 'Service Mock');

    //   expect(
    //     servicesCard.teeTimes[0].teeTime.toIso8601String().split('.').first,
    //     '2023-12-01T08:00:00', // Removing milliseconds for proper comparison
    //   );

    //   debugPrint("ServicesCard data verified.");
    // });

    testWidgets('displays loading indicators initially',
        (WidgetTester tester) async {
      debugPrint("Test: displays loading indicators initially");
      await tester.pumpWidget(MaterialApp(
        home: OrderDetailsScreen(
          orderNumber: '12345',
          orderService: mockOrderService,
          teeTimeService: mockTeeTimeService,
        ),
      ));

      // Verify loading indicators are shown
      expect(find.byType(CircularProgressIndicator), findsWidgets);
      debugPrint("Loading indicators verified.");
    });

    testWidgets('displays error message when loading fails',
        (WidgetTester tester) async {
      debugPrint("Test: displays error message when loading fails");

      // Mock failure in order service
      when(mockOrderService.getOrderDetailsForUser())
          .thenThrow(Exception('Error fetching order details'));

      await tester.pumpWidget(MaterialApp(
        home: OrderDetailsScreen(
          orderNumber: '12345',
          orderService: mockOrderService,
          teeTimeService: mockTeeTimeService,
        ),
      ));

      // async completion
      await tester.pumpAndSettle();

      expect(find.text('Error loading order details.'), findsOneWidget);
      debugPrint("Error message verified.");
    });
  });
}
