// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/components/percent_indicator.dart';
import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';

class SensorDetails extends StatelessWidget {
  const SensorDetails({
    super.key,
    required this.toggleResults,
    required this.resourceValue,
    required this.resourceText,
    required this.interpretationText,
    required this.recommendationText,
    required this.onPressed,
  });

  final bool toggleResults;
  final double resourceValue;
  final String resourceText;
  final String interpretationText;
  final String recommendationText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                resourceText,
                style: kOtherTextStyle,
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: kBrownButton),
                child: toggleResults
                    ? Text('Hide Analysis',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: kTextColor,
                        ))
                    : Text('View Analysis',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: kTextColor,
                        )),
              ),
            )
          ],
        ),

        SizedBox(height: 10.0),

        // container for sensor data
        Row(
          children: [
            Expanded(
              flex: 1,
              child: PercentIndicator(
                percent: resourceValue / 100,
                percentText: '${resourceValue.toString()}%',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  toggleResults
                      ? Text(
                          interpretationText,
                          style: kNormalTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        )
                      : SizedBox(height: 0.0),
                  SizedBox(height: 10.0),
                  toggleResults
                      ? Text(
                          recommendationText,
                          style: kNormalTextStyle,
                        )
                      : SizedBox(height: 0.0),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),

        Divider(
          thickness: 0.5,
          color: kInfoColor,
        ),

        SizedBox(height: 10.0),
      ],
    );
  }
}

class SensorDetailsTemp extends StatelessWidget {
  const SensorDetailsTemp({
    super.key,
    required this.toggleResults,
    required this.resourceValue,
    required this.resourceText,
    required this.interpretationText,
    required this.recommendationText,
    required this.onPressed,
  });

  final bool toggleResults;
  final double resourceValue;
  final String resourceText;
  final String interpretationText;
  final String recommendationText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                resourceText,
                style: kOtherTextStyle,
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(backgroundColor: kBrownButton),
                child: toggleResults
                    ? Text('Hide Analysis',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: kTextColor,
                        ))
                    : Text('View Analysis',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: kTextColor,
                        )),
              ),
            )
          ],
        ),

        SizedBox(height: 10.0),

        // container for sensor data
        Row(
          children: [
            Expanded(
              flex: 1,
              child: PercentIndicator(
                percent: resourceValue / 100,
                percentText: '${resourceValue.toString()}°C',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  toggleResults
                      ? Text(
                          interpretationText,
                          style: kNormalTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        )
                      : SizedBox(height: 0.0),
                  SizedBox(height: 10.0),
                  toggleResults
                      ? Text(
                          recommendationText,
                          style: kNormalTextStyle,
                        )
                      : SizedBox(height: 0.0),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),

        Divider(
          thickness: 0.5,
          color: kInfoColor,
        ),

        SizedBox(height: 10.0),
      ],
    );
  }
}
