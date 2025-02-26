import 'package:flutter/material.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
      final postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon:Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Search"
                ),
              ),
            ),
            floating: true,
            snap: true,
            elevation: 0,
          )
        ],
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: postProvider.posts.length, 
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              child: Image.network(
                  postProvider.posts[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        )
      );
  }
}