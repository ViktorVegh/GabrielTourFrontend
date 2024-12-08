import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/user/tee_times.dart';
import 'package:gabriel_tour_app/screens/user/transportation_screen.dart';
import 'package:gabriel_tour_app/screens/user/accommodation_screen.dart';
import 'package:gabriel_tour_app/screens/user/additional_services_screen.dart';
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';
import 'package:gabriel_tour_app/dtos/accommodation_dto.dart';
import 'package:gabriel_tour_app/dtos/transportation_reservation_dto.dart';
import 'package:gabriel_tour_app/dtos/price_dto.dart';

class ServicesCard extends StatelessWidget {
  final String orderNumber;
  final List<AccommodationReservationDTO> accommodations;
  final List<PriceDTO> services;
  final List<TeeTimeDTO> teeTimes;
  final List<TransportationReservationDTO> transportations;

  const ServicesCard({
    Key? key,
    required this.orderNumber,
    required this.accommodations,
    required this.services,
    required this.teeTimes,
    required this.transportations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(screenWidth * 0.04),
      color: Colors.transparent,
      child: Column(
        children: [
          // Order number
          Text(
            "Číslo zájazdu $orderNumber",
            style: TextStyle(
              fontSize: screenHeight * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),

          // Icons with labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildServiceIcon(
                context,
                Icons.directions_bus,
                "Doprava",
                transportations.isNotEmpty
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransportationScreen(
                              transportations: transportations,
                            ),
                          ),
                        )
                    : null,
                screenHeight,
                screenWidth,
              ),
              _buildServiceIcon(
                context,
                Icons.golf_course,
                "Tee Times",
                teeTimes.isNotEmpty
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeeTimesScreen(
                              teeTimes: teeTimes,
                            ),
                          ),
                        )
                    : null,
                screenHeight,
                screenWidth,
              ),
              _buildServiceIcon(
                context,
                Icons.hotel,
                "Ubytovanie",
                accommodations.isNotEmpty
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccommodationScreen(
                              accommodation: accommodations[0],
                            ),
                          ),
                        )
                    : null,
                screenHeight,
                screenWidth,
              ),
              _buildServiceIcon(
                context,
                Icons.miscellaneous_services,
                "Služby",
                services.isNotEmpty
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AdditionalServicesScreen(services: services),
                          ),
                        )
                    : null,
                screenHeight,
                screenWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onTap,
    double screenHeight,
    double screenWidth,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: screenHeight * 0.01,
                  offset: Offset(0, screenHeight * 0.005),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: screenHeight * 0.04 > 40 ? 40 : screenHeight * 0.04,
              color: onTap != null ? Colors.blue : Colors.grey,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: screenHeight * 0.018,
              fontWeight: FontWeight.w500,
              color: onTap != null ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
