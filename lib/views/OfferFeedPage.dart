// Updated import for OfferDetails
import 'package:alternance_flutter/service/Offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:alternance_flutter/views/OfferDetails.dart';
import 'package:alternance_flutter/model/Offers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OfferFeedPage extends StatefulWidget {
  const OfferFeedPage({super.key});

  @override
  _OfferFeedPageState createState() => _OfferFeedPageState();
}

class _OfferFeedPageState extends State<OfferFeedPage> {
  late Future<Offers> _offersFuture;

  @override
  void initState() {
    super.initState();
    final offerService = OfferService();
    _offersFuture = offerService.fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Offers>(
        future: _offersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final offers = snapshot.data!.offers;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (BuildContext context, int index) {
                  final offer = offers[index];
                  return Container(
                    height: 136,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorsUtils.primaryBleu),
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(offer.description,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icons.bookmark_border_rounded,
                                  Icons.share,
                                  Icons.more_vert
                                ].map((e) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(e, size: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    OfferDetails(offer: offer),
                              ),
                            );
                          },
                          child: Container(
                            width: 70, // Keep the container width as 70
                            height: 70, // Keep the container height as 70
                            decoration: BoxDecoration(
                              color: ColorsUtils.transparentGreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SvgPicture.asset(
                                'assets/company.svg',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
