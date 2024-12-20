import 'package:flutter/material.dart';

class TransportationSlider extends StatelessWidget {
  final List<Map<String, dynamic>> transportations;

  const TransportationSlider({super.key, required this.transportations});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.25,
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
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Card(
                    color: Colors.white.withOpacity(0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.05,
                      ),
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
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    transport['departurePlace'],
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.025,
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.04),
                                      child: CustomPaint(
                                        painter: ArrowPainter(),
                                        size: Size(double.infinity,
                                            screenHeight * 0.02),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      '${duration.inHours}h ${duration.inMinutes.remainder(60)}m',
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.02,
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
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.005),
                                    child: Text(
                                      transport['arrivalPlace'],
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.025,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'DATUM: ${transport['date']}',
                              style: TextStyle(
                                fontSize: screenHeight * 0.022,
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
                padding: EdgeInsets.all(screenWidth * 0.01),
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
    arrowPath.lineTo(size.width - 0, size.height / 2 + verticalOffset);
    arrowPath.relativeLineTo(-10, -10);
    arrowPath.moveTo(size.width - 0, size.height / 2 + verticalOffset);
    arrowPath.relativeLineTo(-10, 10);

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
