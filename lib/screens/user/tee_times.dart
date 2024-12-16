import 'package:flutter/material.dart';
import '../../dtos/tee_time_dto.dart';
import '../../widgets/tee_time_widget.dart';

class TeeTimesScreen extends StatelessWidget {
  final List<TeeTimeDTO> teeTimes;

  const TeeTimesScreen({Key? key, required this.teeTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Image.asset(
            'assets/icons/gabrieltour-logo-2023.png',
            height: screenHeight * 0.04,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.015), // Relative gap
          Container(
            width: double.infinity,
            color: const Color.fromARGB(201, 146, 96, 52), // Brown background
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            child: Text(
              'Tee Times',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.025, // Relative font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: teeTimes.isEmpty
                ? const Center(
                    child: Text(
                      'No Tee Times available for this user',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: teeTimes.length,
                    itemBuilder: (context, index) {
                      final TeeTimeDTO teeTime = teeTimes[index];
                      const String placeholderGolfCourseName =
                          'Sueno Golf Belek';

                      return TeeTimeWidget(
                        teeTime: teeTime,
                        golfCourseName: placeholderGolfCourseName,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
