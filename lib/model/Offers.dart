import 'package:alternance_flutter/model/Offer.dart';

class Offers {
  final List<Offer> offers;
  final int totalOffers;
  final int currentPage;
  final int totalPages;

  Offers({
    required this.offers,
    required this.totalOffers,
    required this.currentPage,
    required this.totalPages,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    var offersJson = json['offers'] as List<dynamic>;
    List<Offer> offersList = offersJson
        .map((e) => Offer.fromJson(e as Map<String, dynamic>))
        .toList();

    return Offers(
      offers: offersList,
      totalOffers: json['totalOffers'] as int,
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  // Manually implemented toJson method
  Map<String, dynamic> toJson() {
    return {
      'offers': offers.map((e) => e.toJson()).toList(),
      'totalOffers': totalOffers,
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }
}
