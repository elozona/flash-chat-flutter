import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/custom_text_field.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;
  final _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  bool _isSpinning = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isSpinning,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          autovalidateMode: _autoValidate,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                CustomTextField(
                  hint: 'Enter your email',
                  icon: Icons.email,
                  validator: (input) =>
                      input!.isEmpty ? '*Field is required' : null,
                  onChanged: (input) => email = input!,
                ),
                SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  obscure: true,
                  hint: 'Enter your password',
                  icon: Icons.lock,
                  validator: (input) =>
                      input!.isEmpty ? '*Field is required' : null,
                  onChanged: (input) => password = input!,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      _isSpinning = true;
                    });
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.lightBlueAccent,
                          content: Text('Login Successful!'),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      TextEditingController().clear();
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        _isSpinning = false;
                      });
                    } on FirebaseAuthException catch (exception) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Oops! Login Failed!'),
                              content: Text(exception.message!),
                            );
                          });
                    }
                    setState(() {
                      _isSpinning = false;
                    });
                  },
                  text: 'Log In',
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    WelcomeScreen.id,
                  ),
                  child: Text(
                    'Back To Homepage',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
