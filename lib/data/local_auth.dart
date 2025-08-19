import 'package:shared_preferences/shared_preferences.dart';

class LocalAuth {
  static const _kEmail = 'user_email';
  static const _kPassword = 'user_password';
  static const _kPhone = 'user_phone';
  static const _kName = 'user_name';
  static const _kLoggedIn = 'logged_in';

  static Future<void> saveCredentials(String email, String password, {String? phone, String? name}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kEmail, email.trim());
    await prefs.setString(_kPassword, password);
    if (phone != null && phone.isNotEmpty) {
      await prefs.setString(_kPhone, phone.trim());
    }
    if (name != null && name.isNotEmpty) {
      await prefs.setString(_kName, name.trim());
    }
  }

  static Future<String?> getStoredPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kPhone);
  }

  static Future<String?> getStoredName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kName);
  }

  static Future<bool> resetPasswordWithPhone(String phone, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPhone = prefs.getString(_kPhone);
    if (storedPhone == null || storedPhone.trim() != phone.trim()) {
      return false; // Phone number doesn't match
    }
    await prefs.setString(_kPassword, newPassword);
    return true;
  }

  static Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final e = prefs.getString(_kEmail);
    final p = prefs.getString(_kPassword);
    if (e == null || p == null) return false; // ยังไม่เคยสมัคร/ตั้งรหัส
    final ok = email.trim() == e.trim() && password == p;
    if (ok) await prefs.setBool(_kLoggedIn, true);
    return ok;
  }

  static Future<void> setLoggedIn(bool v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, v);
  }

  static Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, false);
  }
}
