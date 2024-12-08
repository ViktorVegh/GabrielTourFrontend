import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabriel_tour_app/widgets/tee_time_widget.dart';
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';

void main() {
  group('TeeTimeWidget Tests', () {
    testWidgets('displays correct golf course name, date, time, and group size',
        (WidgetTester tester) async {
      // Arrange
      final teeTime = TeeTimeDTO(
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
      );
      const golfCourseName = 'Sunny Golf Club';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TeeTimeWidget(
              teeTime: teeTime,
              golfCourseName: golfCourseName,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Sunny Golf Club'), findsOneWidget);
      expect(find.text('10.12.2023'), findsOneWidget);
      expect(find.textContaining('9:30'), findsOneWidget);
      expect(find.text('3/4'), findsOneWidget);
      expect(find.text('Morning round'), findsOneWidget);
    });

    testWidgets('renders without note if note is null',
        (WidgetTester tester) async {
      // Arrange
      final teeTime = TeeTimeDTO(
        id: 1,
        teeTime: DateTime(2023, 12, 10, 9, 30),
        groupSize: 4,
        userIds: [101, 102, 103, 104],
        golfCourseId: 1,
        green: true,
        holes: 18,
        adults: 4,
        juniors: 0,
        note: null,
      );
      const golfCourseName = 'Sunny Golf Club';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TeeTimeWidget(
              teeTime: teeTime,
              golfCourseName: golfCourseName,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Sunny Golf Club'), findsOneWidget);
      expect(find.text('10.12.2023'), findsOneWidget);
      expect(find.textContaining('9:30'), findsOneWidget);
      expect(find.text('4/4'), findsOneWidget);
      expect(find.text('Morning round'), findsNothing);
    });

    testWidgets('handles long golf course name gracefully',
        (WidgetTester tester) async {
      // Arrange
      final teeTime = TeeTimeDTO(
        id: 1,
        teeTime: DateTime(2023, 12, 10, 9, 30),
        groupSize: 2,
        userIds: [101, 102],
        golfCourseId: 1,
        green: true,
        holes: 18,
        adults: 2,
        juniors: 0,
        note: 'Early morning tee off',
      );
      const longGolfCourseName =
          'Super Long Golf Course Name That Exceeds Usual Length';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TeeTimeWidget(
              teeTime: teeTime,
              golfCourseName: longGolfCourseName,
            ),
          ),
        ),
      );

      // Assert
      expect(find.textContaining('Super Long Golf Course'), findsOneWidget);
      expect(find.text('2/4'), findsOneWidget);
    });
  });
}
