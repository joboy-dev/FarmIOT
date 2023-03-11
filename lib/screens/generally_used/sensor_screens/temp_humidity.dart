// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/sensor_details.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';

class TempHumidity extends StatefulWidget {
  TempHumidity({Key? key}) : super(key: key);

  static const id = 'temp_humidity';

  @override
  State<TempHumidity> createState() => _TempHumidityState();
}

class _TempHumidityState extends State<TempHumidity> {
  double temperature = 30.0;
  double humidity = 20.0;

  String interpretationTemp = '';
  String recommendationTemp = '';
  bool seeResultsTemp = false;

  String interpretationHumidity = '';
  String recommendationHumidity = '';
  bool seeResultsHumidity = false;

  getInterpretationTemp() {
    if (temperature >= 80 && temperature <= 100) {
      setState(() {
        interpretationTemp = 'Soil Temperature is at an excellent level';
        recommendationTemp = 'No recommendation';
      });
    } else if (temperature >= 60 && temperature <= 79) {
      setState(() {
        interpretationTemp = 'Soil Temperature is at a very good level';
        recommendationTemp = 'No recommendation';
      });
    } else if (temperature >= 50 && temperature <= 59) {
      setState(() {
        interpretationTemp = 'Soil Temperature is at an average level';
        recommendationTemp = 'No recommendation';
      });
    } else if (temperature >= 30 && temperature <= 49) {
      setState(() {
        interpretationTemp = 'Soil Temperature is low';
        recommendationTemp = 'Consider turning on the irrigation system';
      });
    } else if (temperature >= 0 && temperature <= 29) {
      setState(() {
        interpretationTemp = 'Soil Temperature is critical';
        recommendationTemp = 'Turn on irrigation system ';
      });
    }
  }

  getInterpretationHumidity() {
    if (humidity >= 80 && humidity <= 100) {
      setState(() {
        interpretationHumidity = 'Humidity is at an excellent level';
        recommendationHumidity = 'No recommendation';
      });
    } else if (humidity >= 60 && humidity <= 79) {
      setState(() {
        interpretationHumidity = 'Humidity is at a very good level';
        recommendationHumidity = 'No recommendation';
      });
    } else if (humidity >= 50 && humidity <= 59) {
      setState(() {
        interpretationHumidity = 'Humidity is at an average level';
        recommendationHumidity = 'No recommendation';
      });
    } else if (humidity >= 30 && humidity <= 49) {
      setState(() {
        interpretationHumidity = 'Humidity is at a low level';
        recommendationHumidity = 'Consider turning on the irrigation system';
      });
    } else if (humidity >= 0 && humidity <= 29) {
      setState(() {
        interpretationHumidity = 'Humidity level is critical';
        recommendationHumidity = 'Turn on irrigation system ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),

                Back(),

                SizedBox(height: 20.0),

                // Header Text
                Text(
                  'Temperature & Humidity',
                  style: kHeaderTextStyle,
                ),
                SizedBox(height: 40.0),

                Column(
                  children: [
                    // temperature
                    SensorDetailsTemp(
                      toggleResults: seeResultsTemp,
                      resourceValue: temperature,
                      resourceText: 'Temperature',
                      interpretationText: interpretationTemp,
                      recommendationText: recommendationTemp,
                      onPressed: () {
                        setState(() {
                          getInterpretationTemp();
                          seeResultsTemp = !seeResultsTemp;
                        });
                      },
                    ),

                    // humidity
                    SensorDetails(
                      toggleResults: seeResultsHumidity,
                      resourceValue: humidity,
                      resourceText: 'Humidity',
                      interpretationText: interpretationHumidity,
                      recommendationText: recommendationHumidity,
                      onPressed: () {
                        setState(() {
                          getInterpretationHumidity();
                          seeResultsHumidity = !seeResultsHumidity;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
