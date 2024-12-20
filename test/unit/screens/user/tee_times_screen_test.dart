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
          transport: true,
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
          transport: true,
          holes: 9,
          adults: 4,
          juniors: 0,
          note: null,
        ),
      ];

      final golfCourseNames = ['Sunny Golf Club', 'Rainy Golf Club'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                TeeTimeWidget(
                  teeTime: teeTimes[0],
                  golfCourseName: golfCourseNames[0],
                ),
                TeeTimeWidget(
                  teeTime: teeTimes[1],
                  golfCourseName: golfCourseNames[1],
                ),
              ],
            ),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(TeeTimeWidget), findsNWidgets(2));
      expect(find.text('Sunny Golf Club'), findsOneWidget);
      expect(find.text('Rainy Golf Club'), findsOneWidget);
      expect(find.text('Morning round'), findsOneWidget);
    });
    testWidgets('renders correct data in TeeTimeWidget for each tee time',
        (WidgetTester tester) async {
      // Arrange
      final teeTime = TeeTimeDTO(
        id: 1,
        teeTime: DateTime(2023, 12, 10, 9, 30),
        groupSize: 3,
        userIds: [101, 102, 103],
        golfCourseId: 1,
        green: true,
        transport: true,
        holes: 18,
        adults: 3,
        juniors: 0,
        note: 'Morning round',
      );

      final golfCourseName = 'Sunny Golf Club';

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

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Sunny Golf Club'), findsOneWidget);
      expect(find.text('10.12.2023'), findsOneWidget);
      expect(find.text('9:30'), findsOneWidget);
      expect(find.text('3/4'), findsOneWidget);
      expect(find.text('Morning round'), findsOneWidget);
    });
  });
}
