import 'package:flutter/material.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AddCommentForm extends StatefulWidget {
  final Function(String) addCommentHandler;
  const AddCommentForm({
    super.key, 
    required this.addCommentHandler, 
  });

  @override
  State<AddCommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<AddCommentForm> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener((){
        setState(() {});
      }
    );
  }

  void _submitComment() {
    if (_textEditingController.text.isEmpty) return;
    
    widget.addCommentHandler(_textEditingController.text);
    FocusScope.of(context).unfocus();
    _textEditingController.clear();
    
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);
    return ListTile(
      leading: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.grey,
        backgroundImage: 
        NetworkImage(
          authProvider.user!.profilePictureUrl == "" ? "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png" 
          :
          authProvider.user!.profilePictureUrl
        ),
      ),
      title: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Add a commend for ..."
        ),
      ),
      trailing: 
      _textEditingController.text.isEmpty ?  
            Icon(Icons.ac_unit_rounded) : 
            IconButton(
              onPressed: _submitComment, 
              icon: Icon(Icons.arrow_upward)
            )
    );
  }
}