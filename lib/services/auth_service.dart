import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intagram_clone/exception/api_error_exception.dart';
import 'package:intagram_clone/exception/http_exception.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8081/api/v1/auth";

  Future<String?> authenticate(String username , String password) async {
    final url = Uri.parse("$baseUrl/authenticate");
    try {
      final res = await http.post(
          url,
          body: jsonEncode({"username": username, "password": password}),
          headers: {'Content-Type': 'application/json'}
        );

      final resData = jsonDecode(res.body);

      if(res.statusCode != 200){
        throw HttpException("Username or Password Incorrect");
      }

      return resData['data']['token'];

    } catch (e) {
      throw HttpException(e.toString());
    }

  }

  Future<void> register(String username , String password , String phoneNumber, String email) async {
    final url = Uri.parse("$baseUrl/register");
    try {
      final res = await http.post(
          url,
          body: jsonEncode({
            "username": username, 
            "password": password,
            "phoneNumber": phoneNumber,
            "email": email
          }),
          headers: {'Content-Type': 'application/json'}
        );

      final resData = jsonDecode(res.body);

      if(res.statusCode != 201){
        throw ApiErrorException(
          resData['message'],
          resData['errors'] != null ? Map<String, String>.from(resData['errors']) : {},
        );
      }

    } catch (e) {
      if(e is ApiErrorException){
        rethrow;
      }else{
        throw ApiErrorException("Network error. Please try again.",{});
      }
    }
  }
  

}