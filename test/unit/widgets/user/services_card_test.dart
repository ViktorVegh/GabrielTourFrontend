import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/widgets/services_card_widget.dart';
import 'package:gabriel_tour_app/screens/user/tee_times.dart';
import 'package:gabriel_tour_app/screens/user/transportation_screen.dart';
import 'package:gabriel_tour_app/screens/user/accommodation_screen.dart';
import 'package:gabriel_tour_app/screens/user/additional_services_screen.dart';
import 'package:gabriel_tour_app/dtos/hotel_dto.dart';
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';
import 'package:gabriel_tour_app/dtos/transportation_reservation_dto.dart';
import 'package:gabriel_tour_app/dtos/accommodation_dto.dart';
import 'package:gabriel_tour_app/dtos/price_dto.dart';

void main() {
  group('ServicesCard Tests', () {
    Future<void> pumpWidgetWithNavigation(
      WidgetTester tester,
      Widget widget,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: widget,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/transportation':
                final args =
                    settings.arguments as List<TransportationReservationDTO>;
                return MaterialPageRoute(
                  builder: (context) => TransportationScreen(
                    transportations: args,
                  ),
                );
              case '/tee_times':
                final args = settings.arguments as List<TeeTimeDTO>;
                return MaterialPageRoute(
                  builder: (context) => TeeTimesScreen(
                    teeTimes: args,
                  ),
                );
              case '/accommodation':
                final args = settings.arguments as AccommodationReservationDTO;
                return MaterialPageRoute(
                  builder: (context) => AccommodationScreen(
                    accommodation: args,
                  ),
                );
              case '/services':
                final args = settings.arguments as List<PriceDTO>;
                return MaterialPageRoute(
                  builder: (context) => AdditionalServicesScreen(
                    services: args,
                  ),
                );
              default:
                return null;
            }
          },
        ),
      );
    }

    testWidgets('renders all service icons with labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ServicesCard(
            orderNumber: '12345',
            accommodations: [],
            services: [],
            teeTimes: [],
            transportations: [],
          ),
        ),
      );

      expect(find.text('Číslo zájazdu 12345'), findsOneWidget);
      expect(find.text('Doprava'), findsOneWidget);
      expect(find.text('Tee Times'), findsOneWidget);
      expect(find.text('Ubytovanie'), findsOneWidget);
      expect(find.text('Služby'), findsOneWidget);
    });

    testWidgets('navigates to TransportationScreen on Doprava tap',
        (WidgetTester tester) async {
      final transportations = [
        TransportationReservationDTO(
          id: 1,
          pickupTime: "2023-12-01T08:00:00",
          dropoffTime: "2023-12-01T10:00:00",
          startDate: "2023-12-01",
          transportType: 40,
          departureAirportName: "Mock Airport A",
          arrivalAirportName: "Mock Airport B",
          routeName: "Route 1",
        ),
      ];

      await pumpWidgetWithNavigation(
        tester,
        ServicesCard(
          orderNumber: '12345',
          accommodations: [],
          services: [],
          teeTimes: [],
          transportations: transportations,
        ),
      );

      await tester.tap(find.text('Doprava'));
      await tester.pumpAndSettle();

      expect(find.byType(TransportationScreen), findsOneWidget);
    });

    testWidgets('navigates to TeeTimesScreen on Tee Times tap',
        (WidgetTester tester) async {
      final teeTimes = [
        TeeTimeDTO(
          id: 1,
          teeTime: DateTime.parse("2023-12-01T08:00:00"),
          groupSize: 4,
          userIds: [1, 2, 3],
          golfCourseId: 101,
          green: true,
          holes: 18,
          adults: 3,
          juniors: 1,
          note: "Morning tee time",
        ),
      ];

      await pumpWidgetWithNavigation(
        tester,
        ServicesCard(
          orderNumber: '12345',
          accommodations: [],
          services: [],
          teeTimes: teeTimes,
          transportations: [],
        ),
      );

      await tester.tap(find.text('Tee Times'));
      await tester.pumpAndSettle();

      expect(find.byType(TeeTimesScreen), findsOneWidget);
    });

    testWidgets('navigates to AccommodationScreen when accommodations exist',
        (WidgetTester tester) async {
      // Mock HotelDTO
      final hotel = HotelDTO(
        id: 101,
        name: 'Mock Hotel',
        stars: 4,
        region: 'Mock Region',
        country: 'Mock Country',
        area: 'Mock Area',
      );

      final accommodations = [
        AccommodationReservationDTO(
          id: 1,
          startDate: '2023-12-01',
          beds: 2,
          extraBeds: 1,
          numberOfNights: 3,
          accommodationName: 'Mock Hotel',
          note: '',
          hotel: hotel,
        ),
      ];

      await pumpWidgetWithNavigation(
        tester,
        ServicesCard(
          orderNumber: '12345',
          accommodations: accommodations,
          services: [],
          teeTimes: [],
          transportations: [],
        ),
      );

      // Tap on Ubytovanie
      await tester.tap(find.text('Ubytovanie'));
      await tester.pumpAndSettle();

      // Verify navigation to AccommodationScreen
      expect(find.byType(AccommodationScreen), findsOneWidget);
    });

    testWidgets('navigates to AdditionalServicesScreen when services exist',
        (WidgetTester tester) async {
      final services = [
        PriceDTO(
          id: 1,
          name: 'Spa Package',
          price: 200.0,
          currency: 'EUR',
          quantity: 1,
        ),
      ];

      await pumpWidgetWithNavigation(
        tester,
        ServicesCard(
          orderNumber: '12345',
          accommodations: [],
          services: services,
          teeTimes: [],
          transportations: [],
        ),
      );

      await tester.tap(find.text('Služby'));
      await tester.pumpAndSettle();

      expect(find.byType(AdditionalServicesScreen), findsOneWidget);
    });
  });
}
