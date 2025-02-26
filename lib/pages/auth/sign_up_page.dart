import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intagram_clone/widgets/form/register_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              spacing: 15,
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
                RegisterForm(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Have account ?"),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Sign In",
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