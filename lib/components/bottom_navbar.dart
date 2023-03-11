// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/generally_used/home/home.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/my_crops.dart';
import 'package:FarmIOT/screens/generally_used/profile/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static const id = 'navbar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  List navbarTabs = [
    Home.home,
    MyCrops.myCrops,
    Profile.profile,
  ];

  List<BottomNavigationBarItem> bottomNavBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.seedling),
      label: 'My Crops',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBar,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kBottomSheetBackgroundColor,
        currentIndex: _currentIndex,
        selectedItemColor: kInfoColor,
        unselectedItemColor: kTextFieldContainerBorderColor,
        iconSize: 30.0,
        selectedIconTheme: IconThemeData(size: 40.0),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: navbarTabs[_currentIndex],
    );
  }
}
