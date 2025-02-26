import 'package:flutter/material.dart';
import 'package:intagram_clone/exception/api_error_exception.dart';
import 'package:intagram_clone/services/auth_service.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {


  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _submitting = false;

  String _username = '';
  String _password = '';
  String _phoneNumber = '';
  String _email = '';

  Map<String,dynamic>? _errors = {};

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _onSubmit() async{
    if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final navigator = Navigator.of(context);

    final AuthService authService = AuthService();
    try {
      setState(() {
        _submitting = true;
      });

      await authService.register(
            _username, 
            _password, 
            _phoneNumber, 
            _email);      
      navigator.pop();

    } on ApiErrorException catch (e) {
      setState(() {
        _errors = e.errors;
      });
      
    } on Exception catch (e) {
      print(e.toString());

    }finally{
        setState(() {
        _submitting = false;
      });
    }

  }
  

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.length < 4){
                        return "Username atleast have 4 Character";
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
                      hintText: "Username",
                      filled: true,
                      fillColor: Colors.grey[200],
                      errorText: _errors!['username']
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Cannot Be Empty";
                      }
                      if(!value.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))){
                        return "Invalid Email";
                      }
                      return null;
                    },
                    onSaved: (value) => {
                      _email = value!
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.grey[200],
                      errorText: _errors!['email']
                    ),
                  ),
                                    TextFormField(
                    validator: (value) {
                      if(value == null || value.length < 12){
                        return "Phone number must atleast have 12 number";
                      }
                      return null;
                    },
                    onSaved: (value) => {
                      _phoneNumber = value!
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Phone Number",
                      filled: true,
                      fillColor: Colors.grey[200],
                      errorText: _errors!['phoneNumber']
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty || value.length < 10){
                        return "Password must atleast have 10 character";
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
                    onPressed: !_submitting ? _onSubmit : null, 
                    child: _submitting 
                      ? CircularProgressIndicator(color: Colors.white) 
                      : Text(
                        "Sign Up",
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "By signing up, you agree our Term, Policy and Cookies Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
      );
  }
}