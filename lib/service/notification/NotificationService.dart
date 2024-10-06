import '../../model/Notification.dart';
import '../ApiClient.dart';

class NotificationService {
  final ApiClient _apiClient = ApiClient();

  Future<List<NotificationModel>> fetchNotificationsByUserId(int userId) async {
    try {
      final response = await _apiClient.dio.get("/api/notifications/user/$userId");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }
}