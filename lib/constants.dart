// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const fontFamily = 'Raleway';

const kAppPadding = EdgeInsets.only(left: 15.0, right: 15.0);

const kTextColor = Color(0xFFD2E1E9);

const kAppBackgroundColor = Color(0xFF0D1611);

const kTextFieldContainerBorderColor = Color(0xFF677865);

const kBottomSheetBackgroundColor = Color(0xFF1F4128);

const kBrownButton = Color(0xFF702B01);

const kInfoColor = Color(0xFFB9BFA8);

const kRedColor = Color(0xFFAC2828);

const kIconSizeSmall = 20.0;

const kIconSize25 = 25.0;

const kIconSize30 = 30.0;

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  color: kTextColor,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w500,
);

const kNormalTextStyle = TextStyle(
  fontSize: 15.0,
  color: kTextColor,
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
);

const kHeaderTextStyle = TextStyle(
  fontSize: 25.0,
  color: kTextColor,
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
);

const kOtherTextStyle = TextStyle(
  fontSize: 20.0,
  color: kTextColor,
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
);

var kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: kNormalTextStyle.copyWith(color: Colors.white.withOpacity(0.5)),
  prefixIcon: Icon(Icons.person),
  labelStyle: TextStyle(
    color: kTextFieldContainerBorderColor,
    fontWeight: FontWeight.w300,
    fontSize: 12.0,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kTextFieldContainerBorderColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kTextFieldContainerBorderColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kInfoColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kInfoColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  errorStyle: TextStyle(
    color: kInfoColor,
    fontFamily: fontFamily,
  ),
);
