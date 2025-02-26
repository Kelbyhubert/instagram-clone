import 'package:flutter/material.dart';
import 'package:intagram_clone/models/comment.dart';
import 'package:intagram_clone/widgets/expandable_text.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: 
                  NetworkImage(
                    comment.user.profilePictureUrl == "" ? "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png" 
                    :
                    comment.user.profilePictureUrl
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.user.username,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    ExpandableText( content: comment.comment,maxLines: 2,),
                    Text(
                      "Reply",
                      style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600]
                      ),
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: Colors.grey[600]
                ),
              )
            ],
          ),
        );
  }
}