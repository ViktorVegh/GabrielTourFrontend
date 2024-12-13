import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';
import 'package:gabriel_tour_app/dtos/login_request.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'dart:developer';

class AuthScreen extends StatefulWidget {
  final AuthService authService;
  final JwtService jwtService;

  const AuthScreen({
    Key? key,
    required this.authService,
    required this.jwtService,
  }) : super(key: key);

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  void _submit() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();

  if (_isLoginMode) {
    if (email.isEmpty || password.isEmpty) {
      _showError("Email and password cannot be empty");
      return;
    }

    try {
      // Perform login and get the token
      final token = await widget.authService.login(
        LoginRequest(email: email, password: password),
      );

      // Save the token
      await widget.jwtService.saveToken(token);

      // Decode the user role from the token
      final String role = widget.jwtService.getRoleFromToken(token);

      // Navigate based on the role
      if (role == 'office') {
        Navigator.pushReplacementNamed(context, '/officeDashboard');
      } else if (role == 'user') {
        Navigator.pushReplacementNamed(context, '/userTrips');
      } else if (role == 'tourGuide') {
        Navigator.pushReplacementNamed(context, '/tourGuideTrips');
      } else if (role == 'driver') {
        Navigator.pushReplacementNamed(context, '/driverCalendar');
      } else {
        _showError("Unknown role. Please contact support.");
      }
    } catch (error) {
      _showError("Login failed: ${error.toString()}");
    }
  } else {
    // Reset password logic
    if (email.isEmpty) {
      _showError("Enter the email you use for Gabriel Tour.");
      return;
    }

    try {
      final responseMessage = await widget.authService.resetPassword(email);

      if (responseMessage ==
          "Password reset link has been sent to your email.") {
        _showSuccess("Password reset link sent to your email.");
      } else {
        _showError("Email not found.");
      }
    } catch (e) {
      _showError("Error: Unable to send password reset email.");
    }
  }
}

  void _showError(String message) {
    log('DEBUG: Showing error dialog with message: $message');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Chyba"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showSuccess(String message) {
    log('DEBUG: Showing success dialog with message: $message');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Úspech"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: const ValueKey('auth_screen'),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            key: const ValueKey('auth_screen_scroll'),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Image.asset(
                    'assets/icons/gabrieltour-logo-2023.png',
                    height: screenHeight * 0.1,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    _isLoginMode ? 'Prihlásenie' : 'Vytvorenie hesla',
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5C4033),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TextField(
                    key: const ValueKey('email_field'),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Zadajte email, ktorý používate v Gabriel Tour",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (_isLoginMode)
                    Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        TextField(
                          key: const ValueKey('password_field'),
                          controller: _passwordController,
                          decoration: const InputDecoration(labelText: "Heslo"),
                          obscureText: true,
                        ),
                      ],
                    ),
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    key: _isLoginMode
                        ? const ValueKey('login_button')
                        : const ValueKey('submit_button'),
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5C4033),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.08,
                      ),
                    ),
                    child: Text(
                      _isLoginMode ? "Prihlásiť sa" : "Odoslať overovací email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  TextButton(
                    onPressed: _toggleMode,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _isLoginMode
                                ? "Nemáte vytvorené heslo? "
                                : "Späť na ",
                          ),
                          TextSpan(
                            text: _isLoginMode
                                ? "Vytvorenie hesla"
                                : "Prihlásenie",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF5C4033),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
