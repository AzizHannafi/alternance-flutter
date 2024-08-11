import 'package:shared_preferences/shared_preferences.dart';

class OnboardingUtils {
  static const String _onboardingKey = 'onboarding_done';

  // Method to check if onboarding is done
  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    // return prefs.getBool(_onboardingKey) ?? false;
    return false;
  }

  // Method to set onboarding as done
  static Future<void> setOnboardingDone(bool done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, done);
  }
}
