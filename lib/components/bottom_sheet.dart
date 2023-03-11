// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';

void showSheet({required Widget screen, required BuildContext context}) {
  showModalBottomSheet(
    backgroundColor: kBottomSheetBackgroundColor,
    isScrollControlled: true,
    barrierColor: Colors.black.withOpacity(0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.45,
        maxChildSize: 0.9,
        minChildSize: 0.08,
        expand: false,
        snap: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: screen,
          );
        },
      );
    },
  );
}
