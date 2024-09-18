import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/model/Offer.dart';

import '../offer/OfferDetails.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetails(offer: offer),
            ));
      },
      child: Card(
        elevation: 4, // Set the elevation to create a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        margin: const EdgeInsets.all(8.0),
        child: Container(
          width: 280,
          // Constrain the width of the OfferCard
          height: 150,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorsUtils.primaryGreen, // Your custom color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.primaryWhite),
              ),
              const SizedBox(height: 8),
              Text(
                offer.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorsUtils.primaryWhite),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Salary: \$${offer.salary}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsUtils.primaryWhite),
                  ),
                  Text('Duration: ${offer.duration}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorsUtils.primaryWhite)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
