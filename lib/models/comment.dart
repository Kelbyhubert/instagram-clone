import 'package:intagram_clone/models/User.dart';

class Comment {
  final int commentId;
  final User user;
  final String comment;

  Comment({required this.commentId, required this.user , required this.comment});

  factory Comment.fromJson(Map<String,dynamic> json){
    return Comment(
      commentId: json['commentId'] as int, 
      user: User.fromJson(json['user']), 
      comment: json['comment'] as String
    );
  }

  @override
  String toString() {
    return 'Comment{commentId: $commentId, user: ${user.toString()}, comment: $comment}';
  }
}