import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  bool _isLoggedIn = false;
  bool _isLoading = true;
  String _userEmail = '';

  AuthProvider(this._prefs) {
    _loadAuthState();
  }

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String get userEmail => _userEmail;

  static const String validEmail = 'test@mail.com';
  static const String validPassword = '123456';

  void _loadAuthState() async {
    await Future.delayed(const Duration(seconds: 2));
    _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    _userEmail = _prefs.getString('userEmail') ?? '';
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == validEmail && password == validPassword) {
      _isLoggedIn = true;
      _userEmail = email;
      await _prefs.setBool('isLoggedIn', true);
      await _prefs.setString('userEmail', email);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    _isLoggedIn = true;
    _userEmail = email;
    await _prefs.setBool('isLoggedIn', true);
    await _prefs.setString('userEmail', email);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userEmail = '';
    await _prefs.setBool('isLoggedIn', false);
    await _prefs.remove('userEmail');
    notifyListeners();
  }
}
