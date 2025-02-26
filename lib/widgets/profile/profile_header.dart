import 'package:flutter/material.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  final AuthProvider authProvider;
  const ProfileHeader({required this.authProvider});
  

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                authProvider.user!.profilePictureUrl == "" ? "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png" 
                  :
                  authProvider.user!.profilePictureUrl,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authProvider.user!.username,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _profileStat(postProvider.userPosts.length.toString(), "posts"),
                      _profileStat("100", "followers"),
                      _profileStat("100", "following"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _profileStat(String count, String label) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          count, 
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold
          )
        ),
        Text(
          label, 
          style: TextStyle(
            fontSize: 12, 
            color: Colors.grey)
        ),
      ],
    );
  }
}
