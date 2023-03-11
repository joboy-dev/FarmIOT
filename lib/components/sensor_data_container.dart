// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';

class SensorDataContainer extends StatelessWidget {
  const SensorDataContainer({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      height: 220.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(110.0),
        border: Border.all(
          color: kTextFieldContainerBorderColor,
          width: 10.0,
        ),
        color: kBottomSheetBackgroundColor,
      ),
      child: Center(
        child: Text(
          data,
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
      ),
    );
  }
}