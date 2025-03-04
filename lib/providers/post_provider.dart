import 'package:flutter/material.dart';
import 'package:intagram_clone/models/post.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:intagram_clone/services/post_service.dart';
import 'package:intagram_clone/services/user_service.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];
  List<Post> _userPosts = [];
  late PostService _postService;
  late UserService _userService;

  final AuthProvider authProvider;

  List<Post> get posts => _posts;

  List<Post> get userPosts => _userPosts;

  PostProvider({required this.authProvider}){}

  Future<void> fetchPosts({int offset = 0, int limit = 10}) async {
    if(authProvider.token == null) return;

    try{
     
      List<Post> tempPost;

      print(authProvider.user!.roleId);
      if(authProvider.user!.roleId == 2){
         _postService = PostService(authProvider.token);
        tempPost = await _postService.getPosts(offset, limit);
      }else{
        _userService = UserService(authProvider.token);
        tempPost = await _userService.getUserPosts(authProvider.user!.userId);
      }
      _posts.addAll(tempPost);
      notifyListeners();
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> fetchUserPost() async {
    if(authProvider.token == null) return;

    try{
      _userService = UserService(authProvider.token);
      List<Post> userPost = await _userService.getUserPosts(authProvider.user!.userId);
      _userPosts.addAll(userPost);
      notifyListeners();
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> reFetchPosts({int limit = 10}) async {
    if(authProvider.token == null) return;

    try{
      _postService = PostService(authProvider.token);
      if(authProvider.user!.roleId == 2){
        _posts = await _postService.getPosts(0, 10);
      }else{
        _posts = await _userService.getUserPosts(authProvider.user!.userId);
      }
      notifyListeners();
    }catch(e){
      print(e.toString());
    }

  }  

  Future<void> createNewPost(String imageUrl , String caption) async {
    if(authProvider.token == null) return;

    try{
      _postService = PostService(authProvider.token);
      final post = await _postService.createNewPost(authProvider.user!.userId, imageUrl, caption);
      _userPosts.add(post);
      reFetchPosts();
      notifyListeners();
    }catch(e){
      print(e.toString());
    }

  }

  Future<void> likeOrUnlikePost(int postId) async {
    if(authProvider.token == null) return;
    try{
      _postService = PostService(authProvider.token);
      final post = _posts.firstWhere((post) => post.postId == postId);
      if(!post.isLiked){
        await _postService.likePost(postId);
        post.isLiked = true;
        post.totalLike++;
      }else{
        await _postService.unLikePost(postId);
        post.isLiked = false;
        post.totalLike--;
      }

      notifyListeners();
    }catch(e){
      print(e.toString());
    }
  }

  
  Future<void> commentAdded(int postId) async {
    try{
      final post = _posts.firstWhere((post) => post.postId == postId);
      post.totalComment++;
      notifyListeners();
    }catch(e){
      print(e.toString());
    }
    
  }

  void clear(){
    _posts = [];
    _userPosts = [];
  }
  
}