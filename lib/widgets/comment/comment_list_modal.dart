import 'package:flutter/material.dart';
import 'package:intagram_clone/models/comment.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:intagram_clone/services/post_service.dart';
import 'package:intagram_clone/widgets/comment/comment_tile.dart';
import 'package:intagram_clone/widgets/form/add_comment_form.dart';
import 'package:provider/provider.dart';

class CommentListModal extends StatefulWidget {
  final int postId;
  final PostProvider postProvider;
  const CommentListModal({
    super.key,
    required this.postId,
    required this.postProvider
  });

  @override
  State<CommentListModal> createState() => _CommentListModalState();
}

class _CommentListModalState extends State<CommentListModal> {
  List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    final postService = PostService(Provider.of<AuthProvider>(context, listen: false).token);
    postService.getPostComment(widget.postId).then((comments) {
      setState(() {
        _comments = comments;
  
      });
      return _comments;
    });
  }

  void _addComment(String comment) async {
    
    final postService = PostService(Provider.of<AuthProvider>(context, listen: false).token);
    final newComment = await postService.commentPost(widget.postId,comment);
    await widget.postProvider.commentAdded(widget.postId);
    setState(() {
      _comments.add(newComment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 1,
      minChildSize: 0.9,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Comment"),
              ),
              Divider(),
              Expanded(
                child: 
                      _comments.isEmpty ? 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            "Be first to comment",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Spark a conversation or sprinkle a litte joy",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700]
                            ),
                          ),
                        ],
                      )
                      :
                      ListView.builder(
                        controller: scrollController,
                        itemCount: _comments.length,
                        itemBuilder : (BuildContext build, int index) {
                          return CommentTile(comment: _comments[index],);
                      }
                    )
              ),
              AddCommentForm(addCommentHandler: _addComment,)
            ],
          ),
        );
      }
    );
  }
}

