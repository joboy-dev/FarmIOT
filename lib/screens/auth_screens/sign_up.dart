// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:FarmIOT/backend/auth.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/auth_screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  static const id = 'sign_up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  // initialize auth service
  final AuthService authService = AuthService();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';

  String message = '';

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isLoading = false;

  validateSignUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // check if both passwords are the same
      if (password == confirmPassword) {
        // set loading to be true so that the loader can show
        setState(() {
          _isLoading = true;
        });

        // store result gotten from creating the user like the user credentials.
        // in this case, it is the user id because of how it is specified in the
        // createAccount function
        dynamic result = await authService.createAccount(
            email, password, firstName, lastName);

        if (result == null) {
          setState(() {
            message =
                'Could not register with these credentials. Check your email or your network connection';
            _isLoading = false;
          });
        } else {
          setState(() {
            message = 'Successfully signed up';
            _isLoading = false;
          });
          Navigator.pop(context);
        }
      } else {
        setState(() {
          message = 'Your passwords do not match';
          _isLoading = false;
        });
      }
      displaySnackBar(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),

                  // Header Text
                  Text(
                    'Create Account',
                    style: kHeaderTextStyle,
                  ),
                  SizedBox(height: 50.0),

                  // TextField
                  NameTextField(
                    hintText: 'First Name',
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),

                  // TextField
                  NameTextField(
                    hintText: 'Last Name',
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),

                  // TextField
                  EmailTextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),

                  // TextField
                  PasswordTextField(
                    hintText: 'Password',
                    obscureText: _obscureText1,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    onTap: () {
                      setState(() {
                        // set obscureText value to be false if
                        //_obscureText is true and set it to be true if
                        // it is false
                        _obscureText1 = _obscureText1 ? false : true;
                      });
                    },
                  ),

                  
                  SizedBox(height: 20.0),

                  // TextField
                  PasswordTextField(
                    hintText: 'Confirm Password',
                    obscureText: _obscureText2,
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    onTap: () {
                      setState(() {
                        // set obscureText value to be false if
                        //_obscureText is true and set it to be true if
                        // it is false
                        _obscureText2 = _obscureText2 ? false : true;
                      });
                    },
                  ),
                  
                  SizedBox(height: 20.0),

                  // Sign Up Button
                  Button(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      // create user and store in firestore
                      validateSignUp();
                    },
                    color: kBrownButton,
                  ),
                  SizedBox(height: 20.0),

                  ButtonForText(
                    routeName: Login.id,
                    normalText: 'Already have an account? ',
                    textSpanText: 'Log in',
                  ),
                  SizedBox(height: 30.0),
                  _isLoading ? Loader() : SizedBox(height: 0.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
