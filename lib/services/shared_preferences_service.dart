import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String onboardingKey = 'onboarding_seen';

  Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
  }
} 