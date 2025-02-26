import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intagram_clone/pages/auth/sign_up_page.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:intagram_clone/widgets/form/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthProvider authService = Provider.of<AuthProvider>(context,listen: true);

    void navigateToSignUp(){
      final navigator = Navigator.of(context);

      navigator.push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = Offset(1, 0);
            final end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(position: animation.drive(tween), child: child);
          },
        )
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                SizedBox(),
                Column(
                  children: [
                    Text(
                      "Instagram Clone",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.ephesis().fontFamily
                      ),
                    ),
                    authService.errorMessage != null ? 
                      Text(
                        authService.errorMessage!,
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ) 
                    : SizedBox.shrink(),
                    LoginForm(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account ?"),
                    TextButton(
                      onPressed: navigateToSignUp,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                      )),
                  ],
                )
              ],
            ),
          ),
        );
  }


}