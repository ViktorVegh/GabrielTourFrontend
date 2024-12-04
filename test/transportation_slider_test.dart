// test/transportation_slider_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/transportation_slider_widget.dart';

void main() {
  testWidgets('TransportationSlider displays transportations correctly',
      (WidgetTester tester) async {
    // Arrange
    final transportations = [
      {
        'departureTime': TimeOfDay(hour: 8, minute: 0),
        'departurePlace': 'Departure A',
        'arrivalTime': TimeOfDay(hour: 10, minute: 0),
        'arrivalPlace': 'Arrival A',
        'date': '1.12.2023',
        'type': 'flight',
      },
      {
        'departureTime': TimeOfDay(hour: 12, minute: 30),
        'departurePlace': 'Departure B',
        'arrivalTime': TimeOfDay(hour: 14, minute: 45),
        'arrivalPlace': 'Arrival B',
        'date': '2.12.2023',
        'type': 'bus',
      },
    ];

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TransportationSlider(
          transportations: transportations,
        ),
      ),
    ));

    // Assert
    // Verify the first transportation details
    expect(find.text('8:00 AM'), findsOneWidget);
    expect(find.text('Departure A'), findsOneWidget);
    expect(find.text('10:00 AM'), findsOneWidget);
    expect(find.text('Arrival A'), findsOneWidget);
    expect(find.text('DATUM: 1.12.2023'), findsOneWidget);

    // Swipe to the next transportation
    await tester.drag(find.byType(PageView), Offset(-400, 0));
    await tester.pumpAndSettle();

    // Verify the second transportation details
    expect(find.text('12:30 PM'), findsOneWidget);
    expect(find.text('Departure B'), findsOneWidget);
    expect(find.text('2:45 PM'), findsOneWidget);
    expect(find.text('Arrival B'), findsOneWidget);
    expect(find.text('DATUM: 2.12.2023'), findsOneWidget);
  });
}
