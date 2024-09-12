import 'package:alternance_flutter/model/Certificate.dart';
import 'package:alternance_flutter/service/ApiClient.dart';

class Certificateservice {
  final ApiClient _apiClient = ApiClient();

  Future<List<Certificate>> fetchCertificateById(int studentId) async {
    try {
      final response =
          await _apiClient.dio.get("/api/certificates/student/$studentId");

      if (response.statusCode == 200) {
        // Assuming the response data is a list of education objects
        final List<dynamic> data = response.data;

        // Manually map the response data to a list of Education objects
        return data.map((json) => Certificate.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load certificates');
      }
    } catch (e) {
      throw Exception('Failed to load certificates: $e');
    }
  }
}
