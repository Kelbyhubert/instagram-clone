import 'package:flutter/material.dart';
import 'package:intagram_clone/models/User.dart';
import 'package:intagram_clone/services/auth_service.dart';
import 'package:intagram_clone/services/user_service.dart';

class AuthProvider extends ChangeNotifier {

  User? _user;
  String? _token;
  String? errorMessage;

  User? get user { 
    return _user;
  }

  String? get token{
    return _token;
  }

  bool get isAuthenticated {
    return _user != null;
  }

  final AuthService _authService = AuthService();

  Future<void> login(String username, String password) async {
    try {
      _token = await _authService.authenticate(username, password);
      notifyListeners();
      await _fetchUserDetail();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> _fetchUserDetail() async {
    try {
      final UserService userService = UserService(_token);
      _user = await userService.getUserProfile();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();  
      notifyListeners();  
    }
  }

  Future<void> logout() async {
    _user = null;
    _token = null;

    notifyListeners(); 
  }
}