import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/custom_text_field.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autovalidate = AutovalidateMode.onUserInteraction;
  final _auth = FirebaseAuth.instance;
  bool _isSpinning = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isSpinning,
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidate,
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
                    text: 'Register',
                    color: Colors.blueAccent,
                    onPressed: () async {
                      setState(() {
                        _isSpinning = true;
                      });
                      final FormState? form = _formKey.currentState;
                      if (form != null) {
                        if (form.validate()) {
                          form.save();
                        }
                      }
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blueAccent,
                            content: Text(
                                'Registered Successfully! You Can Login Now.'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                        Navigator.pushNamed(context, LoginScreen.id);
                        TextEditingController().clear();
                        setState(() {
                          _isSpinning = false;
                        });
                      } on FirebaseAuthException catch (exception) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Oops! Registration Failed!'),
                                content: Text(exception.message!),
                              );
                            });
                        setState(() {
                          _isSpinning = false;
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
