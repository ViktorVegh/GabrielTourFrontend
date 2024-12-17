import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/dtos/person_dto.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/person_service.dart';
import 'package:intl/intl.dart';

class ManageDriveScreen extends StatefulWidget {
  final DriveDTO drive;
  final DriveService driveService;
  final PersonService personService;
  final String userRole; // Add userRole

  ManageDriveScreen({
    required this.drive,
    required this.driveService,
    required this.personService,
    required this.userRole, // Add this parameter
  });

  @override
  _ManageDriveScreenState createState() => _ManageDriveScreenState();
}

class _ManageDriveScreenState extends State<ManageDriveScreen> {
  late TextEditingController _departureController;
  late TextEditingController _arrivalController;
  late TextEditingController _reasonController;
  late TextEditingController _dateController;
  late TextEditingController _pickupTimeController;
  late TextEditingController _dropoffTimeController;

  int? _selectedDriverId;
  List<PersonDTO> _drivers = [];
  bool _isLoading = false;
  String? _userEmail;

  @override
  void initState() {
    super.initState();

    _departureController =
        TextEditingController(text: widget.drive.departurePlace);
    _arrivalController = TextEditingController(text: widget.drive.arrivalPlace);
    _reasonController =
        TextEditingController(text: widget.drive.customReason ?? '');
    _dateController = TextEditingController(text: widget.drive.date);
    _pickupTimeController =
        TextEditingController(text: widget.drive.pickupTime ?? '');
    _dropoffTimeController =
        TextEditingController(text: widget.drive.dropoffTime ?? '');

    if (widget.drive.userIds.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchUserEmail(widget.drive.userIds.first);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user IDs available to fetch email')),
        );
      });
    }

    _fetchDrivers();
  }

  Future<void> _fetchDrivers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final drivers = await widget.personService.getAllDrivers();
      setState(() {
        _drivers = drivers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load drivers: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchUserEmail(int userId) async {
    try {
      final user = await widget.personService.getPersonByProfisId(userId);
      setState(() {
        _userEmail = user?.email ?? 'Email not found';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user email: $e')),
      );
    }
  }

  void _updateDrive() async {
    if (widget.userRole != 'office' && widget.userRole != 'drivermanager') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access denied: Insufficient permissions')),
      );
      return; // Stop the function if the role is not authorized
    }

    try {
      final updatedDrive = widget.drive.copyWith(
        departurePlace: _departureController.text,
        arrivalPlace: _arrivalController.text,
        customReason: _reasonController.text,
        date: _dateController.text,
        pickupTime: _pickupTimeController.text,
        dropoffTime: _dropoffTimeController.text,
        driverId: _selectedDriverId,
      );

      // Print the payload being sent
      print('--- Update Drive Payload ---');
      print('Drive ID: ${widget.drive.id}');
      print(
          'Payload: ${updatedDrive.toJson()}'); // Assuming a toJson() method exists

      await widget.driveService.updateDrive(widget.drive.id, updatedDrive);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Drive updated successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Update Error: $e'); // Log the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update drive: $e')),
      );
    }
  }

  void _deleteDrive() async {
    if (widget.userRole != 'office' && widget.userRole != 'drivermanager') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access denied: Insufficient permissions')),
      );
      return; // Stop the function if the role is not authorized
    }

    try {
      print('--- Delete Drive Request ---');
      print('Drive ID: ${widget.drive.id}');

      await widget.driveService.deleteDrive(widget.drive.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Drive deleted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Delete Error: $e'); // Log the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete drive: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White AppBar background
        elevation: 1,
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Image.asset(
            'assets/icons/gabrieltour-logo-2023.png', // Logo asset
            height: screenHeight * 0.04, // Logo height relative to screen
          ),
        ),
        centerTitle: true, // Center the logo
      ),
      backgroundColor:
          const Color.fromARGB(255, 248, 248, 248), // Light gray background
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: screenHeight * 0.015), // Spacing below AppBar
                  // Title Section with brown bar
                  Container(
                    width: double.infinity,
                    color: const Color.fromARGB(
                        201, 146, 96, 52), // Brown background
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    child: Text(
                      'Pridať jazdu do kalendára', // Screen Title
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.015,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Form Content
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.03,
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05,
                        bottom: screenHeight * 0.03,
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upravte Detaily Jazdy", // Title
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Divider(height: 20, thickness: 1),
                          if (_userEmail != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Klient: ',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: _userEmail,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          _buildDateTimePicker('Datum jazdy', _dateController,
                              _pickDate, screenWidth, screenHeight),
                          _buildDateTimePicker(
                              'Pick-Up Time',
                              _pickupTimeController,
                              _pickPickupTime,
                              screenWidth,
                              screenHeight),
                          _buildDateTimePicker(
                              'Drop-Off Time',
                              _dropoffTimeController,
                              _pickDropoffTime,
                              screenWidth,
                              screenHeight),
                          _buildTextField('Departure Place',
                              _departureController, screenWidth, screenHeight),
                          _buildTextField('Arrival Place', _arrivalController,
                              screenWidth, screenHeight),
                          _buildTextField('Reason', _reasonController,
                              screenWidth, screenHeight),
                          _buildDriverDropdown(screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.02),
                          _buildActions(
                              screenWidth), // Buttons for Submit/Delete
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: screenWidth * 0.8,
        height: screenHeight * 0.05,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200], // Light gray background
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.brown, width: 2.0), // Brown border
            ),
          ),
          style: TextStyle(fontSize: screenWidth * 0.035),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(String label, TextEditingController controller,
      Future<void> Function() onTap, double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: screenWidth * 0.8,
        height: screenHeight * 0.05,
        child: TextField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200], // Light gray background
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.brown, width: 2.0), // Brown border
            ),
          ),
          style: TextStyle(fontSize: screenWidth * 0.035),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(date);
      });
    }
  }

  Future<void> _pickPickupTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialEntryMode: TimePickerEntryMode.input, // Directly show input mode
    );
    if (time != null) {
      setState(() {
        _pickupTimeController.text = time.format(context);
      });
    }
  }

  Future<void> _pickDropoffTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialEntryMode: TimePickerEntryMode.input, // Directly show input mode
    );
    if (time != null) {
      setState(() {
        _dropoffTimeController.text = time.format(context);
      });
    }
  }

  Widget _buildDriverDropdown(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: screenWidth * 0.8,
        height: screenHeight * 0.05,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Assign Driver',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200], // Light gray background
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.brown, width: 2.0), // Brown border
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: true,
              value: _selectedDriverId,
              items: _drivers.map((driver) {
                return DropdownMenuItem<int>(
                  value: driver.id,
                  child: Text(
                    driver.email,
                    style: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDriverId = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActions(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.001), // Small relative gap
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Delete Button
          SizedBox(
            width: screenWidth * 0.35,
            child: ElevatedButton(
              onPressed: () => _showDeleteConfirmationDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800], // Darker red color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              ),
              child: Text(
                'Vymazať jazdu',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.white, // White text
                ),
              ),
            ),
          ),
          // Update Button
          SizedBox(
            width: screenWidth * 0.35,
            child: ElevatedButton(
              onPressed: _updateDrive,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown, // Update button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              ),
              child: Text(
                'Pridať jazdu',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkUserRole() {
    print('User Role: ${widget.userRole}');
    if (widget.userRole == 'office' || widget.userRole == 'drivermanager') {
      // Perform operations for authorized roles
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Access denied: Insufficient permissions')),
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Naozaj chcete vymazať jazdu?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Zrušiť'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deleteDrive(); // Proceed with delete
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800], // Darker red color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Vymazať',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
