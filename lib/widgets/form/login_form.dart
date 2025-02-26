import 'package:flutter/material.dart';
import 'package:intagram_clone/layout/main_layout.dart';
import 'package:intagram_clone/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  String _username = '';
  String _password = '';

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _onSubmit() async{
    if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();

        final navigator = Navigator.of(context);

        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.login(_username, _password);
        if(authProvider.isAuthenticated){
          navigator.pushReplacement( 
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => 
              MainLayout(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
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

    }
  }

  @override
  Widget build(BuildContext context) {
    return 
      Form(
        key: _formKey,
        child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Cannot Be Empty";
                      }
                      return null;
                    },
                    onSaved: (value) => {
                      _username = value!
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Phone number,email or username",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Cannot Be Empty";
                      }
                      return null;

                    },
                    onSaved: (value) => {
                      _password = value!
                    },
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: _showPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                      )
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(color: Colors.blueAccent,width: 1),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                    ),
                    onPressed: _onSubmit, 
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                  Text(
                    "Forgot your login detail? Get help logging in"
                  ),
                  Divider(),
                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      "Log in with Facebook",
                      style: TextStyle(
                        color: Colors.blueAccent
                      ),
                    )
                  ),
                ],
              ),
      );
  }


}