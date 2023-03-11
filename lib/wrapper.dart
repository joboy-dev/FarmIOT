// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/components/bottom_navbar.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:FarmIOT/screens/onboarding/get_started.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  static const String id = 'wrapper';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return GetStarted();
    } else {
      return BottomNavBar();
    }
  }
}
