// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/components/text_field.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();

  String? email;
  String? fName;
  String? lName;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // get current user
    final user = Provider.of<UserModel?>(context);

    // create a stream builder to retrieve all the data from firestore
    return StreamBuilder<UserData?>(
      stream: Database(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // we need userData to recover when a user sets his/ her
          // preferences and wants to change them later
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
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.0),
                      Text(
                        'Edit Profile',
                        style: kHeaderTextStyle,
                      ),
                      SizedBox(height: 40.0),

                      // text field
                      NameTextField(
                        initialValue: userData?.firstName,
                        hintText: 'First Name',
                        onChanged: (value) {
                          setState(() {
                            fName = value;
                          });
                        },
                      ),

                      SizedBox(height: 20.0),

                      NameTextField(
                        initialValue: userData?.lastName,
                        hintText: 'Last Name',
                        onChanged: (value) {
                          setState(() {
                            lName = value;
                          });
                        },
                      ),

                      SizedBox(height: 20.0),

                      // EmailTextField(userData: userData),

                      EmailTextField(
                        initialValue: userData?.email,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),

                      SizedBox(height: 40.0),

                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            // Save button
                            child: Button(
                              buttonText: 'Save',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  // call the database function to update user data
                                  await Database(uid: user.uid).updateUserData(
                                    email: email ?? userData?.email,
                                    firstName: fName ?? userData?.firstName,
                                    lastName: lName ?? userData?.lastName,
                                  );

                                  setState(() {
                                    _isLoading = false;
                                  });

                                  Navigator.pop(context);

                                  displaySnackBar(
                                    context,
                                    'Record updated successfully',
                                  );
                                }
                              },
                              color: kBrownButton,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            // Cancel button
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
