// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';

import 'percent_indicator.dart';

class SoilCondition extends StatelessWidget {
  final String resource;
  final String percentText;

  SoilCondition({
    required this.resource,
    required this.percentText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          resource,
          style: kNormalTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        PercentIndicator(
          percent: double.parse(percentText) / 100,
          percentText: percentText,
        ),
      ],
    );
  }
}