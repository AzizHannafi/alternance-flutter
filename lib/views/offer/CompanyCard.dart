import 'package:alternance_flutter/model/Company.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/ColorsUtils.dart';

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetails(offer: offer),
            ));*/
      },
      child: Card(
        elevation: 4, // Set the elevation to create a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        margin: const EdgeInsets.all(8.0),
        child: Container(
          width: 320,
          // Constrain the width of the OfferCard
          height: 150,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorsUtils.primaryBleu, // Your custom color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company.companyName!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsUtils.primaryWhite),
              ),
              const SizedBox(height: 8),
              Text(
                company.about!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorsUtils.primaryWhite),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite),
                      ),
                      Text(
                        '${company.location}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Industry:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite,
                          )),
                      Text('${company.industry}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsUtils.primaryWhite,
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
