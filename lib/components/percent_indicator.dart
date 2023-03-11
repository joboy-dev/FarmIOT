// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  double percent;
  String percentText;

  PercentIndicator({required this.percent, required this.percentText});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 55.0,
      lineWidth: 10.0,
      backgroundColor: kTextFieldContainerBorderColor.withOpacity(0.4),
      progressColor: kInfoColor,
      percent: percent,
      animation: true,
      animationDuration: 2000,
      reverse: true,
      curve: Curves.easeInOut,
      center: Text(
        percentText,
        style: kOtherTextStyle,
      ),
    );
  }
}