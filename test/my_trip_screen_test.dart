import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/screens/user/my_trip_screen.dart';
import 'package:gabriel_tour_app/widgets/order_card_widget.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';

class FakeOrderService implements OrderService {
  Future<OrderDTO?> Function()? onGetOrderDetails;

  @override
  String get baseUrl => 'https://dummy.url'; // Provide a dummy value

  @override
  Future<OrderDTO?> getOrderDetailsForUser() {
    if (onGetOrderDetails != null) {
      return onGetOrderDetails!();
    }
    throw UnimplementedError('onGetOrderDetails is not set');
  }
}

void main() {
  late FakeOrderService fakeOrderService;

  setUp(() {
    fakeOrderService = FakeOrderService();
  });

  testWidgets('renders loading indicator while fetching order details',
      (WidgetTester tester) async {
    // Arrange: Simulate loading state
    fakeOrderService.onGetOrderDetails = () async {
      await Future.delayed(const Duration(seconds: 1));
      return null;
    };

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyTripScreen(orderService: fakeOrderService),
    ));

    // Assert: Verify loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for loading to complete
    await tester.pumpAndSettle();
  });

  testWidgets('renders error message when fetching order details fails',
      (WidgetTester tester) async {
    // Arrange: Simulate an error
    fakeOrderService.onGetOrderDetails = () async {
      throw Exception('Failed to fetch order details');
    };

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyTripScreen(orderService: fakeOrderService),
    ));

    // Allow the error state to resolve
    await tester.pumpAndSettle();

    // Assert: Verify error message is displayed
    expect(find.text('Chyba pri načítavaní údajov.'), findsOneWidget);
  });

  testWidgets('renders OrderCard when data is available',
      (WidgetTester tester) async {
    // Arrange: Provide valid order data
    final mockOrder = OrderDTO(
      id: 1,
      totalPrice: 1500.0,
      startDate: "2023-12-01T00:00:00",
      endDate: "2023-12-10T00:00:00",
      numberOfNights: 9,
      adults: 2,
      children: 1,
      currency: "EUR",
      paymentStatus: "Paid",
      name: "Mock Resort",
      accommodationReservations: [
        AccommodationReservationDTO(
          id: 101,
          startDate: "2023-12-01T00:00:00",
          beds: 2,
          extraBeds: 1,
          numberOfNights: 9,
          accommodationName: "Mock Hotel",
          note: "Mock note",
          hotel: HotelDTO(
            id: 201,
            name: "Mock Hotel",
            stars: 4,
            region: "Mock Region",
            country: "Mock Country",
            area: "Mock Area",
          ),
        ),
      ],
      transportationReservations: [],
      prices: [],
    );

    fakeOrderService.onGetOrderDetails = () async => mockOrder;

    // Act
    await tester.pumpWidget(MaterialApp(
      home: MyTripScreen(orderService: fakeOrderService),
    ));

    // Allow the Future to complete
    await tester.pumpAndSettle();

    // Assert: Verify OrderCard and its content
    expect(find.byType(OrderCard), findsOneWidget);
    expect(find.text('Mock Resort'), findsOneWidget);
    expect(find.text('Mock Region, Mock Country'), findsOneWidget);
    expect(find.text('01.12 - 10.12'),
        findsOneWidget); // Matches padded date format
  });
}
