import 'package:alternance_flutter/model/Offers.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class OfferService {
  final ApiClient _apiClient = ApiClient();

  Future<Offers> fetchOffers() async {
    try {
      final response = await _apiClient.dio.get("/api/offers/");

      if (response.statusCode == 200) {
        return Offers.fromJson(response.data);
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers: $e');
    }
  }
}