import 'package:flutter/material.dart';

import 'OfferFeedPage.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return const OfferFeedPage();
  }
}
