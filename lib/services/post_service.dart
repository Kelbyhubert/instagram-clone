import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intagram_clone/models/comment.dart';
import 'package:intagram_clone/models/post.dart';

class PostService {
  final String baseUrl = "http://10.0.2.2:8081/api/v1/post";
  String? _token;

  PostService(this._token);

  Future<List<Post>> getPosts(int offset, int limit) async {
    final url = Uri.parse("$baseUrl?offset=$offset&limit=$limit");
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
      print(resData['data']);
      return (resData['data'] as List).map((post) => Post.fromJson(post)).toList();
    } catch (e) {
      throw Exception(e);
    }

  }

  Future<List<Comment>> getPostComment(int id) async {
    final url = Uri.parse("$baseUrl/$id/comments");
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
      return (resData['data'] as List).map((comment) => Comment.fromJson(comment)).toList();
    } catch (e) {
      throw Exception(e);
    }

  }

  Future<Post> createNewPost(int userId , String imgUrl , String caption) async {
    final url = Uri.parse(baseUrl);
    try {
      final res = await http.post(
          url,
          body: jsonEncode({
              "userId" : userId,
              "imageUrl" : imgUrl,
              "caption" : caption
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer $_token'
          }
        );
        
      final resData = jsonDecode(res.body);
      if(res.statusCode <= 200 || res.statusCode >= 300){
        throw Exception("${resData['message']}");
      }

      return Post.fromJson(resData['data']);
    } catch (e) {
      throw Exception(e);
    }

  }

  Future<Comment> commentPost(int id, String comment) async {
    final url = Uri.parse("$baseUrl/$id/comment");
    try {
      final res = await http.post(
          url,
          body: jsonEncode({
            "comment" : comment
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer $_token'
          }
        );
        
      final resData = jsonDecode(res.body);
      if(res.statusCode <= 200 || res.statusCode >= 300){
        throw Exception("${resData['message']}");
      }
      return Comment.fromJson(resData['data']);
    } catch (e) {
      throw Exception(e);
    }

  }


  Future<void> likePost(int id) async {
    final url = Uri.parse("$baseUrl/$id/like");
    try {
      final res = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization' : 'Bearer $_token'
          }
        );
        
      final resData = jsonDecode(res.body);
      if(res.statusCode != 201){
        throw Exception("${resData['message']}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> unLikePost(int id) async {
    final url = Uri.parse("$baseUrl/$id/like");
    try {
      final res = await http.delete(
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
    } catch (e) {
      throw Exception(e);
    }

  }

}