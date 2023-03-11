// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';

showDialogBox({required String dialogText, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          dialogText,
          style: kNormalTextStyle.copyWith(fontWeight: FontWeight.w400),
          // textAlign: TextAlign.justify,
        ),
        backgroundColor: kBottomSheetBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actionsPadding: EdgeInsets.only(bottom: 20.0),
        actions: [
          Center(
            child: MaterialButton(
              onPressed: () {
                // Close Dialog box
                Navigator.pop(context);
              },
              color: kTextFieldContainerBorderColor,
              minWidth: 100.0,
              height: 50.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Text('OK', style: kButtonTextStyle),
            ),
          ),
        ],
      );
    },
  );
}
