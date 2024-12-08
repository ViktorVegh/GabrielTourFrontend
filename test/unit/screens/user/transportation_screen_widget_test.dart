import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/widgets/transportation_card.dart';
import 'package:gabriel_tour_app/screens/user/transportation_screen.dart';
import 'package:gabriel_tour_app/dtos/transportation_reservation_dto.dart';

void main() {
  group('TransportationScreen Tests', () {
    testWidgets('displays no transportation message when list is empty',
        (WidgetTester tester) async {
      // Arrange
      final transportations = <TransportationReservationDTO>[];

      await tester.pumpWidget(
        MaterialApp(
          home: TransportationScreen(transportations: transportations),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No transportation details available.'), findsOneWidget);
      expect(find.byType(TransportationCard), findsNothing);
    });

    testWidgets('displays transportation details when list is not empty',
        (WidgetTester tester) async {
      // Arrange
      final transportations = [
        TransportationReservationDTO(
          id: 1,
          transportType: 40,
          startDate: '2023-12-10T09:00:00Z',
          pickupTime: '2023-12-10T09:00:00Z',
          departureAirportName: 'Airport A',
          dropoffTime: '2023-12-10T11:30:00Z',
          arrivalAirportName: 'Airport B',
        ),
        TransportationReservationDTO(
          id: 2,
          transportType: 30,
          startDate: '2023-12-11T14:00:00Z',
          pickupTime: '2023-12-11T14:00:00Z',
          departureAirportName: 'Station X',
          dropoffTime: '2023-12-11T16:00:00Z',
          arrivalAirportName: 'Station Y',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: TransportationScreen(transportations: transportations),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(TransportationCard), findsNWidgets(2)); // Two cards
      expect(find.text('Airport A'), findsOneWidget); // First card departure
      expect(find.text('Airport B'), findsOneWidget); // First card arrival
      expect(find.text('Station X'), findsOneWidget); // Second card departure
      expect(find.text('Station Y'), findsOneWidget); // Second card arrival
    });

    testWidgets('displays correct transport type based on transportType',
        (WidgetTester tester) async {
      // Arrange
      final transportations = [
        TransportationReservationDTO(
          id: 1,
          transportType: 40, // Flight
          startDate: '2023-12-10T09:00:00Z',
          pickupTime: '2023-12-10T09:00:00Z',
          departureAirportName: 'Airport A',
          dropoffTime: '2023-12-10T11:30:00Z',
          arrivalAirportName: 'Airport B',
        ),
        TransportationReservationDTO(
          id: 2,
          transportType: 30, // Bus
          startDate: '2023-12-11T14:00:00Z',
          pickupTime: '2023-12-11T14:00:00Z',
          departureAirportName: 'Station X',
          dropoffTime: '2023-12-11T16:00:00Z',
          arrivalAirportName: 'Station Y',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: TransportationScreen(transportations: transportations),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      final firstCardType = (tester.widget<TransportationCard>(
              find.byType(TransportationCard).at(0)))
          .type;
      final secondCardType = (tester.widget<TransportationCard>(
              find.byType(TransportationCard).at(1)))
          .type;

      expect(firstCardType, 'flight'); // First card transportType is flight
      expect(secondCardType, 'bus'); // Second card transportType is bus
    });
  });
}
