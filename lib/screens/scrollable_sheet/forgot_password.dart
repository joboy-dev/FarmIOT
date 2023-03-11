// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:FarmIOT/backend/auth.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String email = '';
  String message = '';
  bool _isLoading = false;

  validateForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      dynamic result = _authService.passwordReset(email);
      if (result != null) {
        setState(() {
          _isLoading = false;
          message =
              'A password reset link has been sent to the email provided.';
        });
        displaySnackBar(context, message);
      } else {
        setState(() {
          message = 'Your email may be invalid. Check again.';
          _isLoading = false;
        });
      }
    }
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
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.0),
                Text(
                  'Forgot Password',
                  style: kHeaderTextStyle,
                ),
                SizedBox(height: 40.0),
                EmailTextField(
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 40.0),
                Button(
                  buttonText: 'Send Password Reset Link',
                  onPressed: () {
                    validateForm();
                  },
                  color: kTextFieldContainerBorderColor,
                ),
                SizedBox(height: 20.0),
                _isLoading ? Loader() : SizedBox(height: 0.0),
                SizedBox(height: 20.0),
                !_isLoading
                    ? Center(
                        child: Text(
                          message,
                          style: kNormalTextStyle.copyWith(color: kInfoColor),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
