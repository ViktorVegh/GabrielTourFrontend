// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:gabriel_tour_app/screens/user/order_details_screen.dart';
// import 'package:gabriel_tour_app/services/order_service.dart';
// import 'package:gabriel_tour_app/dtos/order_dto.dart';
// import 'order_details_test.mocks.dart';
// import 'package:gabriel_tour_app/widgets/services_card_widget.dart';
// import 'package:gabriel_tour_app/widgets/transportation_slider_widget.dart';

// @GenerateMocks([OrderService])
// void main() {
//   late MockOrderService mockOrderService;

//   setUp(() {
//     mockOrderService = MockOrderService();
//   });

//   testWidgets('shows loading indicator while fetching order details',
//       (WidgetTester tester) async {
//     // Arrange
//     when(mockOrderService.getOrderDetailsForUser()).thenAnswer(
//       (_) async {
//         await Future.delayed(
//             const Duration(milliseconds: 500)); // Simulate delay
//         return null;
//       },
//     );

//     // Act
//     await tester.pumpWidget(MaterialApp(
//       home: OrderDetailsScreen(orderNumber: '123'),
//     ));

//     await tester
//         .pump(const Duration(milliseconds: 500)); // Partial stabilization

//     // Assert
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('shows error message when fetching order details fails',
//       (WidgetTester tester) async {
//     // Arrange: Simulate an error in the service
//     when(mockOrderService.getOrderDetailsForUser())
//         .thenThrow(Exception('Error fetching order details'));

//     // Act: Render the screen
//     await tester.pumpWidget(MaterialApp(
//       home: OrderDetailsScreen(orderNumber: '123'),
//     ));

//     // Allow FutureBuilder to process
//     await tester.pumpAndSettle(); // This waits for all futures to complete

//     // Assert: Verify that the error message is displayed
//     expect(find.text('Error loading order details.'), findsOneWidget);

//     // Verify the mock service was called
//     verify(mockOrderService.getOrderDetailsForUser()).called(1);
//   });
//   testWidgets('displays order details when data is available',
//       (WidgetTester tester) async {
//     // Arrange: Mock a successful response
//     final mockOrder = OrderDTO(
//       id: 1,
//       totalPrice: 1500.0,
//       startDate: '2023-12-01T00:00:00',
//       endDate: '2023-12-10T00:00:00',
//       numberOfNights: 9,
//       adults: 2,
//       children: 1,
//       currency: 'EUR',
//       paymentStatus: 'Paid',
//       name: 'Mock Resort',
//       accommodationReservations: [],
//       transportationReservations: [],
//       prices: [],
//     );

//     when(mockOrderService.getOrderDetailsForUser()).thenAnswer(
//         (_) async => mockOrder); // Ensure you're using thenAnswer correctly.

//     // Act: Render the screen
//     await tester.pumpWidget(MaterialApp(
//       home: OrderDetailsScreen(orderNumber: '123'),
//     ));

//     // Allow FutureBuilder to process
//     await tester.pumpAndSettle();

//     // Assert: Verify that the order name is displayed
//     expect(find.text('Mock Resort'), findsOneWidget);

//     // Verify the mock service was called
//     verify(mockOrderService.getOrderDetailsForUser()).called(1);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gabriel_tour_app/screens/user/order_details_screen.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';
import 'order_details_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([OrderService])
void main() {
  late MockOrderService mockOrderService;

  setUp(() {
    mockOrderService = MockOrderService();
  });

  testWidgets('shows error message when fetching order details fails',
      (tester) async {
    // Simulate an error in the service
    when(mockOrderService.getOrderDetailsForUser())
        .thenThrow(Exception('Error fetching order details'));

    // Act: Render the screen
    await tester.pumpWidget(MaterialApp(
      home: OrderDetailsScreen(orderNumber: '123'),
    ));

    // Allow FutureBuilder to process
    await tester.pumpAndSettle();

    // Assert: Verify that the error message is displayed
    expect(find.text('Error loading order details.'), findsOneWidget);
  });

  testWidgets('displays order details when data is available', (tester) async {
    // Mock a successful response with dummy data
    final mockOrder = OrderDTO(
      id: 1,
      totalPrice: 1500.0,
      startDate: '2023-12-01T00:00:00',
      endDate: '2023-12-10T00:00:00',
      numberOfNights: 9,
      adults: 2,
      children: 1,
      currency: 'EUR',
      paymentStatus: 'Paid',
      name: 'Mock Resort',
      accommodationReservations: [],
      transportationReservations: [],
      prices: [],
    );

    when(mockOrderService.getOrderDetailsForUser())
        .thenAnswer((_) async => mockOrder);

    // Act: Render the screen
    await tester.pumpWidget(MaterialApp(
      home: OrderDetailsScreen(orderNumber: '123'),
    ));

    // Allow FutureBuilder to process
    await tester.pumpAndSettle();

    // Assert: Verify that the order name is displayed
    expect(find.text('Mock Resort'), findsOneWidget);
  });
}
