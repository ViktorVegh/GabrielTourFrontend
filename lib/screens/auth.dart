import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';
import 'package:gabriel_tour_app/dtos/login_request.dart';
import 'package:gabriel_tour_app/dtos/register_request.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/screens/office/tee_time_create.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  String _role = "user"; // Default role is "user"
  final AuthService _authService = AuthService();
  final JwtService _jwtService = JwtService();

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  void _submit() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("Email a heslo nesmú byť prázdne");
      return;
    }

    try {
      String token;
      if (_isLoginMode) {
        // Login mode
        token = await _authService.login(LoginRequest(
          email: email,
          password: password,
        ));
      } else {
        // Registration mode
        String name = _nameController.text.trim();
        String profilePicture = _profilePictureController.text.trim();

        token = await _authService.register(RegisterRequest(
          email: email,
          password: password,
          name: name,
          profilePicture: profilePicture,
          role: _role,
        ));
      }

      // Save the token locally
      await _jwtService.saveToken(token);

      // Extract the role from the token
      String role = _jwtService.getRoleFromToken(token);

      // Navigate to the appropriate screen based on role
      _navigateToRoleBasedScreen(role);
    } catch (error) {
      _showError(error.toString());
    }
  }

  void _navigateToRoleBasedScreen(String role) {
    if (role == 'user') {
      Navigator.pushReplacementNamed(context, '/userTrips');
    } else if (role == 'tourguide') {
      Navigator.pushReplacementNamed(context, '/tourGuideTrips');
    } else if (role == 'driver') {
      Navigator.pushReplacementNamed(context, '/driverCalendar');
    } else if (role == 'office') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const CreateTeeTimeScreen(), // No need for allPersons parameter
        ),
      );
    } else {
      _showError("Rola užívateľa nebola rozpoznaná");
    }
  }

  void _showError(String message) {
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

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60), // Add some spacing at the top
            Image.asset(
              'assets/icons/gabrieltour-logo-2023.png',
              height: 100,
            ),
            const SizedBox(height: 60),
            Text(
              _isLoginMode ? 'Prihlásenie' : 'Registrácia',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C4033), // Match the logo color
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Heslo"),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            if (!_isLoginMode) ...[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Meno"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _profilePictureController,
                decoration:
                    const InputDecoration(labelText: "URL Profilového Obrázku"),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _role,
                onChanged: (String? newValue) {
                  setState(() {
                    _role = newValue!;
                  });
                },
                items: <String>[
                  'user',
                  'driver',
                  'tourguide',
                  'office'
                ] // Added 'office' here
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == 'user'
                          ? 'Používateľ'
                          : value == 'driver'
                              ? 'Šofér'
                              : value == 'tourguide'
                                  ? 'Sprievodca'
                                  : 'Kancelária',
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF5C4033), // Set the button color matching the logo
              ),
              child: Text(
                _isLoginMode ? "Prihlásiť sa" : "Zaregistrovať sa",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _toggleMode,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: _isLoginMode ? "Nemáte účet? " : "Máte už účet? ",
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: _isLoginMode ? "Zaregistrovať sa" : "Prihlásiť sa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(
                            0xFF5C4033), // Use the logo color to make the text stand out
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
