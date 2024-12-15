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
  final TextEditingController _golfCourseCreateController = TextEditingController();

  List<int> userIds = [];
  bool isGreen = false;
  bool needTransport = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedHoles; 

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
  Future<void> _createGolfCourse() async {
  final name = _golfCourseCreateController.text;

  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please enter a golf course name")),
    );
    return;
  }

  try {
    final GolfCourseDTO? createdGolfCourse =
        await _teeTimeService.createGolfCourse(name);

    if (createdGolfCourse != null) {
      setState(() {
        _golfCourseIdController.text = createdGolfCourse.id.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Golf course created: ${createdGolfCourse.name}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create golf course")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error creating golf course")),
    );
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
    print(">>> _createTeeTime triggered <<<");
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
        userIds: [9388],
        green: isGreen,
        holes: 9,
        adults: int.parse(_adultsController.text),
        juniors: int.parse(_juniorsController.text),
        transport: needTransport,
        note: _noteController.text,
      );
        print("Creating Tee Time with:");
        print("Golf Course ID: ${_golfCourseIdController.text}");
        print("Group Size: ${_groupSizeController.text}");
        print("Adults: ${_adultsController.text}");
        print("Juniors: ${_juniorsController.text}");
        print("Holes: ${request.holes}");
        print("Green: $isGreen");
        print("Need Transport: $needTransport");
        print("Date: ${_selectedDate.toString()}");
        print("Time: ${_selectedTime.toString()}");
        print("Note: ${_noteController.text}");
        print("userid: ${request.userIds}");
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
                  "Select User",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'User Email',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                    onPressed: _searchUserByEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown, // Brown background color
                      foregroundColor: Colors.white, // White text color
                      minimumSize: Size(0, 50), // Match input field height
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                    ),
                    child: Text(
                      "Search User",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  ],
                ),
                Divider(height: 30, thickness: 1),
                Text(
                  "Setup Golf Course",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
       SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _golfCourseSearchController,
                decoration: InputDecoration(
                  labelText: 'Search Golf Course by Name',
                  filled: true,            // Enables background fill
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  labelStyle: TextStyle(fontSize: 14),
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(width: 10),
           ElevatedButton(
            onPressed: _searchGolfCourseByName,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown, // Brown background color
              foregroundColor: Colors.white, // White text color
              minimumSize: Size(0, 50), // Match input field height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
              ),
            ),
            child: Text(
              "Search ",
              style: TextStyle(fontSize: 14),
            ),
          ),
            SizedBox(width: 10), // Small gap between buttons
            Expanded(
              child: TextField(
                controller: _golfCourseCreateController,
                decoration: InputDecoration(
                  labelText: 'Create Golf Course',
                  filled: true,            // Enables background fill
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  labelStyle: TextStyle(fontSize: 14),
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(width: 10),
                     ElevatedButton(
            onPressed: _createGolfCourse,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown, // Brown background color
              foregroundColor: Colors.white, // White text color
              minimumSize: Size(0, 50), // Match input field height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
              ),
            ),
            child: Text(
              "Create ",
              style: TextStyle(fontSize: 14),
            ),
          ),
          ],
        ), 
                Divider(height: 30, thickness: 1),

                // Section 3: Fill in Tee Time Information
                Text(
                  "Fill in Tee Time Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _golfCourseIdController,
                        decoration: InputDecoration(
                          labelText: 'Golf Course ID',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _groupSizeController,
                        decoration: InputDecoration(
                          labelText: 'Group Size',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date (yyyy-MM-dd)',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: _pickDate,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _timeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Time (HH:mm)',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          suffixIcon: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: _pickTime,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _adultsController,
                        decoration: InputDecoration(
                          labelText: 'Number of Adults',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _juniorsController,
                        decoration: InputDecoration(
                          labelText: 'Number of Juniors',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        ),
                      ),
                    ),
                  ],
                ), SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedHoles,
                        decoration: InputDecoration(
                          labelText: 'Holes',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        ),
                        items: [9, 18]
                            .map((int value) => DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedHoles = value;
                          });
                        },
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        dropdownColor: Colors.white, // Set dropdown background color
                        menuMaxHeight: 120.0, // Set the maximum height of dropdown
                        alignment: Alignment.centerLeft, // Align dropdown content
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: 'Note',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        ),
                      ),
                    ),
                  ],
                ),
              
                          SizedBox(height: 10),
                  Row(
                    children: [
                      Switch(
                        value: isGreen,
                        onChanged: (bool value) {
                          setState(() {
                            isGreen = value;
                          });
                        },
                         activeColor: Colors.brown, // Active thumb color
                        activeTrackColor: Colors.brown[300],
                      ),
                      SizedBox(width: 10), // Small space between switch and text
                      Text(
                        "Green",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Switch(
                        value: needTransport,
                        onChanged: (bool value) {
                          setState(() {
                            needTransport = value;
                          });
                        },
                         activeColor: Colors.brown, // Active thumb color
                        activeTrackColor: Colors.brown[300],
                      ),
                      SizedBox(width: 10), // Small space between switch and text
                      Text(
                        "Need Transport",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _createTeeTime,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.brown, // Brown background color
                      foregroundColor: Colors.white, // White text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
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