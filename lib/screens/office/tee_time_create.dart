import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/golf_course_dto.dart';
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
  final JwtService _jwtService = JwtService();

  late final PersonService _personService;
  late final TeeTimeService _teeTimeService;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _golfCourseSearchController = TextEditingController();
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
  bool needTransport = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _personService = PersonService(_jwtService);
    _teeTimeService = TeeTimeService(_jwtService);
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
          SnackBar(content: Text("User added: ${user.email}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found")),
        );
      }
    }
  }

  Future<void> _searchGolfCourseByName() async {
    final name = _golfCourseSearchController.text;

    try {
      final GolfCourseDTO? golfCourse =
          await _teeTimeService.getGolfCourseByName(name);

      if (mounted) {
        if (golfCourse != null) {
          setState(() {
            _golfCourseIdController.text = golfCourse.id.toString();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Golf course found: ${golfCourse.name}")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No golf course found with name: $name")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching golf course")),
      );
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
        transport: needTransport,
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
    _golfCourseSearchController.dispose();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create a Tee Time",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF764706),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'User Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _searchUserByEmail,
                    child: Text("Search User by Email"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _golfCourseSearchController,
                    decoration: InputDecoration(
                      labelText: 'Search Golf Course by Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _searchGolfCourseByName,
                    child: Text("Search Golf Course"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _golfCourseIdController,
                    decoration: InputDecoration(
                      labelText: 'Golf Course ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _groupSizeController,
                    decoration: InputDecoration(
                      labelText: 'Group Size',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date (yyyy-MM-dd)',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Time (HH:mm)',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: _pickTime,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _adultsController,
                          decoration: InputDecoration(
                            labelText: 'Number of Adults',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _juniorsController,
                          decoration: InputDecoration(
                            labelText: 'Number of Juniors',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _holesController,
                    decoration: InputDecoration(
                      labelText: 'Holes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  SwitchListTile(
                    title: Text("Green"),
                    value: isGreen,
                    onChanged: (bool value) {
                      setState(() {
                        isGreen = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  SwitchListTile(
                    title: Text("Need Transport"),
                    value: needTransport,
                    onChanged: (bool value) {
                      setState(() {
                        needTransport = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _createTeeTime,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Create Tee Time",
                        style: TextStyle(fontSize: 18),
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
