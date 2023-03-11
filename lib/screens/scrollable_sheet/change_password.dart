// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:FarmIOT/backend/auth.dart';
import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/components/bottom_sheet.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/dialog_box.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/components/text_field.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:FarmIOT/screens/scrollable_sheet/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();

  String? email;
  String oldPassword = '';
  String password = '';
  String confirmPassword = '';

  String message = '';

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // get current user
    final user = Provider.of<UserModel?>(context);

    return StreamBuilder<UserData?>(
      stream: Database(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Change Password',
                              style: kHeaderTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: IconButton(
                              onPressed: () {
                                // Show Dialog Box
                                showDialogBox(
                                  dialogText:
                                      'Your email is required to change your password as we would have to re-authenticate you with your email and old password for your security.',
                                  context: context,
                                );
                              },
                              icon: Icon(FontAwesomeIcons.circleInfo),
                              color: kInfoColor,
                              iconSize: kIconSizeSmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0),

                      // text field
                      EmailTextField(
                        initialValue: userData?.email,
                        readOnly: true,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),

                      // old password
                      PasswordTextField(
                        hintText: 'Old Password',
                        obscureText: _obscureText1,
                        onChanged: (value) {
                          setState(() {
                            oldPassword = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            // set obscureText value to be false if
                            //_obscureText is true and set it to be true if
                            // it is false
                            _obscureText1 = !_obscureText1;
                          });
                        },
                      ),

                      SizedBox(height: 20.0),

                      // new password
                      PasswordTextField(
                        hintText: 'New Password',
                        obscureText: _obscureText2,
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
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),

                      // confirm new password
                      PasswordTextField(
                        hintText: 'Confirm Password',
                        obscureText: _obscureText3,
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
                            _obscureText3 = !_obscureText3;
                          });
                        },
                      ),
                      SizedBox(height: 5.0),

                      // forgot password?
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                            flex: 0,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Show bottom sheet
                                showSheet(
                                    screen: ForgotPassword(), context: context);
                              },
                              child: Text(
                                'Forgot Password?',
                                selectionColor: kTextFieldContainerBorderColor
                                    .withOpacity(0.5),
                                style: kNormalTextStyle.copyWith(
                                    color: kInfoColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0),

                      // buttons
                      Row(
                        children: [
                          Expanded(
                            child: Button(
                              buttonText: 'Save',
                              onPressed: () async {
                                // validateForm();

                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  // check passwords
                                  if (password == confirmPassword) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    dynamic result =
                                        await authService.changePassword(
                                            email: email ?? userData?.email,
                                            oldPassword: oldPassword,
                                            newPassword: password);

                                    if (result == null) {
                                      setState(() {
                                        message =
                                            'Password change unsuccessful. Check your email and old password';
                                        _isLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        message = 'Password change successful';
                                        _isLoading = false;
                                      });

                                      Navigator.pop(context);
                                      displaySnackBar(context, message);
                                    }
                                  } else {
                                    setState(() {
                                      message = 'Your passwords do not match';
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                              color: kBrownButton,
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
                      SizedBox(height: 20.0),
                      _isLoading ? Loader() : SizedBox(height: 0.0),

                      SizedBox(height: 20.0),

                      !_isLoading
                          ? Center(
                              child: Text(
                                message,
                                style: kNormalTextStyle.copyWith(
                                    color: kInfoColor),
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
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.0),
              Text(
                'Loading data. Please wait.',
                style: kNormalTextStyle.copyWith(color: kInfoColor),
              ),
              SizedBox(height: 20.0),
              Loader()
            ],
          );
        }
      },
    );
  }
}
