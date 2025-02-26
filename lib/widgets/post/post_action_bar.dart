import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intagram_clone/models/post.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:intagram_clone/widgets/comment/comment_list_modal.dart';
import 'package:provider/provider.dart';

class PostActionBar extends StatelessWidget {
  final Post post;

  const PostActionBar({super.key, required this.post});

  void _showComment(BuildContext context, int postId) {
     showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext build) {
        return CommentListModal(postId: postId, postProvider: Provider.of<PostProvider>(context,listen: false));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Row(
        spacing: 5,
        children: [
          Row(
            spacing: 2,
            children: [
              InkWell(
                onTap: () => Provider.of<PostProvider>(context,listen: false).likeOrUnlikePost(post.postId),
                borderRadius: BorderRadius.circular(10),
                splashColor: post.isLiked != true ? Colors.pinkAccent.withAlpha((0.3 * 255).toInt()) : null,
                child: post.isLiked == true ? Icon(Icons.favorite_rounded,color: Colors.pinkAccent,) : Icon(Icons.favorite_border_outlined)),
              Text(post.totalLike.toString())
            ],
          ),
          Row(
            spacing: 2,
            children:[ 
              GestureDetector(
                onTap: () => _showComment(context,post.postId),
                child: Icon(Icons.comment_outlined),
              ),
              Text(post.totalComment.toString())
            ]
          ),
          SvgPicture.asset(
            "assets/icon/paper-plane.svg",
            width: 20,
            height: 20,
          ),
          Spacer(),
          Icon(Icons.bookmark_outline)
        ],
      );
  }
}