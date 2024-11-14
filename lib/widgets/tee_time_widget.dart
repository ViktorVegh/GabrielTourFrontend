import 'package:flutter/material.dart';
import '../dtos/tee_time_dto.dart';

class TeeTimeWidget extends StatelessWidget {
  final TeeTimeDTO teeTime;
  final String golfCourseName; // Golf course name associated with golfCourseId

  const TeeTimeWidget({
    Key? key,
    required this.teeTime,
    required this.golfCourseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  golfCourseName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Larger font for course name
                  ),
                ),
                if (teeTime.note != null) // Optional note
                  Text(
                    teeTime.note!,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14, // Smaller font for the note
                    ),
                  ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${teeTime.teeTime.day}.${teeTime.teeTime.month}.${teeTime.teeTime.year}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${teeTime.teeTime.hour}:${teeTime.teeTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                Icon(Icons.group, color: Colors.orange),
                Text('${teeTime.groupSize}/4'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
