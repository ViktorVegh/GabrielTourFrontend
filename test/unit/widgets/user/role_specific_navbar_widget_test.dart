import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/widgets/user_navbar.dart';

void main() {
  group('RoleSpecificNavbar Tests', () {
    testWidgets('displays UserNavbar when role is "user"',
        (WidgetTester tester) async {
      // Arrange
      const role = 'user';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RoleSpecificNavbar(
            role: role,
            initialIndex: 0,
            child: Container(),
          ),
        ),
      );

      // Assert
      expect(find.byType(UserNavbar), findsOneWidget);
    });

    testWidgets('displays correct navbar for role "tourguide"',
        (WidgetTester tester) async {
      // Arrange
      const role = 'tourguide';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: RoleSpecificNavbar(
            role: role,
            initialIndex: 0,
            child: Container(),
          ),
        ),
      );

      // Assert
      expect(find.byType(UserNavbar), findsNothing);
    });

    testWidgets('updates selected tab index on tap for UserNavbar',
        (WidgetTester tester) async {
      // Arrange
      const role = 'user';

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/myTrips': (context) => Container(),
            '/messages': (context) => Container(),
            '/profile': (context) => Container(),
          },
          home: RoleSpecificNavbar(
            role: role,
            initialIndex: 0,
            child: Container(),
          ),
        ),
      );

      // Act

      await tester.tap(find.text('Môj zájazd'));
      await tester.pumpAndSettle();

      // Assert
      // Verify navigation to the correct route
      expect(find.byType(Container), findsOneWidget); // Navigates to '/myTrips'
    });

    testWidgets('renders correct navigation and calls correct callback',
        (WidgetTester tester) async {
      // Arrange
      const role = 'user';
      String? navigatedRoute;

      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            navigatedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => Container());
          },
          home: RoleSpecificNavbar(
            role: role,
            initialIndex: 0,
            child: Container(),
          ),
        ),
      );

      // Act

      await tester.tap(find.text('Správy'));
      await tester.pumpAndSettle();

      // Assert
      expect(navigatedRoute, '/messages');
    });
  });
}
