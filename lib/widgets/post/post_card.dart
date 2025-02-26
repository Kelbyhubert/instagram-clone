import 'package:flutter/material.dart';
import 'package:intagram_clone/models/post.dart';
import 'package:intagram_clone/widgets/expandable_text.dart';
import 'package:intagram_clone/widgets/post/post_action_bar.dart';


class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({
    super.key,
    required this.post
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: 500
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20,
                backgroundImage: 
                NetworkImage(
                  post.user.profilePictureUrl == "" ? "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png" 
                  :
                  post.user.profilePictureUrl
                ),
              ),
              title: Text(post.user.username),
              trailing: Icon(Icons.more_vert),
            ),
            AspectRatio(
              aspectRatio: 4/3,
              child: Image.network(
                post.imageUrl
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostActionBar(post: post),
                  ExpandableText(content: post.caption, maxLines: 2),
                ]

              ),
            )

            
          ],
        ),
      )
    );
  }
}









