import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gabriel_tour_app/screens/auth.dart';
import 'package:gabriel_tour_app/dtos/login_request.dart';
import '../../../mocks/generate_mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockJwtService mockJwtService;

  setUp(() {
    mockAuthService = MockAuthService();
    mockJwtService = MockJwtService();
  });

  group('AuthScreen Tests', () {
    testWidgets('displays login screen by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AuthScreen(
            authService: mockAuthService,
            jwtService: mockJwtService,
          ),
        ),
      );

      expect(find.text('Prihlásenie'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Heslo'), findsOneWidget);
      expect(find.text('Prihlásiť sa'), findsOneWidget);
    });

    testWidgets('toggles between login and reset password modes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AuthScreen(
            authService: mockAuthService,
            jwtService: mockJwtService,
          ),
        ),
      );

      // Finder for the RichText containing "Vytvorenie hesla"
      final vytvorenieHeslaFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Vytvorenie hesla'),
      );

      // Tap toggle button to switch modes
      await tester.tap(vytvorenieHeslaFinder);
      await tester.pump();

      expect(find.text('Vytvorenie hesla'), findsOneWidget);
      expect(find.text('Odoslať overovací email'), findsOneWidget);
    });

    testWidgets('performs login with valid credentials',
        (WidgetTester tester) async {
      const email = 'test@example.com';
      const password = 'password123';
      const token = 'mockToken';

      when(mockAuthService.login(any)).thenAnswer((_) async => token);
      when(mockJwtService.saveToken(token)).thenAnswer((_) async => {});

      await tester.pumpWidget(
        MaterialApp(
          home: AuthScreen(
            authService: mockAuthService,
            jwtService: mockJwtService,
          ),
        ),
      );

      await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
      await tester.enterText(find.widgetWithText(TextField, 'Heslo'), password);

      await tester.tap(find.text('Prihlásiť sa'));
      await tester.pumpAndSettle();

      verify(mockAuthService.login(argThat(isA<LoginRequest>()))).called(1);
      verify(mockJwtService.saveToken(token)).called(1);
    });

    testWidgets('handles reset password flow', (WidgetTester tester) async {
      const email = 'test@example.com';
      const successMessage = 'Password reset link has been sent to your email.';

      when(mockAuthService.resetPassword(email))
          .thenAnswer((_) async => successMessage);

      await tester.pumpWidget(
        MaterialApp(
          home: AuthScreen(
            authService: mockAuthService,
            jwtService: mockJwtService,
          ),
        ),
      );

      // Finder for RichText containing "Vytvorenie hesla"
      final vytvorenieHeslaFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Vytvorenie hesla'),
      );

      await tester.tap(vytvorenieHeslaFinder);
      await tester.pump();

      await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
      await tester.tap(find.text('Odoslať overovací email'));
      await tester.pumpAndSettle();

      verify(mockAuthService.resetPassword(email)).called(1);
      expect(find.text('Odkaz na obnovenie hesla bol odoslaný na váš email.'),
          findsOneWidget);
    });

    testWidgets('displays error if reset password fails',
        (WidgetTester tester) async {
      const email = 'test@example.com';
      const errorMessage = 'Email nebol nájdený.';

      when(mockAuthService.resetPassword(email))
          .thenAnswer((_) async => errorMessage);

      await tester.pumpWidget(
        MaterialApp(
          home: AuthScreen(
            authService: mockAuthService,
            jwtService: mockJwtService,
          ),
        ),
      );

      // Toggle to reset password mode
      final vytvorenieHeslaFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Vytvorenie hesla'),
      );

      expect(
          vytvorenieHeslaFinder, findsOneWidget); // Ensuring the toggle exists
      await tester.tap(vytvorenieHeslaFinder);
      await tester.pumpAndSettle();

      // Entering email and tap the reset button
      await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
      await tester.tap(find.text('Odoslať overovací email'));
      await tester.pumpAndSettle();

      // Checking for the dialog
      debugDumpApp(); // Dumping the widget tree for analysis
      verify(mockAuthService.resetPassword(email)).called(1);
      expect(find.text('Chyba'),
          findsOneWidget); // Ensuring dialog title is present
      expect(find.text(errorMessage),
          findsOneWidget); // Checking for the error message
    });
  });
}
