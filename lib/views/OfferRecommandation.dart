import 'package:alternance_flutter/model/Offers.dart';
import 'package:alternance_flutter/service/Offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/custom/OfferCard.dart';
import 'package:flutter/material.dart';

class OfferRecommendation extends StatefulWidget {
  const OfferRecommendation({super.key});

  @override
  State<OfferRecommendation> createState() => _OfferRecommendationState();
}

class _OfferRecommendationState extends State<OfferRecommendation> {
  late Future<Offers> _offersFuture;

  @override
  void initState() {
    super.initState();
    final offerService = OfferService();
    _offersFuture = offerService.fetchRecentOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Adds padding around the container
      child: Container(
        // height: 400, // Ensure a defined height
        width: double.infinity, // Occupies the full width
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recommendation",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsUtils.primaryBleu,
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<Offers>(
              future: _offersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('No offers available'));
                } else if (!snapshot.hasData || snapshot.data!.offers.isEmpty) {
                  return Center(child: Text('No offers available'));
                } else {
                  // Extract the list of offers from the Offers object
                  final offers = snapshot.data!.offers;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: offers
                          .map((offer) => OfferCard(offer: offer))
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
