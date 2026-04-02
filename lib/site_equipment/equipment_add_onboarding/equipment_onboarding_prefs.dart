import 'package:shared_preferences/shared_preferences.dart';

class EquipmentOnboardingPrefs {
  static const _completedKey = 'ff_equipment_add_onboarding_done';

  static Future<bool> isCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_completedKey) ?? false;
  }

  static Future<void> setCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
  }
}
