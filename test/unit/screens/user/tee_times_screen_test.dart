import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/screens/user/tee_times.dart';
import 'package:gabriel_tour_app/widgets/tee_time_widget.dart';
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';

void main() {
  group('TeeTimesScreen Tests', () {
    testWidgets('displays no tee times message when list is empty',
        (WidgetTester tester) async {
      // Arrange
      final teeTimes = <TeeTimeDTO>[];

      await tester.pumpWidget(
        MaterialApp(
          home: TeeTimesScreen(teeTimes: teeTimes),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No Tee Times available for this user'), findsOneWidget);
      expect(find.byType(TeeTimeWidget), findsNothing);
    });

    testWidgets('displays tee times when list is not empty',
        (WidgetTester tester) async {
      // Arrange
      final teeTimes = [
        TeeTimeDTO(
          id: 1,
          teeTime: DateTime(2023, 12, 10, 9, 30),
          groupSize: 3,
          userIds: [101, 102, 103],
          golfCourseId: 1,
          green: true,
          holes: 18,
          adults: 3,
          juniors: 0,
          note: 'Morning round',
        ),
        TeeTimeDTO(
          id: 2,
          teeTime: DateTime(2023, 12, 11, 14, 0),
          groupSize: 4,
          userIds: [104, 105, 106, 107],
          golfCourseId: 2,
          green: false,
          holes: 9,
          adults: 4,
          juniors: 0,
          note: null,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: TeeTimesScreen(teeTimes: teeTimes),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(TeeTimeWidget), findsNWidgets(2)); // Two widgets
      expect(find.text('Golf Course Name'), findsNWidgets(2));
      expect(find.text('Morning round'), findsOneWidget);
    });

    testWidgets('renders correct data in TeeTimeWidget for each tee time',
        (WidgetTester tester) async {
      // Arrange
      final teeTimes = [
        TeeTimeDTO(
          id: 1,
          teeTime: DateTime(2023, 12, 10, 9, 30),
          groupSize: 3,
          userIds: [101, 102, 103],
          golfCourseId: 1,
          green: true,
          holes: 18,
          adults: 3,
          juniors: 0,
          note: 'Morning round',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: TeeTimesScreen(teeTimes: teeTimes),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Golf Course Name'),
          findsOneWidget); // Placeholder course name
      expect(find.text('10.12.2023'), findsOneWidget); // Date
      expect(find.textContaining('9:30'), findsOneWidget); // Time
      expect(find.text('3/4'), findsOneWidget); // Group size
      expect(find.text('Morning round'), findsOneWidget); // Note
    });
  });
}
