import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/widgets/transportation_slider_widget.dart';

void main() {
  group('TransportationSlider Tests', () {
    final transportations = [
      {
        'departureTime': TimeOfDay(hour: 9, minute: 0),
        'arrivalTime': TimeOfDay(hour: 11, minute: 30),
        'departurePlace': 'Station A',
        'arrivalPlace': 'Station B',
        'date': '01.12.2023',
      },
      {
        'departureTime': TimeOfDay(hour: 14, minute: 0),
        'arrivalTime': TimeOfDay(hour: 16, minute: 30),
        'departurePlace': 'Station C',
        'arrivalPlace': 'Station D',
        'date': '02.12.2023',
      },
    ];

    testWidgets('renders transportation cards', (WidgetTester tester) async {
      // Rendering the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: TransportationSlider(transportations: transportations),
          ),
        ),
      );

      expect(find.text('Station A'), findsOneWidget);
      expect(find.text('Station B'), findsOneWidget);

      final departureTimeText =
          (transportations[0]['departureTime'] as TimeOfDay).format(
        tester.element(find.text('Station A')),
      );
      final arrivalTimeText =
          (transportations[0]['arrivalTime'] as TimeOfDay).format(
        tester.element(find.text('Station A')),
      );

      expect(find.text(departureTimeText), findsOneWidget);
      expect(find.text(arrivalTimeText), findsOneWidget);
      expect(find.text('DATUM: 01.12.2023'), findsOneWidget);

      // Swiping to the second transportation card
      await tester.drag(
        find.byType(PageView),
        const Offset(-400, 0), // Swipe left
      );
      await tester.pumpAndSettle();

      // Find and verify the second transportation details
      expect(find.text('Station C'), findsOneWidget);
      expect(find.text('Station D'), findsOneWidget);

      final secondDepartureTimeText =
          (transportations[1]['departureTime'] as TimeOfDay).format(
        tester.element(find.text('Station C')),
      );
      final secondArrivalTimeText =
          (transportations[1]['arrivalTime'] as TimeOfDay).format(
        tester.element(find.text('Station C')),
      );

      expect(find.text(secondDepartureTimeText), findsOneWidget);
      expect(find.text(secondArrivalTimeText), findsOneWidget);
      expect(find.text('DATUM: 02.12.2023'), findsOneWidget);
    });

    testWidgets('renders correct number of dots for transportations',
        (WidgetTester tester) async {
      // Rendering the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: TransportationSlider(transportations: transportations),
          ),
        ),
      );

      // Verify the correct number of dots
      expect(find.byType(CircleAvatar), findsNWidgets(transportations.length));
    });
  });
}
