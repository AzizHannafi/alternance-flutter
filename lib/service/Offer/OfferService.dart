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

  Future<Offers> fetchRecentOffers() async {
    try {
      final response = await _apiClient.dio.get(
          "/api/offers/status/open?page=1&limit=4&search=&employmentType=&university=&status=open");

      if (response.statusCode == 200) {
        return Offers.fromJson(response.data);
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers: $e');
    }
  }

  Future<Offers> fetchCompanyOffers(int companyId) async {
    try {
      final response = await _apiClient.dio.get("/api/offers/company/${companyId}");

      if (response.statusCode == 200) {
        return Offers.fromJson(response.data);
      } else {
        throw Exception('Failed to load offers');
      }
    } catch (e) {
      throw Exception('Failed to load offers: $e');
    }
  }

  Future<Offers> fetchOffersByFilters({
    String search = '',
    String employmentType = '',
    String university = '',
    String status = 'open',
    int page = 1,
    int limit = 15,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        "/api/offers/status/$status",
        queryParameters: {
          'page': page,
          'limit': limit,
          'search': search,
          'employmentType': employmentType,
          'university': university,
          'status': status,
        },
      );

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
