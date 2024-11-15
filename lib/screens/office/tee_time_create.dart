// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../services/person_service.dart';
// import '../../services/tee_time_service.dart';
// import '../../services/jwt_service.dart';
// import '../../dtos/person_dto.dart';
// import '../../dtos/tee_time_request_dto.dart';
// import '../../dtos/tee_time_dto.dart';
// import 'package:intl/intl.dart';

// class CreateTeeTimeScreen extends StatefulWidget {
//   const CreateTeeTimeScreen({Key? key}) : super(key: key);

//   @override
//   _CreateTeeTimeScreenState createState() => _CreateTeeTimeScreenState();
// }

// class _CreateTeeTimeScreenState extends State<CreateTeeTimeScreen> {
//   // Initialize JwtService and then use it to initialize PersonService
//   final JwtService _jwtService = JwtService();

//   // Initialize PersonService and TeeTimeService with JwtService and role
//   late final PersonService _personService;
//   late final TeeTimeService _teeTimeService;

//   // TextEditingControllers for input fields
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _golfCourseIdController = TextEditingController();
//   final TextEditingController _groupSizeController = TextEditingController();
//   final TextEditingController _teeTimeController = TextEditingController();
//   final TextEditingController _adultsController = TextEditingController();
//   final TextEditingController _juniorsController = TextEditingController();
//   final TextEditingController _holesController = TextEditingController();
//   final TextEditingController _noteController = TextEditingController();

//   List<int> userIds = [];
//   bool isGreen = false;

//   @override
//   void initState() {
//     super.initState();
//     // Pass the JwtService instance to PersonService
//     _personService = PersonService(_jwtService);
//   }

//   // Method to search user by email
//   Future<void> _searchUserByEmail() async {
//     final email = _emailController.text;
//     final PersonDTO? user = await _personService.searchPersonByEmail(email);

//     if (user != null) {
//       setState(() {
//         userIds.add(user.id);
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User added: ${user.name}")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User not found")),
//       );
//     }
//   }

//   // Method to create a tee time
//   Future<void> _createTeeTime() async {
//     try {
//       final String teeTimeInput = _teeTimeController.text;

//       // Regular expression to validate the format
//       final formatRegex = RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$');
//       if (!formatRegex.hasMatch(teeTimeInput)) {
//         throw FormatException("Invalid format. Use 'yyyy-MM-ddTHH:mm:ss'.");
//       }

//       // Parse the tee time string into a DateTime object
//       final DateTime parsedTeeTime = DateTime.parse(teeTimeInput);

//       final TeeTimeRequestDTO request = TeeTimeRequestDTO(
//         golfCourseId: int.parse(_golfCourseIdController.text),
//         teeTime: parsedTeeTime,
//         groupSize: int.parse(_groupSizeController.text),
//         userIds: userIds,
//         green: isGreen,
//         holes: int.parse(_holesController.text),
//         adults: int.parse(_adultsController.text),
//         juniors: int.parse(_juniorsController.text),
//         note: _noteController.text,
//       );

//       // Send the request using TeeTimeService
//       final TeeTimeDTO? createdTeeTime =
//           await _teeTimeService.createTeeTime(request);
//       if (createdTeeTime != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Tee time created successfully")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to create tee time")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 "Invalid tee time format. Please use 'yyyy-MM-ddTHH:mm:ss'.")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     // Dispose of all controllers
//     _emailController.dispose();
//     _golfCourseIdController.dispose();
//     _groupSizeController.dispose();
//     _teeTimeController.dispose();
//     _adultsController.dispose();
//     _juniorsController.dispose();
//     _holesController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Create Tee Time")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'User Email')),
//             ElevatedButton(
//                 onPressed: _searchUserByEmail,
//                 child: Text("Search User by Email")),
//             TextField(
//                 controller: _golfCourseIdController,
//                 decoration: InputDecoration(labelText: 'Golf Course ID')),
//             TextField(
//                 controller: _groupSizeController,
//                 decoration: InputDecoration(labelText: 'Group Size')),
//             TextField(
//                 controller: _teeTimeController,
//                 decoration:
//                     InputDecoration(labelText: 'Tee Time (yyyy-MM-ddTHH:mm)')),
//             TextField(
//                 controller: _adultsController,
//                 decoration: InputDecoration(labelText: 'Number of Adults')),
//             TextField(
//                 controller: _juniorsController,
//                 decoration: InputDecoration(labelText: 'Number of Juniors')),
//             TextField(
//                 controller: _holesController,
//                 decoration: InputDecoration(labelText: 'Holes')),
//             TextField(
//                 controller: _noteController,
//                 decoration: InputDecoration(labelText: 'Note')),
//             SwitchListTile(
//               title: Text("Green"),
//               value: isGreen,
//               onChanged: (bool value) {
//                 setState(() {
//                   isGreen = value;
//                 });
//               },
//             ),
//             ElevatedButton(
//                 onPressed: _createTeeTime, child: Text("Create Tee Time")),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/person_service.dart';
import '../../services/tee_time_service.dart';
import '../../services/jwt_service.dart';
import '../../dtos/person_dto.dart';
import '../../dtos/tee_time_request_dto.dart';
import '../../dtos/tee_time_dto.dart';

class CreateTeeTimeScreen extends StatefulWidget {
  const CreateTeeTimeScreen({Key? key}) : super(key: key);

  @override
  _CreateTeeTimeScreenState createState() => _CreateTeeTimeScreenState();
}

class _CreateTeeTimeScreenState extends State<CreateTeeTimeScreen> {
  // Initialize JwtService and then use it to initialize PersonService
  final JwtService _jwtService = JwtService();

  // Initialize PersonService and TeeTimeService with JwtService and role
  late final PersonService _personService;
  late final TeeTimeService _teeTimeService;

  // TextEditingControllers for input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _golfCourseIdController = TextEditingController();
  final TextEditingController _groupSizeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _adultsController = TextEditingController();
  final TextEditingController _juniorsController = TextEditingController();
  final TextEditingController _holesController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  List<int> userIds = [];
  bool isGreen = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    print("Starting initState...");
    _personService = PersonService(_jwtService);
    _teeTimeService = TeeTimeService(_jwtService);
    print("PersonService initialized: $_personService");
    print("TeeTimeService initialized: $_teeTimeService");
  }

  Future<void> _searchUserByEmail() async {
    final email = _emailController.text;
    final PersonDTO? user = await _personService.searchPersonByEmail(email);

    if (mounted) {
      if (user != null) {
        setState(() {
          userIds.add(user.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User added: ${user.name}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found")),
        );
      }
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _createTeeTime() async {
    if (_selectedDate == null || _selectedTime == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select both date and time")),
        );
      }
      return;
    }

    try {
      final DateTime teeTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final TeeTimeRequestDTO request = TeeTimeRequestDTO(
        golfCourseId: int.parse(_golfCourseIdController.text),
        teeTime: teeTime,
        groupSize: int.parse(_groupSizeController.text),
        userIds: userIds,
        green: isGreen,
        holes: int.parse(_holesController.text),
        adults: int.parse(_adultsController.text),
        juniors: int.parse(_juniorsController.text),
        note: _noteController.text,
      );

      final TeeTimeDTO? createdTeeTime =
          await _teeTimeService.createTeeTime(request);

      if (mounted) {
        if (createdTeeTime != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tee time created successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to create tee time")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Failed to create tee time. Check all fields.")),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _golfCourseIdController.dispose();
    _groupSizeController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _adultsController.dispose();
    _juniorsController.dispose();
    _holesController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Tee Time")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'User Email'),
            ),
            ElevatedButton(
              onPressed: _searchUserByEmail,
              child: Text("Search User by Email"),
            ),
            TextField(
              controller: _golfCourseIdController,
              decoration: InputDecoration(labelText: 'Golf Course ID'),
            ),
            TextField(
              controller: _groupSizeController,
              decoration: InputDecoration(labelText: 'Group Size'),
            ),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date (yyyy-MM-dd)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),
            ),
            TextField(
              controller: _timeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Time (HH:mm)',
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _pickTime,
                ),
              ),
            ),
            TextField(
              controller: _adultsController,
              decoration: InputDecoration(labelText: 'Number of Adults'),
            ),
            TextField(
              controller: _juniorsController,
              decoration: InputDecoration(labelText: 'Number of Juniors'),
            ),
            TextField(
              controller: _holesController,
              decoration: InputDecoration(labelText: 'Holes'),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            SwitchListTile(
              title: Text("Green"),
              value: isGreen,
              onChanged: (bool value) {
                setState(() {
                  isGreen = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _createTeeTime,
              child: Text("Create Tee Time"),
            ),
          ],
        ),
      ),
    );
  }
}
