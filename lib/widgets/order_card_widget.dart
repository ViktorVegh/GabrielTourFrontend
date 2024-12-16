import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/user/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final String year;
  final String resortName;
  final String location;
  final String orderNumber;
  final String travelDates;

  const OrderCard({
    Key? key,
    required this.year,
    required this.resortName,
    required this.location,
    required this.orderNumber,
    required this.travelDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.9,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top section: Resort image and year
              Stack(
                children: [
                  // Background image
                  Container(
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(screenWidth * 0.04),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/icons/hotel.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Year
                  Positioned(
                    top: screenHeight * 0.02,
                    right: screenWidth * 0.04,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Text(
                        year,
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Order number stripe
              Container(
                color: Color.fromARGB(201, 146, 96, 52),
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.04,
                ),
                child: Text(
                  "Číslo zájazdu $orderNumber",
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Resort details
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Resort name
                    Text(
                      resortName,
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Location
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dates
                        Text(
                          travelDates,
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Open button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                  orderNumber: orderNumber,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.02),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            "Otvoriť",
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
