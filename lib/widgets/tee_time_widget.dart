import 'package:flutter/material.dart';
import '../dtos/tee_time_dto.dart';

class TeeTimeWidget extends StatelessWidget {
  final TeeTimeDTO teeTime;
  final String golfCourseName;

  const TeeTimeWidget({
    Key? key,
    required this.teeTime,
    required this.golfCourseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen size for relative styling
    final screenWidth = MediaQuery.of(context).size.width;
    final baseFontSize = screenWidth * 0.04; // Relative base font size
    final smallFontSize = baseFontSize * 0.8; // Smaller text
    final largeFontSize = baseFontSize * 1.2; // Larger text

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Relative padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Golf course name and optional note
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    golfCourseName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: largeFontSize,
                    ),
                  ),
                  if (teeTime.note != null) // Optional note
                    Text(
                      teeTime.note!,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: smallFontSize,
                      ),
                    ),
                ],
              ),
            ),
            // Date and time
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${teeTime.teeTime.day}.${teeTime.teeTime.month}.${teeTime.teeTime.year}',
                    style: TextStyle(fontSize: smallFontSize),
                  ),
                  Text(
                    '${teeTime.teeTime.hour}:${teeTime.teeTime.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: baseFontSize,
                    ),
                  ),
                ],
              ),
            ),
            // Group size
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group,
                    color: Colors.blue,
                    size: baseFontSize,
                  ),
                  Text(
                    '${teeTime.groupSize}/4',
                    style: TextStyle(fontSize: smallFontSize),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
