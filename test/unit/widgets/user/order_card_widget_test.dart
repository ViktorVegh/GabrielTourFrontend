import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/widgets/order_card_widget.dart';

void main() {
  group('OrderCard Basic Test', () {
    testWidgets('renders OrderCard details correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: OrderCard(
          year: '2023',
          resortName: 'Mock Resort',
          location: 'Mock City, Mock Country',
          orderNumber: '12345',
          travelDates: '01.12 - 10.12',
        ),
      ));

      // Verify widget details
      expect(find.text('2023'), findsOneWidget);
      expect(find.text('Mock Resort'), findsOneWidget);
      expect(find.text('Mock City, Mock Country'), findsOneWidget);
      expect(find.text('01.12 - 10.12'), findsOneWidget);
      expect(find.text('Číslo zájazdu 12345'), findsOneWidget);
    });
  });
}
