// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Cculd come in handy

/* 

class PlainTextField extends StatelessWidget {
  PlainTextField({
    super.key,
    required this.initialValue,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.validator,
  });

  String initialValue;
  String hintText;
  IconData icon;
  Function(String value) onChanged;
  String? Function(String? value) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: kNormalTextStyle,
      cursorColor: kTextFieldContainerBorderColor,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            icon,
            color: kTextFieldContainerBorderColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
} 

*/

class NameTextField extends StatelessWidget {
  NameTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
  });

  String? initialValue;
  String hintText;
  Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: kNormalTextStyle,
      cursorColor: kTextFieldContainerBorderColor,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.person,
            color: kTextFieldContainerBorderColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field cannot be empty';
        } else {
          return null;
        }
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField({
    this.initialValue,
    this.readOnly,
    required this.onChanged,
  });

  final String? initialValue;
  bool? readOnly;

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      cursorColor: kTextFieldContainerBorderColor,
      style: kNormalTextStyle,
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Email',
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.email_rounded,
            color: kTextFieldContainerBorderColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        return RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!)
            ? null
            : 'Please enter a valid email';
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  PasswordTextField({
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
    required this.onTap,
  });

  String hintText;
  bool obscureText;
  Function(String value) onChanged;
  Function() onTap; // for gesture detector

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kTextFieldContainerBorderColor,
      style: kNormalTextStyle,
      obscureText: obscureText,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.lock,
            color: kTextFieldContainerBorderColor,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: onTap,
            child: obscureText
                ? Icon(
                    FontAwesomeIcons.solidEye,
                    color: kTextFieldContainerBorderColor,
                  )
                : Icon(
                    FontAwesomeIcons.solidEyeSlash,
                    color: kTextFieldContainerBorderColor,
                  ),
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.length < 6) {
          return 'Password must be greater than 6 characters';
        } else {
          return null;
        }
      },
    );
  }
}
