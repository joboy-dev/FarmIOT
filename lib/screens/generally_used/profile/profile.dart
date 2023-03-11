// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_string_interpolations, prefer_const_constructors_in_immutables

import 'package:FarmIOT/components/bottom_sheet.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:FarmIOT/screens/scrollable_sheet/change_password.dart';
import 'package:FarmIOT/screens/scrollable_sheet/edit_profile.dart';
import 'package:FarmIOT/screens/scrollable_sheet/logout.dart';
import 'package:FarmIOT/screens/scrollable_sheet/selecct_picture_format.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  static Profile profile = Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // get current user data
    final userData = Provider.of<UserData?>(context);

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: userData == null
          ? Center(child: Loader())
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: kAppPadding.copyWith(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Profile',
                        style: kOtherTextStyle,
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: kTextFieldContainerBorderColor,
                              radius: 55.0,
                              backgroundImage:
                                  NetworkImage(userData.profilePic),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '${userData.firstName} ${userData.lastName}', //  Registered user's name should be here
                              style: kNormalTextStyle.copyWith(fontSize: 17.0),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              '${userData.email}', //  Registered user's email should be here
                              style: kNormalTextStyle.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),

                      Divider(
                        color: kTextFieldContainerBorderColor,
                      ),
                      SizedBox(height: 20.0),

                      // Items
                      GestureDetector(
                        onTap: () {
                          showSheet(
                              screen: SelectImageFormat(), context: context);
                        },
                        child: ProfileItems(
                          icon: FontAwesomeIcons.camera,
                          text: 'Update Profile Picture',
                        ),
                      ),
                      SizedBox(height: 30.0),

                      GestureDetector(
                        onTap: () {
                          showSheet(screen: EditProfile(), context: context);
                        },
                        child: ProfileItems(
                          icon: Icons.person,
                          text: 'Edit Profile',
                        ),
                      ),
                      SizedBox(height: 30.0),

                      GestureDetector(
                        onTap: () {
                          showSheet(screen: ChangePassword(), context: context);
                        },
                        child: ProfileItems(
                          icon: FontAwesomeIcons.lock,
                          text: 'Change Password',
                        ),
                      ),
                      SizedBox(height: 30.0),

                      GestureDetector(
                        onTap: () {
                          showSheet(screen: LogOut(), context: context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Icon(
                                FontAwesomeIcons.signOut,
                                color: kTextFieldContainerBorderColor,
                                size: kIconSize30,
                              ),
                            ),
                            SizedBox(width: 30.0),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Log Out',
                                style: kNormalTextStyle.copyWith(
                                  color: kRedColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class ProfileItems extends StatelessWidget {
  final String text;
  final IconData icon;
  const ProfileItems({
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: Icon(
            icon,
            color: kTextFieldContainerBorderColor,
            size: kIconSize30,
          ),
        ),
        SizedBox(width: 30.0),
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: kNormalTextStyle,
          ),
        ),
        Expanded(
          flex: 0,
          child: Icon(
            FontAwesomeIcons.caretRight,
            color: kInfoColor.withOpacity(0.5),
          ),
        )
      ],
    );
  }
}
