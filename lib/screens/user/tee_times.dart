import 'package:flutter/material.dart';
import '../../dtos/tee_time_dto.dart';
import '../../widgets/tee_time_widget.dart';

class TeeTimesScreen extends StatelessWidget {
  final List<TeeTimeDTO> teeTimes;

  const TeeTimesScreen({Key? key, required this.teeTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tee Times'),
        backgroundColor: Colors.orange,
      ),
      body: teeTimes.isEmpty
          ? const Center(child: Text('No Tee Times available for this user'))
          : ListView.builder(
              itemCount: teeTimes.length,
              itemBuilder: (context, index) {
                final TeeTimeDTO teeTime = teeTimes[index];
                const String placeholderGolfCourseName = 'Golf Course Name';

                return TeeTimeWidget(
                  teeTime: teeTime,
                  golfCourseName: placeholderGolfCourseName,
                );
              },
            ),
    );
  }
}
