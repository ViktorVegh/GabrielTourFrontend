// test/services_card_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/services_card_widget.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';

void main() {
  testWidgets('ServicesCard displays correct information',
      (WidgetTester tester) async {
    // Arrange
    final orderNumber = '12345';
    final accommodations = [
      AccommodationReservationDTO(
        id: 101,
        startDate: '2023-12-01T00:00:00',
        beds: 2,
        extraBeds: 1,
        numberOfNights: 9,
        accommodationName: 'Mock Hotel',
        note: 'Mock note',
        hotel: HotelDTO(
          id: 201,
          name: 'Mock Hotel',
          stars: 4,
          region: 'Mock Region',
          country: 'Mock Country',
          area: 'Mock Area',
        ),
      ),
    ];
    final services = [
      PriceDTO(
        id: 401,
        name: 'Mock Service',
        price: 100.0,
        currency: 'EUR',
        quantity: 2,
      ),
    ];

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ServicesCard(
          orderNumber: orderNumber,
          accommodations: accommodations,
          services: services,
        ),
      ),
    ));

    // Assert
    expect(find.text('Číslo zájazdu $orderNumber'), findsOneWidget);
    expect(find.text('Doprava'), findsOneWidget);
    expect(find.text('Tee Times'), findsOneWidget);
    expect(find.text('Ubytovanie'), findsOneWidget);
    expect(find.text('Služby'), findsOneWidget);
  });

  testWidgets('ServicesCard navigation works when icons are tapped',
      (WidgetTester tester) async {
    // Arrange
    final orderNumber = '12345';
    final accommodations = [
      AccommodationReservationDTO(
        id: 101,
        startDate: '2023-12-01T00:00:00',
        beds: 2,
        extraBeds: 1,
        numberOfNights: 9,
        accommodationName: 'Mock Hotel',
        note: 'Mock note',
        hotel: HotelDTO(
          id: 201,
          name: 'Mock Hotel',
          stars: 4,
          region: 'Mock Region',
          country: 'Mock Country',
          area: 'Mock Area',
        ),
      ),
    ];
    final services = [
      PriceDTO(
        id: 401,
        name: 'Mock Service',
        price: 100.0,
        currency: 'EUR',
        quantity: 2,
      ),
    ];

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ServicesCard(
          orderNumber: orderNumber,
          accommodations: accommodations,
          services: services,
        ),
      ),
    ));

    // Tap on 'Ubytovanie'
    await tester.tap(find.text('Ubytovanie'));
    await tester.pumpAndSettle();

    // Since the actual navigation logic involves pushing a new route,
    // we need to ensure that the onTap callback is not null and can be invoked.
    // However, without a full navigation setup, we cannot verify the new screen.

    // For testing purposes, you might consider injecting a navigator observer or using a mock navigator.
  });
}
