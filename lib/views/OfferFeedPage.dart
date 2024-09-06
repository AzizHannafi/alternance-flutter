import 'package:alternance_flutter/service/Offer/OfferService.dart';
import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:alternance_flutter/model/Offers.dart'; // Adjust the import path as necessary

class OfferFeedPage extends StatefulWidget {
  const OfferFeedPage({Key? key}) : super(key: key);

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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final offers = snapshot.data!.offers;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = offers[index];
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
                              item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(item.description,
                                style: Theme.of(context).textTheme.bodyMedium),
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
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(e, size: 16),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        )),
                        // Assuming you want to display a default image or handle missing images
                        Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: ColorsUtils.transparentGreen,
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://e7.pngegg.com/pngimages/592/963/png-clipart-commercial-building-computer-icons-management-building-building-company.png"), // Replace with actual image URL property or default
                                ))),
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
