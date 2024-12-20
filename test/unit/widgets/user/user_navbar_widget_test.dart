import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gabriel_tour_app/widgets/user_navbar.dart';

void main() {
  group('UserNavbar Tests', () {
    testWidgets('renders correct icons and labels',
        (WidgetTester tester) async {
      // Arrange
      const currentIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: UserNavbar(
              currentIndex: currentIndex,
              onTap: (_) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(SvgPicture), findsNWidgets(4));
      expect(find.text('Vyhľadaj zájazdy'), findsOneWidget); // Tab label
      expect(find.text('Môj zájazd'), findsOneWidget); // Tab label
      expect(find.text('Správy'), findsOneWidget); // Tab label
      expect(find.text('Profil'), findsOneWidget); // Tab label
    });

    testWidgets('calls onTap with correct index on tap',
        (WidgetTester tester) async {
      // Arrange
      int selectedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: UserNavbar(
              currentIndex: 0,
              onTap: (index) {
                selectedIndex = index; // Captures tapped index
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Môj zájazd'));
      await tester.pumpAndSettle();

      // Assert
      expect(selectedIndex, 1); // Verify the correct tab index was tapped
    });
  });
}
