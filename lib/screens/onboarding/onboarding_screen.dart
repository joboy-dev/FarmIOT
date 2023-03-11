// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/onboarding/get_started.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  static const id = 'onboarding_screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  // Animation
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });

    animation = ColorTween(
      begin: Colors.green,
      end: kAppBackgroundColor,
    ).animate(animationController);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, Wrapper.id);
        // Navigator.pushReplacementNamed(context, GetStarted.id);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: kAppPadding,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                child: Image(
                  image:
                      AssetImage('assets/images/project logo final year.png'),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'Farm I⚙️T',
                style: TextStyle(
                  fontSize: 35.0,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
