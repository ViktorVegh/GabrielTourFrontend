import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/user/tee_times.dart';
import 'package:gabriel_tour_app/screens/user/transportation_screen.dart';
import 'package:gabriel_tour_app/screens/user/accomodation_screen.dart';
import 'package:gabriel_tour_app/screens/user/additional_services_screen.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';

class ServicesCard extends StatelessWidget {
  final String orderNumber;
  final List<AccommodationReservationDTO> accommodations;
  final List<PriceDTO> services;

  const ServicesCard({
    Key? key,
    required this.orderNumber,
    required this.accommodations,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16.0),
      color: Colors.transparent,
      child: Column(
        children: [
          // Order number
          Text(
            "Číslo zájazdu $orderNumber",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Icons with labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildServiceIcon(
                context,
                Icons.directions_bus,
                "Doprava",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportationScreen(),
                  ),
                ),
              ),
              _buildServiceIcon(
                context,
                Icons.golf_course,
                "Tee Times",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeeTimesScreen(),
                  ),
                ),
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
                              accommodation: accommodations[
                                  0], // Pass the first accommodation
                            ),
                          ),
                        )
                    : null, // Disable tap if no accommodation available
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
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 36,
              color: onTap != null ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: onTap != null ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
