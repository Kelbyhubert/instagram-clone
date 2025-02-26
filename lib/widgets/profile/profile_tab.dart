import 'package:flutter/material.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Expanded(
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(
                icon: Icon(Icons.apps,
              )
              ),
              Tab(icon: Icon(Icons.video_call_outlined)),
              Tab(icon: Icon(Icons.supervised_user_circle_outlined)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                postProvider.userPosts.isEmpty
                  ? Center(child: Text("Capture the moment with a friend"))
                  : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: postProvider.userPosts.length,
                    itemBuilder: (context, index) {
                      return Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Image.network(
                        postProvider.userPosts[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                      );
                    },
                    ),
                Center(child: Text("Share a moment with the world")),
                Center(child: Text("No tagged photos")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
