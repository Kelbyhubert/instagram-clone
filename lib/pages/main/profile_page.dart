import 'package:flutter/material.dart';
import 'package:intagram_clone/pages/auth/login_page.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:intagram_clone/widgets/profile/profile_header.dart';
import 'package:intagram_clone/widgets/profile/profile_tab.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Provider.of<PostProvider>(context, listen: false).clear();
    Navigator.of(context).pushReplacement( 
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => 
              LoginPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Row(
                children: [
                  Icon(Icons.lock_outlined),
                  SizedBox(width: 5),
                  Text(
                    authProvider.user!.username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.expand_more),
                ],
              ),
              actions: [
                IconButton(icon: Icon(Icons.alternate_email), onPressed: () {}),
                IconButton(icon: Icon(Icons.add_box_outlined), onPressed: () {}),
                IconButton(icon: Icon(Icons.logout_outlined), onPressed: () => _logout(context)),
              ],
              floating: true,
              snap: true,
              elevation: 0,
            ),
          ],
          body: Column(
            children: [
              ProfileHeader(authProvider: authProvider),
              ProfileTab(),
            ],
          ),
        ),
      ),
    );
  }
}
