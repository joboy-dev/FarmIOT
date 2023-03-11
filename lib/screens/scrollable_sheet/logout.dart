// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:FarmIOT/backend/auth.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  final AuthService authService = AuthService();
  bool _isloading = false;

  signOut() async {
    setState(() {
      _isloading = true;
    });
    await authService.logout();
    Navigator.pop(context);
    displaySnackBar(context, 'Successfully logged out');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kAppPadding,
      child: Stack(
        children: [
          Positioned(
            left: 135.0,
            top: 15.0,
            child: Container(
              height: 5.0,
              width: 60.0,
              decoration: BoxDecoration(
                  color: kTextFieldContainerBorderColor,
                  borderRadius: BorderRadius.circular(2.5)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text(
                'Log Out',
                style: kHeaderTextStyle,
              ),
              SizedBox(height: 40.0),
              Text(
                'Are you sure you want to log out?',
                style: kNormalTextStyle,
              ),
              SizedBox(height: 40.0),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      buttonText: 'Log out',
                      onPressed: () {
                        signOut();
                        // Navigator.pushReplacementNamed(context, Login.id);
                      },
                      color: kRedColor,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Button(
                      buttonText: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: kTextFieldContainerBorderColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              _isloading ? Loader() : SizedBox(height: 0.0),
            ],
          ),
        ],
      ),
    );
  }
}
