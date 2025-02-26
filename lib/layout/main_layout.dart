import 'package:flutter/material.dart';
import 'package:intagram_clone/pages/main/create_post_page.dart';
import 'package:intagram_clone/pages/main/explore_page.dart';

import 'package:intagram_clone/pages/main/profile_page.dart';
import 'package:intagram_clone/pages/main/home_page.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainLayout> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PostProvider>(context,listen: false).fetchPosts();
    Provider.of<PostProvider>(context,listen: false).fetchUserPost();
  }
  
  final List<Widget> pages = [
    HomePage(),
    ExplorePage(),
    CreatePostPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.white70,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => {
          if(index == 2){
            Navigator.push(
              context, 
              PageRouteBuilder(
                pageBuilder: 
                  (context, animation, secondaryAnimation) => pages[2],
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1,0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(position: animation.drive(tween), child: child);
                  },
              )
            )
          }else{
            setState(() {
              _selectedIndex = index;
            })
          }
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
                Icons.home,
                weight: 400,
              ),
            icon: Icon(Icons.home_outlined), 
            label: ""
          ),
          NavigationDestination(
            selectedIcon: IconTheme(
              data: IconThemeData(size: 28,weight: 800),
              child: Icon(Icons.search),
            ),
            icon: Icon(Icons.search_outlined), 
            label: ""
          ),
            NavigationDestination(
              selectedIcon: Icon(
              Icons.person_2,
              weight: 400,
            ),
            icon: Icon(Icons.add_box_outlined), 
            label: ""
          ),
          NavigationDestination(
              selectedIcon: Icon(
              Icons.person_2,
              weight: 400,
            ),
            icon: Icon(Icons.person_2_outlined), 
            label: ""
          )
        ],
      ),
    );
  }
}