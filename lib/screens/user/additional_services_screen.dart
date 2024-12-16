import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/dtos/price_dto.dart';

class AdditionalServicesScreen extends StatelessWidget {
  final List<PriceDTO> services;

  const AdditionalServicesScreen({Key? key, required this.services})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: Image.asset(
              'assets/icons/gabrieltour-logo-2023.png',
              height: screenHeight * 0.04,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.015), // Relative gap
            Container(
              width: double.infinity,
              color: const Color.fromARGB(201, 146, 96, 52), // Brown background
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
              child: Text(
                'Doplnkové služby',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.025, // Relative font size
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Main content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.022,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    '${service.price.toStringAsFixed(2)} ${service.currency}',
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'x${service.quantity}',
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
