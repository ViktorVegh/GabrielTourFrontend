import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/user/accommodation_screen.dart';
import 'package:gabriel_tour_app/dtos/accommodation_dto.dart';
import 'package:gabriel_tour_app/dtos/hotel_dto.dart';

void main() {
  testWidgets('AccommodationScreen displays accommodation details correctly',
      (WidgetTester tester) async {
    // Arrange: Create mock data for the accommodation
    final accommodation = AccommodationReservationDTO(
      id: 101,
      startDate: '2023-12-01T00:00:00',
      beds: 2,
      extraBeds: 1,
      numberOfNights: 9,
      accommodationName: 'Mock Accommodation',
      note: 'No special notes',
      mealType: 'All Inclusive',
      hotel: HotelDTO(
        id: 201,
        name: 'Mock Hotel',
        stars: 4,
        region: 'Mock Region',
        country: 'Mock Country',
        area: 'Mock Area',
      ),
    );

    // Act: Render the AccommodationScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccommodationScreen(accommodation: accommodation),
        ),
      ),
    );

    await tester.pumpAndSettle(); // Ensuring all UI updates are completed

    // Assert: Verify that the expected elements appear on the screen
    expect(find.text('Mock Hotel'), findsOneWidget); // Hotel name
    expect(find.byIcon(Icons.star), findsNWidgets(4)); // 4 stars
    expect(find.text('Mock Region, Mock Country'), findsOneWidget); // Location
    expect(find.text('Detaily ubytovania'), findsOneWidget); // Section title

    // Use find.byWidgetPredicate for RichText content
    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText &&
            widget.text.toPlainText() == 'Názov: Mock Accommodation'),
        findsOneWidget); // Accommodation name
    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText && widget.text.toPlainText() == 'Počet nocí: 9'),
        findsOneWidget); // Number of nights
    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText &&
            widget.text.toPlainText() == 'Strava: All Inclusive'),
        findsOneWidget); // Meal type
    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText &&
            widget.text.toPlainText() == 'Poznámky: No special notes'),
        findsOneWidget); // Notes
  });
}
