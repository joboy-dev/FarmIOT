// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/auth_screens/login.dart';
import 'package:FarmIOT/screens/auth_screens/sign_up.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  static const id = 'get_started';

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding.copyWith(
              top: 132.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: Image(
                    image:
                        AssetImage('assets/images/project logo final year.png'),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Welcome to Farm I⚙️T',
                  style: kHeaderTextStyle.copyWith(
                    color: kTextFieldContainerBorderColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Monitoring your farm conditions is made easy with the use of this app. Sign up to start using the app now.',
                  style: kNormalTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Button(
                  buttonText: 'Create Account',
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.id);
                  },
                  color: kBottomSheetBackgroundColor,
                ),
                SizedBox(height: 30),
                Button(
                  buttonText: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, Login.id);
                  },
                  color: kTextFieldContainerBorderColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
