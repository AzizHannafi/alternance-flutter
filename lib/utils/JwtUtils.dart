import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtUtils {
  // Static method to decode the JWT and print the payload
  static Future<void> decodeToken(String token) async {
    // Check if the token is valid (not expired)
    if (JwtDecoder.isExpired(token)) {
      print("The JWT token is expired");
      return;
    }

    // Decode the JWT
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Store each key-value pair in SharedPreferences
    decodedToken.forEach((key, value) async {
      if (value is String) {
        await prefs.setString(key, value); // Store string values
      } else if (value is int) {
        await prefs.setInt(key, value); // Store integer values
      } else if (value is bool) {
        await prefs.setBool(key, value); // Store boolean values
      } else if (value is double) {
        await prefs.setDouble(key, value); // Store double values
      } else if (value is List<String>) {
        await prefs.setStringList(key, value); // Store list of strings
      } else {
        print('Unsupported type for key: $key');
      }
    });

    // Print the payload
    print("Decoded Payload stored in SharedPreferences: ");
    decodedToken.forEach((key, value) {
      print('$key: $value');
    });
  }
}
