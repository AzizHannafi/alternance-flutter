import 'package:alternance_flutter/service/ApiClient.dart';
import 'package:alternance_flutter/utils/SharedPreferencesUtils.dart';

import '../../model/offers/AddOfferDto.dart';
import '../../model/offers/Offers.dart';

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

  Future<Map<String, dynamic>> addOffer(AddOfferDto offerDto) async {
    try {
      final response = await _apiClient.dio.post(
        "/api/offers",
        data: offerDto.toJson(),
      );

      if (response.statusCode == 201) {
        // Offer created successfully
        final responseData = response.data as Map<String, dynamic>;
        final message = responseData['message'] as String;
        final createdOffer = responseData['createdOffer'] as Map<String, dynamic>;

        return {
          'success': true,
          'message': message,
          'createdOffer': createdOffer,
        };
      } else {
        throw Exception('Failed to add offer: Unexpected status code ${response.statusCode}');
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to add offer: $e',
      };
    }
  }
  Future<Map<String, dynamic>> updateOffer(int offerId, AddOfferDto offerDto,String? appToken) async {

    final ApiClient _apiClientWithToken = ApiClient.withToken(appToken!);

    try {
      print('*************************************Updating offer with ID: $offerId');
      print('************************************Offer data: ${offerDto.toJson()}');

      final response = await _apiClientWithToken.dio.put(
        "/api/offers/$offerId",
        data: offerDto.toJson(),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Offer updated successfully
        final responseData = response.data as Map<String, dynamic>;
        final message = responseData['message'] as String;
        final updatedOffer = responseData['updatedOffer'] as Map<String, dynamic>;

        return {
          'success': true,
          'message': message,
          'updatedOffer': updatedOffer,
        };
      } else {
        throw Exception('Failed to update offer: Unexpected status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error in updateOffer: $e');
      return {
        'success': false,
        'message': 'Failed to update offer: $e',
      };
    }
  }

  Future<Map<String, dynamic>> deleteOffer(int offerId) async {

    try {
      final response = await _apiClient.dio.delete("/api/offers/$offerId");

      if (response.statusCode == 200) {
        // Offer deleted successfully
        final responseData = response.data as Map<String, dynamic>;
        final message = responseData['message'] as String;
        final deletedOffer = responseData['deletedOffer'] as Map<String, dynamic>;

        return {
          'success': true,
          'message': message,
          'deletedOffer': deletedOffer,
        };
      } else {
        throw Exception('Failed to delete offer: Unexpected status code ${response.statusCode}');
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to delete offer: $e',
      };
    }
  }


}
