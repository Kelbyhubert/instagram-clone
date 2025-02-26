import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intagram_clone/widgets/post/post_list.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(
              "Instagram Clone",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.ephesis().fontFamily
              ),
            ),
            actions: [
              _buildIcon("assets/icon/heart.svg"),
              _buildIcon("assets/icon/paper-plane.svg"),
            ],
            floating: true,
            snap: true,
            elevation: 0,
          ),
        ],
        body: PostList(),
      ),
    );
  }

  Widget _buildIcon(String assetPath) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SvgPicture.asset(
        assetPath,
        height: 25,
        width: 25,
      ),
    );
  }
}
