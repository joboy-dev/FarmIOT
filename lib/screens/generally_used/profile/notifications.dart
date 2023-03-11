// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/constants.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);
  static const id = 'notifications';

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: kAppPadding.copyWith(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(),
              SizedBox(height: 20.0),
              Text(
                'Notifications',
                style: kHeaderTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
