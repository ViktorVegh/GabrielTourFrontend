import 'package:flutter/material.dart';

class TransportationSlider extends StatelessWidget {
  final List<Map<String, dynamic>> transportations;

  const TransportationSlider({super.key, required this.transportations});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final defaultSliderHeight = screenHeight * 0.24; // Default slider height
    final maxFontSize = 26.0; // Maximum font size cap

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: defaultSliderHeight,
        maxHeight: screenHeight * 0.27, // Fix slider height for consistency
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: transportations.length,
              itemBuilder: (context, index) {
                final transport = transportations[index];
                final duration = calculateDuration(
                  transport['departureTime'] ?? TimeOfDay.now(),
                  transport['arrivalTime'] ?? TimeOfDay.now(),
                );

                // Dynamic font size scaling based on height
                final baseFontSize =
                    (defaultSliderHeight * 0.1).clamp(0.0, maxFontSize);

                return Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Card(
                    color: Colors.white.withOpacity(0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: defaultSliderHeight * 0.04,
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Departure Info
                              Column(
                                children: [
                                  if (transport['departureTime'] != null)
                                    Text(
                                      transport['departureTime']
                                          .format(context),
                                      style: TextStyle(
                                        fontSize: baseFontSize * 1.3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    transport['departurePlace'] ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: baseFontSize * 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // Arrow with duration
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03),
                                    child: CustomPaint(
                                      painter: ArrowPainter(),
                                      size: Size(
                                        screenWidth * 0.25,
                                        defaultSliderHeight * 0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: defaultSliderHeight * 0.03),
                                  Text(
                                    '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                                    style: TextStyle(
                                      fontSize: baseFontSize * 1.1,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                              // Arrival Info
                              Column(
                                children: [
                                  if (transport['arrivalTime'] != null)
                                    Text(
                                      transport['arrivalTime'].format(context),
                                      style: TextStyle(
                                        fontSize: baseFontSize * 1.3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    transport['arrivalPlace'] ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: baseFontSize * 1.2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: defaultSliderHeight * 0.03),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'DATUM: ${transport['date'] ?? 'Unknown'}',
                              style: TextStyle(
                                fontSize: baseFontSize,
                                color: const Color.fromARGB(255, 0, 0, 0),
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
              (index) => Padding(
                padding: EdgeInsets.all(screenWidth * 0.005),
                child: CircleAvatar(
                  radius: screenHeight * 0.005,
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
    const verticalOffset = 15;

    arrowPath.moveTo(0, size.height / 2 + verticalOffset);
    arrowPath.lineTo(size.width, size.height / 2 + verticalOffset);
    arrowPath.relativeLineTo(-10, -10);
    arrowPath.moveTo(size.width, size.height / 2 + verticalOffset);
    arrowPath.relativeLineTo(-10, 10);

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
