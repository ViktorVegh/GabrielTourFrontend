import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/user/additional_services_screen.dart';
import 'package:gabriel_tour_app/dtos/price_dto.dart';

void main() {
  testWidgets('AdditionalServicesScreen displays services correctly',
      (WidgetTester tester) async {
    // Arrange
    final services = [
      PriceDTO(
        id: 1,
        name: 'Spa Package',
        price: 200.0,
        currency: 'EUR',
        quantity: 1,
      ),
      PriceDTO(
        id: 2,
        name: 'City Tour',
        price: 50.0,
        currency: 'EUR',
        quantity: 2,
      ),
    ];

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AdditionalServicesScreen(services: services),
      ),
    ));

    await tester.pumpAndSettle(); // Ensure all UI updates are completed

    // Assert: Verify the app bar title
    expect(find.text('Doplnkové služby'), findsOneWidget);

    // Assert: Verify the details of the first service
    expect(find.text('Spa Package'), findsOneWidget);
    expect(find.text('200.00 EUR'), findsOneWidget);
    expect(find.text('x1'), findsOneWidget);

    // Assert: Verify the details of the second service
    expect(find.text('City Tour'), findsOneWidget);
    expect(find.text('50.00 EUR'), findsOneWidget);
    expect(find.text('x2'), findsOneWidget);
  });
}
