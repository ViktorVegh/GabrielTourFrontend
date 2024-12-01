import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transportation Icon and Date
            Row(
              children: [
                Icon(
                  _getIconForType(),
                  size: 40,
                  color: Colors.blue,
                ),
                const SizedBox(width: 16),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 0),
            // Departure Info aligned with date
            Padding(
              padding: const EdgeInsets.only(
                  left: 56.0), // Offset to align with the date
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    departureTime,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    departurePlace,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Arrow pointing down, aligned with arrival info
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 220.0), // Align arrow with text
                child: Icon(
                  Icons.arrow_downward,
                  size: 24,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Arrival Info aligned with date
            Padding(
              padding: const EdgeInsets.only(
                  left: 56.0), // Offset to align with the date
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    arrivalTime,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    arrivalPlace,
                    style: const TextStyle(fontSize: 16),
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
