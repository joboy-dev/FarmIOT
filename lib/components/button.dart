// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FarmIOT/constants.dart';

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        FontAwesomeIcons.arrowLeftLong,
        color: kTextColor,
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button({
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  String buttonText;
  Function() onPressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: double.infinity,
      height: 50.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Text(buttonText, style: kButtonTextStyle),
    );
  }
}

class ButtonForText extends StatelessWidget {
  ButtonForText({
    required this.routeName,
    required this.normalText,
    required this.textSpanText,
  });
  final String routeName;
  final String normalText;
  final String textSpanText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
        child: RichText(
          text: TextSpan(
            text: normalText,
            style: kNormalTextStyle,
            children: [
              TextSpan(
                text: textSpanText,
                style: kNormalTextStyle.copyWith(
                  color: kTextFieldContainerBorderColor,
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

class SmallButton extends StatelessWidget {
  const SmallButton({
    required this.toggleSeeResults,
    required this.onPressed,
  });

  final bool toggleSeeResults;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: kTextFieldContainerBorderColor,
      minWidth: 200.0,
      height: 50.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: toggleSeeResults
          ? Text('Hide Results', style: kButtonTextStyle)
          : Text('See Results', style: kButtonTextStyle),
    );
  }
}
