// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:FarmIOT/backend/auth.dart';
import 'package:FarmIOT/components/dialog_box.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/components/bottom_navbar.dart';
import 'package:FarmIOT/components/bottom_sheet.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/auth_screens/sign_up.dart';
import 'package:FarmIOT/screens/scrollable_sheet/forgot_password.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';

  bool _obscureText = true;
  bool _isLoading = false;
  String message = '';

  validateLogIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      dynamic result = await authService.logIn(email, password);

      if (result == null) {
        setState(() {
          message =
              'Could not log in with these credentials. Check your email and password or your network connection';
          _isLoading = false;
        });
      } else {
        setState(() {
          message = 'Successfully logged in';
          _isLoading = false;
        });
        Navigator.pop(context);
      }
      displaySnackBar(context, message);
    }
  }

  void showForgotPasswordSheet() {
    return showSheet(screen: ForgotPassword(), context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: kAppPadding,
              child: Form(
                key: formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),

                    Center(
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        child: Image(
                          image: AssetImage(
                              'assets/images/project logo final year.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),

                    Text(
                      'Login',
                      style: kHeaderTextStyle,
                    ),
                    SizedBox(height: 50.0),

                    EmailTextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    PasswordTextField(
                      hintText: 'Password',
                      obscureText: _obscureText,
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
                          _obscureText = _obscureText ? false : true;
                        });
                      },
                    ),

                    SizedBox(height: 5.0),

                    // Forgot Password?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 0,
                          child: TextButton(
                            onPressed: () {
                              // Show bottom sheet
                              showSheet(
                                  screen: ForgotPassword(), context: context);
                            },
                            child: Text(
                              'Forgot Password?',
                              selectionColor: kTextFieldContainerBorderColor
                                  .withOpacity(0.5),
                              style: kNormalTextStyle.copyWith(
                                  color: kTextFieldContainerBorderColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),

                    Button(
                      buttonText: 'Login',
                      onPressed: () {
                        // Check if user exists and if details are correct and log
                        // the user in

                        validateLogIn();
                      },
                      color: kBrownButton,
                    ),
                    SizedBox(height: 20.0),

                    // Don't have an account
                    ButtonForText(
                      routeName: SignUp.id,
                      normalText: "Don't have an account? ",
                      textSpanText: 'Create Account',
                    ),
                    SizedBox(height: 30.0),
                    _isLoading ? Loader() : SizedBox(height: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
