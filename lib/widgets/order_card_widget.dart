// import 'package:flutter/material.dart';
// import 'package:gabriel_tour_app/screens/user/order_details_screen.dart';

// class OrderCard extends StatelessWidget {
//   final String year;
//   final String resortName;
//   final String location;
//   final String orderNumber;
//   final String travelDates;

//   const OrderCard({
//     Key? key,
//     required this.year,
//     required this.resortName,
//     required this.location,
//     required this.orderNumber,
//     required this.travelDates,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize:
//             MainAxisSize.min, // Ensures the component height fits its content
//         children: [
//           // Top section: Resort image and year
//           Stack(
//             children: [
//               // Background image
//               Container(
//                 height: 250,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                   image: DecorationImage(
//                     image: AssetImage(
//                         'assets/icons/hotel.jpg'), // Replace with your image path
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               // Year
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     year,
//                     style: TextStyle(
//                       fontSize: 21,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Order number stripe
//           Container(
//             color: const Color(
//                 0xFFD68E26), // Application's orange-yellow-brown color
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Text(
//               "Číslo zájazdu $orderNumber",
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           // Resort details
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize:
//                   MainAxisSize.min, // Adjusts column height to fit its content
//               children: [
//                 // Resort name
//                 Text(
//                   resortName,
//                   style: TextStyle(
//                     fontSize: 34,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 // Location
//                 Text(
//                   location,
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(
//                     height: 24), // Adjust spacing between location and bottom
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Dates
//                     Text(
//                       travelDates,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: const Color.fromARGB(255, 0, 0, 0),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // Open button
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 OrderDetailsScreen(orderNumber: orderNumber),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         backgroundColor: Colors.blue,
//                       ),
//                       child: Text(
//                         "Otvoriť",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
          maxWidth: screenWidth * 0.9, // Ensure the card is not too wide
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(screenWidth * 0.04), // 4% of screen width
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min, // Adjust height to fit content
            children: [
              // Top section: Resort image and year
              Stack(
                children: [
                  // Background image
                  Container(
                    height: screenHeight * 0.25, // 25% of screen height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            screenWidth * 0.04), // 4% of screen width
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/icons/hotel.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Year
                  Positioned(
                    top: screenHeight * 0.02, // 2% of screen height
                    right: screenWidth * 0.04, // 4% of screen width
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03, // 3% of screen width
                        vertical: screenHeight * 0.01, // 1% of screen height
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.02), // 2%
                      ),
                      child: Text(
                        year,
                        style: TextStyle(
                          fontSize: screenHeight * 0.025, // 2.5%
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
                color: const Color(0xFFD68E26),
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01, // 1%
                  horizontal: screenWidth * 0.04, // 4%
                ),
                child: Text(
                  "Číslo zájazdu $orderNumber",
                  style: TextStyle(
                    fontSize: screenHeight * 0.02, // 2%
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Resort details
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04), // 4%
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Resort name
                    Text(
                      resortName,
                      style: TextStyle(
                        fontSize: screenHeight * 0.03, // 3%
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 1%
                    // Location
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: screenHeight * 0.02, // 2%
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // 2%
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dates
                        Text(
                          travelDates,
                          style: TextStyle(
                            fontSize: screenHeight * 0.02, // 2%
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
                              borderRadius: BorderRadius.circular(
                                  screenWidth * 0.02), // 2%
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            "Otvoriť",
                            style: TextStyle(
                              fontSize: screenHeight * 0.02, // 2%
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
