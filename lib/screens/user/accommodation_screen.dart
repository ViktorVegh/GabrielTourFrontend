import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/accommodation_dto.dart';

class AccommodationScreen extends StatelessWidget {
  final AccommodationReservationDTO accommodation;

  const AccommodationScreen({super.key, required this.accommodation});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final hotel = accommodation.hotel;

    // Accommodation and hotel details from DTO
    final String hotelName = hotel.name;
    final int stars = hotel.stars;
    final String region = hotel.region ?? 'Neznámy región';
    final String country = hotel.country ?? 'Neznáma krajina';
    final String accommodationName = accommodation.accommodationName;
    final String startDate =
        '${DateTime.parse(accommodation.startDate).day}.${DateTime.parse(accommodation.startDate).month}.${DateTime.parse(accommodation.startDate).year}';
    final int nights = accommodation.numberOfNights;
    final int beds = accommodation.beds;
    final int extraBeds = accommodation.extraBeds;
    final String mealType = accommodation.mealType ?? 'Bez stravy';
    final String notes =
        accommodation.note.isNotEmpty ? accommodation.note : 'Žiadne poznámky';

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.015),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(201, 146, 96, 52),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
              child: Text(
                'Detaily Ubytovania',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.021,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const HotelImage(imageUrl: 'assets/icons/hotel.jpg'),
            HotelDetails(
              hotelName: hotelName,
              stars: stars,
              region: region,
              country: country,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detaily ubytovania',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  RichTextRow(
                    label: 'Názov',
                    value: accommodationName,
                  ),
                  RichTextRow(
                    label: 'Dátum začiatku',
                    value: startDate,
                  ),
                  RichTextRow(
                    label: 'Počet nocí',
                    value: '$nights',
                  ),
                  RichTextRow(
                    label: 'Počet postelí',
                    value: '$beds',
                  ),
                  RichTextRow(
                    label: 'Prístelky',
                    value: '$extraBeds',
                  ),
                  RichTextRow(
                    label: 'Strava',
                    value: mealType,
                  ),
                  RichTextRow(
                    label: 'Poznámky',
                    value: notes,
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

class HotelImage extends StatelessWidget {
  final String imageUrl;

  const HotelImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey,
          child: const Center(
            child: Icon(Icons.broken_image, size: 50),
          ),
        ),
      ),
    );
  }
}

class HotelDetails extends StatelessWidget {
  final String hotelName;
  final int stars;
  final String region;
  final String country;

  const HotelDetails({
    super.key,
    required this.hotelName,
    required this.stars,
    required this.region,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hotelName,
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Row(
            children: List.generate(
              stars > 0 ? stars : 1, // Display at least one star if stars is 0
              (index) => const Icon(Icons.star, color: Colors.amber, size: 24),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$region, $country',
            style: const TextStyle(
                fontSize: 18, color: Color.fromARGB(169, 77, 77, 77)),
          ),
        ],
      ),
    );
  }
}

class RichTextRow extends StatelessWidget {
  final String label;
  final String value;

  const RichTextRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
