import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intagram_clone/layout/main_layout.dart';
import 'package:intagram_clone/pages/auth/login_page.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:intagram_clone/providers/post_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider(authProvider: Provider.of<AuthProvider>(context,listen: false)),)
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.instrumentSansTextTheme(Theme.of(context).textTheme)
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}



