// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:test/test.dart';

// void main() {
//   group('End-to-End Tests for AuthScreen', () {
//     late FlutterDriver flutterDriver;

//     // Connect to Flutter Driver before running any tests
//     setUpAll(() async {
//       print('DEBUG: Connecting to Flutter driver...');
//       flutterDriver = await FlutterDriver.connect();
//       final health = await flutterDriver.checkHealth();
//       print('DEBUG: Flutter driver connected. Health status: ${health.status}');
//     });

//     // Disconnect Flutter Driver after all tests
//     tearDownAll(() async {
//       print('DEBUG: Closing Flutter driver...');
//       await flutterDriver.close();
//       print('DEBUG: Flutter driver closed.');
//     });

//     /// Helper function to interact with a TextField by its key
//     Future<void> enterText(
//         FlutterDriver driver, String key, String text) async {
//       print('DEBUG: Locating $key field...');
//       final field = find.byValueKey(key);
//       await driver.waitFor(field);
//       print('DEBUG: Tapping $key field...');
//       await driver.tap(field);
//       print('DEBUG: Entering text into $key field...');
//       await driver.enterText(text);
//       await Future.delayed(Duration(milliseconds: 300)); // Stability delay
//     }

// test('AuthScreen Minimal Interaction Test', () async {
//   print('DEBUG: Starting minimal interaction test...');

//   // Locate and tap login button
//   final loginButton = find.byValueKey('login_button');
//   await flutterDriver.waitFor(loginButton);
//   print('DEBUG: login_button is visible.');
//   await flutterDriver.tap(loginButton);
//   print('DEBUG: Tapped login_button.');

//   // Scroll until the email field is visible and interactive
//   final emailField = find.byValueKey('email_field');
//   try {
//     await flutterDriver.scrollUntilVisible(
//       find.byValueKey('auth_screen_scroll'), // Scrollable area
//       emailField, // Target field
//       dyScroll: -300, // Adjust scrolling direction and magnitude as needed
//     );
//     print('DEBUG: email_field is visible after scrolling.');
//   } catch (scrollError) {
//     print('ERROR: Failed to scroll email_field into view: $scrollError');
//     throw Exception('Scrolling to email_field failed.');
//   }

//   // Small delay to allow UI to stabilize
//   await Future.delayed(Duration(milliseconds: 300));

//   // Debugging: Dump UI tree to check visibility and accessibility
//   try {
//     final uiTree = await flutterDriver.requestData('debug_tree');
//     print('DEBUG: UI Tree: $uiTree');
//   } catch (uiTreeError) {
//     print('ERROR: Failed to retrieve UI tree: $uiTreeError');
//   }

//   // Try to focus and tap the email field
//   try {
//     await flutterDriver.tap(emailField);
//     print('DEBUG: Successfully tapped email_field.');
//   } catch (e) {
//     print('ERROR: Failed to tap email_field: $e');

//     // Fallback: Attempt to tap using coordinates
//     try {
//       final emailFieldOffset = await flutterDriver.getTopLeft(emailField);
//       print(
//           'DEBUG: email_field position: ${emailFieldOffset.dx}, ${emailFieldOffset.dy}');

//       // Offset the coordinates manually
//       final offsetX = emailFieldOffset.dx + 5; // Add a small offset
//       final offsetY = emailFieldOffset.dy + 5; // Add a small offset
//       await flutterDriver.tap(Offset(offsetX, offsetY));

//       print('DEBUG: Successfully tapped email_field using coordinates.');
//     } catch (fallbackError) {
//       print(
//           'ERROR: Failed to tap email_field using fallback coordinates: $fallbackError');
//       throw Exception('email_field interaction failed by all methods.');
//     }
//   }

//   // Enter text in email field
//   try {
//     await flutterDriver.enterText('user@example.com');
//     print('DEBUG: Successfully entered text into email_field.');
//   } catch (e) {
//     print('ERROR: Failed to enter text into email_field: $e');
//     throw Exception('email_field text entry failed.');
//   }

//   // Wait for stabilization
//   await flutterDriver.waitUntilNoTransientCallbacks();
//   print('DEBUG: Minimal interaction test completed.');
// });

//     /// Test 1: Successful Login
//     test('Login Flow - Successful Login', () async {
//       print('DEBUG: Waiting for AuthScreen to load...');
//       await flutterDriver.waitFor(find.byValueKey('auth_screen'),
//           timeout: Duration(seconds: 60));
//       await flutterDriver.waitUntilNoTransientCallbacks();

//       print('DEBUG: Locating login button...');
//       final loginButton = find.byValueKey('login_button');
//       await flutterDriver.waitFor(loginButton);
//       await flutterDriver.tap(loginButton);

//       print('DEBUG: Interacting with email_field...');
//       await flutterDriver.scrollUntilVisible(
//         find.byValueKey('auth_screen_scroll'),
//         find.byValueKey('email_field'),
//         dyScroll: -300,
//       );
//       await flutterDriver.waitFor(find.byValueKey('email_field'));
//       await flutterDriver.tap(find.byValueKey('email_field'));
//       await flutterDriver.enterText('user@example.com');

//       print('DEBUG: Interacting with password_field...');
//       await flutterDriver.waitFor(find.byValueKey('password_field'));
//       await flutterDriver.tap(find.byValueKey('password_field'));
//       await flutterDriver.enterText('password123');

//       print('DEBUG: Submitting login form...');
//       await flutterDriver.tap(loginButton);

//       print('DEBUG: Verifying navigation to User Trips screen...');
//       await flutterDriver.waitFor(find.byValueKey('userTrips_screen'),
//           timeout: Duration(seconds: 10));
//       print('DEBUG: Navigation verified.');
//     });

//     /// Test 2: Unsuccessful Login
//     test('Login Flow - Unsuccessful Login', () async {
//       print('DEBUG: Locating login button...');
//       final loginButton = find.byValueKey('login_button');
//       await flutterDriver.waitFor(loginButton);
//       await flutterDriver.tap(loginButton);

//       await enterText(flutterDriver, 'email_field', 'invalid@example.com');
//       await enterText(flutterDriver, 'password_field', 'wrongpassword');

//       print('DEBUG: Tapping login button...');
//       await flutterDriver.tap(loginButton);

//       print('DEBUG: Verifying error dialog...');
//       await flutterDriver.waitFor(find.text('Chyba'),
//           timeout: Duration(seconds: 5));
//       await flutterDriver.waitFor(find.text('Prihlásenie zlyhalo'),
//           timeout: Duration(seconds: 5));
//       print('DEBUG: Error dialog verified.');
//     });

//     /// Test 3: Password Reset Flow - Successful Request
//     test('Password Reset Flow - Successful Request', () async {
//       print('DEBUG: Switching to reset password mode...');
//       final resetModeButton = find.byValueKey('reset_mode_button');
//       await flutterDriver.waitFor(resetModeButton);
//       await flutterDriver.tap(resetModeButton);

//       await enterText(flutterDriver, 'email_field', 'user@example.com');

//       print('DEBUG: Tapping submit button...');
//       final submitButton = find.byValueKey('submit_button');
//       await flutterDriver.waitFor(submitButton);
//       await flutterDriver.tap(submitButton);

//       print('DEBUG: Verifying success dialog...');
//       await flutterDriver.waitFor(find.text('Úspech'),
//           timeout: Duration(seconds: 5));
//       await flutterDriver.waitFor(
//           find.text('Odkaz na obnovenie hesla bol odoslaný na váš email.'),
//           timeout: Duration(seconds: 5));
//       print('DEBUG: Success dialog verified.');
//     });

//     /// Test 4: Password Reset Flow - Failed Request
//     test('Password Reset Flow - Failed Request', () async {
//       print('DEBUG: Switching to reset password mode...');
//       final resetModeButton = find.byValueKey('reset_mode_button');
//       await flutterDriver.waitFor(resetModeButton);
//       await flutterDriver.tap(resetModeButton);

//       await enterText(flutterDriver, 'email_field', 'nonexistent@example.com');

//       print('DEBUG: Tapping submit button...');
//       final submitButton = find.byValueKey('submit_button');
//       await flutterDriver.waitFor(submitButton);
//       await flutterDriver.tap(submitButton);

//       print('DEBUG: Verifying error dialog...');
//       await flutterDriver.waitFor(find.text('Chyba'),
//           timeout: Duration(seconds: 5));
//       await flutterDriver.waitFor(find.text('Email nebol nájdený.'),
//           timeout: Duration(seconds: 5));
//       print('DEBUG: Error dialog verified.');
//     });

//     /// Test 5: Toggle Between Login and Reset Password Modes
//     test('Toggle Between Login and Reset Password Modes', () async {
//       print('DEBUG: Switching to reset password mode...');
//       final toggleModeButton = find.byValueKey('reset_mode_button');
//       await flutterDriver.waitFor(toggleModeButton);
//       await flutterDriver.tap(toggleModeButton);

//       print('DEBUG: Verifying reset password mode...');
//       await flutterDriver.waitFor(find.byValueKey('submit_button'),
//           timeout: Duration(seconds: 5));
//       print('DEBUG: Reset password mode verified.');

//       print('DEBUG: Switching back to login mode...');
//       await flutterDriver.tap(toggleModeButton);

//       print('DEBUG: Verifying login mode...');
//       await flutterDriver.waitFor(find.byValueKey('login_button'),
//           timeout: Duration(seconds: 5));
//       print('DEBUG: Login mode verified.');
//     });
//   });
//}
