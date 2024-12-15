import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/person_service.dart';
import '../../services/tee_time_service.dart';
import '../../services/jwt_service.dart';
import '../../dtos/person_dto.dart';
import '../../dtos/tee_time_request_dto.dart';
import '../../dtos/tee_time_dto.dart';

class DeleteTeeTimeScreen extends StatefulWidget {
  const DeleteTeeTimeScreen({Key? key}) : super(key: key);

  @override
  _DeleteTeeTimeScreenState createState() => _DeleteTeeTimeScreenState();
}

class _DeleteTeeTimeScreenState extends State<DeleteTeeTimeScreen> {
  final JwtService _jwtService = JwtService();

  late final PersonService _personService;
  late final TeeTimeService _teeTimeService;

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
  List<TeeTimeDTO> _userTeeTimes = [];
  bool isGreen = false;
  bool needTransport = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedTeeTimeId;

  @override
  void initState() {
    super.initState();
    _personService = PersonService(_jwtService);
    _teeTimeService = TeeTimeService(_jwtService);
    _getLatestTeetimes();
  }

  Future<void> _getLatestTeetimes() async {
    try {
      final List<TeeTimeDTO>? latestTeeTimes = await _teeTimeService.getLatestTeetimes();
      if (mounted) {
        setState(() {
          _userTeeTimes = latestTeeTimes!;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching latest tee times: $e")),
        );
      }
    }
  }

  Future<void> _searchTeeTimeByEmail() async {
    final email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an email address.")),
      );
      return;
    }

    try {
      final PersonDTO? user = await _personService.searchPersonByEmail(email);

      if (mounted) {
        if (user != null) {
          final List<TeeTimeDTO>? teeTimes = await _teeTimeService.getTeeTimesForSpecificUser(user.id);
          if (teeTimes != null && teeTimes.isNotEmpty) {
            setState(() {
              _userTeeTimes = teeTimes;
              _clearFields(); // Clear fields before populating
              _populateFields(teeTimes.first);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Tee times fetched successfully for ${user.name}")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No tee times found for ${user.name}.")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User not found.")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching tee times: $e")),
        );
      }
    }
  }

  void _clearFields() {
    _golfCourseIdController.clear();
    _groupSizeController.clear();
    _dateController.clear();
    _timeController.clear();
    _adultsController.clear();
    _juniorsController.clear();
    _holesController.clear();
    _noteController.clear();
  }

  void _populateFields(TeeTimeDTO teeTime) {
    _golfCourseIdController.text = teeTime.golfCourseId.toString();
    _groupSizeController.text = teeTime.groupSize.toString();
    _dateController.text = DateFormat('yyyy-MM-dd').format(teeTime.teeTime);
    _timeController.text = DateFormat('HH:mm').format(teeTime.teeTime);
    _adultsController.text = teeTime.adults.toString();
    _juniorsController.text = teeTime.juniors.toString();
    _holesController.text = teeTime.holes.toString();
    _noteController.text = teeTime.note ?? "";
  }

  Future<void> _deleteTeeTime() async {
    if (_selectedTeeTimeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a tee time to delete")),
      );
      return;
    }

    try {
      await _teeTimeService.deleteTeeTime(_selectedTeeTimeId!);

      setState(() {
        _userTeeTimes.removeWhere((teeTime) => teeTime.id == _selectedTeeTimeId);
        _selectedTeeTimeId = null;
        _clearFields();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tee time deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete tee time: $e")),
      );
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
      appBar: AppBar(title: Text("Vymaz Tee Time")),
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
                    "Vymaz Tee Time",
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
                  
                   SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                     onPressed: _searchTeeTimeByEmail,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.brown, // Brown background color
                      foregroundColor: Colors.white, // White text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Vyhladaj Tee Time",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                  SizedBox(height: 20),
                  Text(
                    "Tee Times",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  _userTeeTimes.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _userTeeTimes.length,
                          itemBuilder: (context, index) {
                            final teeTime = _userTeeTimes[index];
                            return Card(
                              elevation: 2,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text("Tee Time ID: ${teeTime.id}"),
                                subtitle: Text("Date: ${DateFormat('yyyy-MM-dd').format(teeTime.teeTime)}"),
                                selected: _selectedTeeTimeId == teeTime.id,
                                selectedTileColor: Colors.grey[300],
                                onTap: () {
                                  setState(() {
                                    _selectedTeeTimeId = teeTime.id;
                                    _populateFields(teeTime);
                                  });
                                },
                              ),
                            );
                          },
                        )
                      : Text("No tee times available."),
                       SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                     onPressed: _selectedTeeTimeId != null ? _deleteTeeTime : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.brown, // Brown background color
                      foregroundColor: Colors.white, // White text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Vymaz Tee Time",
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
