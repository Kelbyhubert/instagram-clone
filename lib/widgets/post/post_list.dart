import 'package:flutter/material.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:intagram_clone/widgets/post/post_card.dart';
import 'package:intagram_clone/widgets/story_list.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  const PostList({
    super.key,
  });

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();
  late PostProvider postProvider;
  bool _isfetching = false;

  @override
  void initState() {
    super.initState();
    postProvider = Provider.of<PostProvider>(context, listen: false);
    _scrollController.addListener(_loadMore);
  }


  void _loadMore() async {
    if(_isfetching) return;
    
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _isfetching = true;
      }); 
      await postProvider.fetchPosts(offset: postProvider.posts.length);
      setState(() {
        _isfetching = false;
      });
      
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return RefreshIndicator(
      onRefresh: () async => await postProvider.reFetchPosts(),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(child: StoryList(),),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: postProvider.posts.length,
              (context, index) {
                final post = postProvider.posts[index];
                return PostCard(post: post);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: _isfetching ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}




