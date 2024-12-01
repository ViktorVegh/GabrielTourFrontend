import 'package:flutter/material.dart';

class TransportationSlider extends StatelessWidget {
  final List<Map<String, dynamic>> transportations;

  const TransportationSlider({super.key, required this.transportations});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed or adjustable height, depending on the content
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: transportations.length,
              itemBuilder: (context, index) {
                final transport = transportations[index];
                final duration = calculateDuration(
                  transport['departureTime'],
                  transport['arrivalTime'],
                );

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white.withOpacity(0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Departure Info
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    transport['departureTime'].format(context),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    transport['departurePlace'],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // Arrow with duration
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: CustomPaint(
                                        painter: ArrowPainter(),
                                        size: const Size(double.infinity, 20),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Arrival Info
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    transport['arrivalTime'].format(context),
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Reduced spacing or removed SizedBox
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0), // Fine-tuned spacing
                                    child: Text(
                                      transport['arrivalPlace'],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'DATUM: ${transport['date']}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              transportations.length,
              (index) => const Padding(
                padding: EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 4.0,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Duration calculateDuration(TimeOfDay startTime, TimeOfDay endTime) {
    final now = DateTime.now();
    final startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    final endDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
    return endDateTime.difference(startDateTime);
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 135, 135, 135)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final arrowPath = Path();
    const verticalOffset = 15; // Adjust this value to move the arrow down

    // Adjust the vertical position by adding `verticalOffset`
    arrowPath.moveTo(
        0, size.height / 2 + verticalOffset); // Start from the left
    arrowPath.lineTo(size.width - 0,
        size.height / 2 + verticalOffset); // Line to near the end
    arrowPath.relativeLineTo(-10, -10); // Arrowhead top
    arrowPath.moveTo(
        size.width - 0, size.height / 2 + verticalOffset); // Return to the end
    arrowPath.relativeLineTo(-10, 10); // Arrowhead bottom

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
