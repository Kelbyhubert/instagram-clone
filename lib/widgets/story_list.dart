import 'package:flutter/material.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class StoryList extends StatelessWidget {

  final List<Map<String, String>> dummyUser = [
    {
      "username": "David",
      "imageUrl": "https://randomuser.me/api/portraits/men/1.jpg"
    },
    {
      "username": "Natty",
      "imageUrl": "https://randomuser.me/api/portraits/women/2.jpg"
    },
    {
      "username": "Rayleid",
      "imageUrl": "https://randomuser.me/api/portraits/men/3.jpg"
    },
    {
      "username": "Nami",
      "imageUrl": "https://randomuser.me/api/portraits/women/4.jpg"
    },
    {
      "username": "Usopp",
      "imageUrl": "https://randomuser.me/api/portraits/men/5.jpg"
    },
  ];

  StoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                spacing: 5,
                children: [
                  Stack(
                    children: [
                      
                      CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            authProvider.user!.profilePictureUrl == "" ? "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png" 
                      :
                      authProvider.user!.profilePictureUrl),
                          radius: 50,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            size: 35,
                            Icons.add_circle_rounded,
                            color: Colors.grey,
                          ),
                        )
                      ),
                    ],
                  ),
                  Text("Your Story")
                ],
              ),
            ),
            ...List.generate(5, (index) => 
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                   CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(dummyUser[index].values.elementAt(1)),
                      radius: 50,
                  ),
                  Text(dummyUser[index].values.elementAt(0))
                ],
              ),
              )
          )]
        ),
      ),
    );
  }
}