import 'package:intagram_clone/models/User.dart';

class Post {
  final int postId;
  final User user;
  final String imageUrl;
  final String caption;
  int totalLike;
  int totalComment;
  bool isLiked;

  Post({
    required this.postId, 
    required this.user , 
    required this.imageUrl, 
    required this.caption,
    required this.totalLike,
    required this.totalComment,
    required this.isLiked
  }
  );

    factory Post.fromJson(Map<String,dynamic> json){
      return Post(
        postId: json['id'] as int, 
        user: User.fromJson(json['user']), 
        imageUrl: json['imageUrl'] as String,
        caption: json['caption'] as String,
        totalLike: json['totalLike'] as int,
        totalComment: json['totalComment'] as int,
        isLiked: json['isLiked'] as bool
      );
    }
}