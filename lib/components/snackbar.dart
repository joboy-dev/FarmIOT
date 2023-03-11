// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';

displaySnackBar(BuildContext context, String snackbarText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: kInfoColor,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: kTextFieldContainerBorderColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      duration: Duration(seconds: 4),
      content: Text(
        snackbarText,
        style: kNormalTextStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
