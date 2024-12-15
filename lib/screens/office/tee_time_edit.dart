import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/person_service.dart';
import '../../services/tee_time_service.dart';
import '../../services/jwt_service.dart';
import '../../dtos/person_dto.dart';
import '../../dtos/tee_time_request_dto.dart';
import '../../dtos/tee_time_dto.dart';

class EditTeeTimeScreen extends StatefulWidget {
  const EditTeeTimeScreen({Key? key}) : super(key: key);

  @override
  _EditTeeTimeScreenState createState() => _EditTeeTimeScreenState();
}

class _EditTeeTimeScreenState extends State<EditTeeTimeScreen> {
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
  final TextEditingController _idController = TextEditingController();

  List<int> userIds = [];
  List<TeeTimeDTO> _userTeeTimes = [];
  bool isGreen = false;
  bool needTransport = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedTeeTimeId;
  int? _selectedHoles; 
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
              _clearFields();
              _selectedTeeTimeId = null; // Reset selection
              _selectedDate = null; // Reset date
              _selectedTime = null; // Reset time
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
    _idController.clear();
    isGreen = false;
    needTransport = false;
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
    _idController.text = teeTime.id.toString();
    isGreen = teeTime.green;
    needTransport = teeTime.transport;

    // Populate selected date and time from teeTime
    _selectedDate = teeTime.teeTime;
    _selectedTime = TimeOfDay.fromDateTime(teeTime.teeTime);
  }

  Future<void> _editTeeTime() async {
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
        id: int.parse(_idController.text),
      );

      final TeeTimeDTO? editedTeeTime =
          await _teeTimeService.editTeeTime(request);

      if (mounted) {
        if (editedTeeTime != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Tee time edited successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to edit tee time")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Failed to edit tee time. Check all fields.")),
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
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Uprav Tee Time")),
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
                    "Uprav Tee Time",
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
                      labelText: 'Klient Email',
                      border: OutlineInputBorder(),
                    ),
                  ),SizedBox(height: 20),
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
                                title: Text("ID Tee time: ${teeTime.id}"),
                                subtitle: Text("Dátum: ${DateFormat('yyyy-MM-dd').format(teeTime.teeTime)}"),
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
    _selectedTeeTimeId != null
    ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Divider(height: 30, thickness: 1),
           Text(
                  "Vyplň informácie o Tee Time",
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
                          labelText: 'ID golfového ihriska',
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
                          labelText: 'Počet ludí',
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
                          labelText: 'Dátum (yyyy-MM-dd)',
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
                          labelText: 'čas (HH:mm)',
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
                          labelText: 'Počet dospelých',
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
                          labelText: 'Počet detí',
                          filled: true,            // Enables background fill
                          fillColor: Colors.grey[200],
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
                      child: DropdownButtonFormField<int>(
                        value: _selectedHoles,
                        decoration: InputDecoration(
                          labelText: 'Jamky',
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
                          labelText: 'Poznámky',
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
                        "Vytvor dopravu",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ), SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _editTeeTime,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.brown, // Brown background color
                      foregroundColor: Colors.white, // White text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Edit Tee Time",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
        
        ],
      )
    : SizedBox(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
