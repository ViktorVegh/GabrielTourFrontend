import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting

class TransportationCard extends StatelessWidget {
  final String type; // flight, car, or bus
  final String date;
  final String departureTime;
  final String departurePlace;
  final String arrivalTime;
  final String arrivalPlace;

  const TransportationCard({
    Key? key,
    required this.type,
    required this.date,
    required this.departureTime,
    required this.departurePlace,
    required this.arrivalTime,
    required this.arrivalPlace,
  }) : super(key: key);

  IconData _getIconForType() {
    switch (type.toLowerCase()) {
      case 'flight':
        return Icons.flight;
      case 'car':
        return Icons.directions_car;
      case 'bus':
        return Icons.directions_bus;
      default:
        return Icons.help_outline;
    }
  }

  String _formatTime(String time) {
    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(time);
      return DateFormat("HH:mm").format(parsedTime);
    } catch (e) {
      return time; // Return the original string if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Date Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      _getIconForType(),
                      size: screenWidth * 0.06,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getDisplayNameForType(type),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 94, 94, 94),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Departure and Arrival Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Departure Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatTime(departureTime), // Format departure time
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      departurePlace,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
                // Arrow
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.arrow_forward,
                    size: screenWidth * 0.05,
                    color: Colors.grey,
                  ),
                ),
                // Arrival Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatTime(arrivalTime), // Format arrival time
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      arrivalPlace,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayNameForType(String type) {
    switch (type.toLowerCase()) {
      case 'flight':
        return 'Let'; // Replace "flight" with "Let"
      case 'car':
        return 'Auto'; // Example for car
      case 'bus':
        return 'Autobus'; // Example for bus
      default:
        return 'Neznáme'; // Default case for unknown types
    }
  }
}
