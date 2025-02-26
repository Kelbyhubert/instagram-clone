import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:intagram_clone/services/firebase_service.dart';
import 'package:provider/provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File? _image;
  bool _isSubmitting = false;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _captionController = TextEditingController();


  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _onSubmit() async {
    if (_image == null || _captionController.text.isEmpty) return;
    setState(() {
      _isSubmitting = true;
    });

    final navigator = Navigator.of(context);
    final PostProvider postProvider = Provider.of<PostProvider>(context,listen: false);

    String? imageUrl = await uploadImage(_image!);

    if (imageUrl != null) {
      await postProvider.createNewPost(imageUrl,_captionController.text);

      if(navigator.mounted){
          setState(() {
            _isSubmitting = false;
          });

          navigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("New post" , style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _onSubmit,
            child: _isSubmitting
                ? CircularProgressIndicator(
                    color: Colors.blueAccent,
                  )
                : Text(
                    "Post",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 1,
                child: _image != null
                    ? Image.file(_image!, width: double.infinity, height: 300, fit: BoxFit.cover)
                    : Container(
                        width: double.infinity,
                        height: 300,
                        color: Colors.grey[500],
                        child: TextButton.icon(
                          onPressed: !_isSubmitting ? _pickImage : null,
                          icon: Icon(Icons.image,color: Colors.white70,),
                          label: Text(
                            "Click to pick image from gallery",
                            style: TextStyle(
                              color: Colors.white70
                            ),
                          ),
                        ),
                      ),
              ),
              _image != null
                  ? TextButton.icon(
                      onPressed: !_isSubmitting ? _pickImage : null,
                      icon: Icon(Icons.image),
                      label: Text(
                        "Pick Other Image",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      enabled: !_isSubmitting,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      controller: _captionController,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        hintStyle: TextStyle(
                          color: Colors.white54
                        ),
                        border: InputBorder.none,
                        
                      ),
                      maxLines: null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}