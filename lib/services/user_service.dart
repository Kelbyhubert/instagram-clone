import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intagram_clone/models/User.dart';
import 'package:intagram_clone/models/post.dart';

class UserService {
  
  String? _token;

  UserService(this._token);

  final String baseUrl = "http://10.0.2.2:8081/api/v1/user";

  Future<User?> getUserProfile() async {
    final url = Uri.parse("$baseUrl/me");
    try {
      final res = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer $_token'
          }
        );
        
      final resData = jsonDecode(res.body);
      if(res.statusCode != 200){
        throw Exception("${resData['message']}");
      }
      return User.fromJson(resData['data']);
    } catch (e) {
      throw Exception(e);
    }

  }

    Future<List<Post>> getUserPosts(int userId) async {
      final url = Uri.parse("$baseUrl/$userId/posts");
      try {
        final res = await http.get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization' : 'Bearer $_token'
            }
          );
          
        final resData = jsonDecode(res.body);
        if(res.statusCode != 200){
          throw Exception("${resData['message']}");
        }
        return (resData['data'] as List).map((post) => Post.fromJson(post)).toList();
      } catch (e) {
        throw Exception(e);
      }

  }


}