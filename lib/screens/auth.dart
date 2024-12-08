// import 'package:flutter/material.dart';
// import 'package:gabriel_tour_app/services/auth_service.dart';
// import 'package:gabriel_tour_app/dtos/login_request.dart';
// import 'package:gabriel_tour_app/dtos/register_request.dart';
// import 'package:gabriel_tour_app/services/jwt_service.dart';
// import 'package:gabriel_tour_app/screens/office/tee_time_create.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   AuthScreenState createState() => AuthScreenState();
// }

// class AuthScreenState extends State<AuthScreen> {
//   bool _isLoginMode = true;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _profilePictureController =
//       TextEditingController();
//   String _role = "user"; // Default role is "user"
//   final AuthService _authService = AuthService();
//   final JwtService _jwtService = JwtService();

//   void _toggleMode() {
//     setState(() {
//       _isLoginMode = !_isLoginMode;
//     });
//   }

//   void _submit() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       _showError("Email a heslo nesmú byť prázdne");
//       return;
//     }

//     try {
//       String token;
//       if (_isLoginMode) {
//         // Login mode
//         token = await _authService.login(LoginRequest(
//           email: email,
//           password: password,
//         ));
//       } else {
//         // Registration mode
//         String name = _nameController.text.trim();
//         String profilePicture = _profilePictureController.text.trim();

//         token = await _authService.register(RegisterRequest(
//           email: email,
//           password: password,
//           name: name,
//           profilePicture: profilePicture,
//           role: _role,
//         ));
//       }

//       // Save the token locally
//       await _jwtService.saveToken(token);

//       // Extract the role from the token
//       String role = _jwtService.getRoleFromToken(token);

//       // Navigate to the appropriate screen based on role
//       _navigateToRoleBasedScreen(role);
//     } catch (error) {
//       _showError(error.toString());
//     }
//   }

//   void _navigateToRoleBasedScreen(String role) {
//     if (role == 'user') {
//       Navigator.pushReplacementNamed(context, '/userTrips');
//     } else if (role == 'tourguide') {
//       Navigator.pushReplacementNamed(context, '/tourGuideTrips');
//     } else if (role == 'driver') {
//       Navigator.pushReplacementNamed(context, '/driverCalendar');
//     } else if (role == 'office') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//               const CreateTeeTimeScreen(), // No need for allPersons parameter
//         ),
//       );
//     } else {
//       _showError("Rola užívateľa nebola rozpoznaná");
//     }
//   }

//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Chyba"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSuccess(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Úspech"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _navigateToHome() {
//     Navigator.pushReplacementNamed(context, '/home');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 60), // Add some spacing at the top
//             Image.asset(
//               'assets/icons/gabrieltour-logo-2023.png',
//               height: 100,
//             ),
//             const SizedBox(height: 60),
//             Text(
//               _isLoginMode ? 'Prihlásenie' : 'Registrácia',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF5C4033), // Match the logo color
//               ),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: "Email"),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: "Heslo"),
//               obscureText: true,
//             ),
//             const SizedBox(height: 10),
//             if (!_isLoginMode) ...[
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Meno"),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: _profilePictureController,
//                 decoration:
//                     const InputDecoration(labelText: "URL Profilového Obrázku"),
//               ),
//               const SizedBox(height: 10),
//               DropdownButton<String>(
//                 value: _role,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _role = newValue!;
//                   });
//                 },
//                 items: <String>[
//                   'user',
//                   'driver',
//                   'tourguide',
//                   'office'
//                 ] // Added 'office' here
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value == 'user'
//                           ? 'Používateľ'
//                           : value == 'driver'
//                               ? 'Šofér'
//                               : value == 'tourguide'
//                                   ? 'Sprievodca'
//                                   : 'Kancelária',
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submit,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     Color(0xFF5C4033), // Set the button color matching the logo
//               ),
//               child: Text(
//                 _isLoginMode ? "Prihlásiť sa" : "Zaregistrovať sa",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//               onPressed: _toggleMode,
//               child: RichText(
//                 text: TextSpan(
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: _isLoginMode ? "Nemáte účet? " : "Máte už účet? ",
//                       style: const TextStyle(fontWeight: FontWeight.normal),
//                     ),
//                     TextSpan(
//                       text: _isLoginMode ? "Zaregistrovať sa" : "Prihlásiť sa",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Color(
//                             0xFF5C4033), // Use the logo color to make the text stand out
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';
import 'package:gabriel_tour_app/dtos/login_request.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

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
        _showError("Email a heslo nesmú byť prázdne");
        return;
      }

      try {
        final token = await _authService.login(LoginRequest(
          email: email,
          password: password,
        ));
        final JwtService jwtService = JwtService();
        await jwtService.saveToken(token);
        Navigator.pushReplacementNamed(context, '/userTrips');
      } catch (error) {
        _showError("Prihlásenie zlyhalo: ${error.toString()}");
      }
    } else {
      if (email.isEmpty) {
        _showError("Zadajte email, ktorý používate v Gabriel Tour.");
        return;
      }

      try {
        final responseMessage = await _authService.resetPassword(email);
        if (responseMessage ==
            "Password reset link has been sent to your email.") {
          _showSuccess("Odkaz na obnovenie hesla bol odoslaný na váš email.");
        } else if (responseMessage == "Email not found.") {
          _showError("Email nebol nájdený.");
        } else if (responseMessage ==
            "Error: Multiple accounts found for the provided email.") {
          _showError("Email je priradený k viacerým účtom.");
        } else if (responseMessage == "Error calling ProfiTour API.") {
          _showError("Chyba pri volaní systému ProfiTour.");
        } else {
          _showError("Neočakávaná chyba: $responseMessage");
        }
      } catch (e) {
        _showError("Chyba: Nepodarilo sa odoslať email na vytvorenie hesla.");
      }
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensures resizing when the keyboard pops up
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1), // Top spacing
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
                          controller: _passwordController,
                          decoration: const InputDecoration(labelText: "Heslo"),
                          obscureText: true,
                        ),
                      ],
                    ),
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
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
