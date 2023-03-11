// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/percent_indicator.dart';
import 'package:FarmIOT/components/sensor_data_container.dart';
import 'package:FarmIOT/components/sensor_details.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';

class Npk extends StatefulWidget {
  Npk({Key? key}) : super(key: key);

  static const id = 'npk';

  @override
  State<Npk> createState() => _NpkState();
}

class _NpkState extends State<Npk> {
  double nitrogen = 3.00;
  double phosphorus = 2.50;
  double potassium = 2.00;

  String interpretationNitrogen = '';
  String recommendationNitrogen = '';
  bool seeResultsNitrogen = false;

  String interpretationPhosphorus = '';
  String recommendationPhosphorus = '';
  bool seeResultsPhosphorus = false;

  String interpretationPotassium = '';
  String recommendationPotassium = '';
  bool seeResultsPotassium = false;

  getInterpretationNitrogen() {
    if (nitrogen >= 80 && nitrogen <= 100) {
      setState(() {
        interpretationNitrogen = 'Soil nitrogen is at an excellent level';
        recommendationNitrogen = 'No recommendation';
      });
    } else if (nitrogen >= 60 && nitrogen <= 79) {
      setState(() {
        interpretationNitrogen = 'Soil nitrogen is at a very good level';
        recommendationNitrogen = 'No recommendation';
      });
    } else if (nitrogen >= 50 && nitrogen <= 59) {
      setState(() {
        interpretationNitrogen = 'Soil nitrogen is at an average level';
        recommendationNitrogen = 'No recommendation';
      });
    } else if (nitrogen >= 30 && nitrogen <= 49) {
      setState(() {
        interpretationNitrogen = 'Soil nitrogen is low';
        recommendationNitrogen = 'Consider turning on the irrigation system';
      });
    } else if (nitrogen >= 0 && nitrogen <= 29) {
      setState(() {
        interpretationNitrogen = 'Soil nitrogen is critical';
        recommendationNitrogen = 'Turn on irrigation system ';
      });
    }
  }

  getInterpretationPhosphorus() {
    if (phosphorus >= 80 && phosphorus <= 100) {
      setState(() {
        interpretationPhosphorus = 'Phosphorus is at an excellent level';
        recommendationPhosphorus = 'No recommendation';
      });
    } else if (phosphorus >= 60 && phosphorus <= 79) {
      setState(() {
        interpretationPhosphorus = 'Phosphorus is at a very good level';
        recommendationPhosphorus = 'No recommendation';
      });
    } else if (phosphorus >= 50 && phosphorus <= 59) {
      setState(() {
        interpretationPhosphorus = 'Phosphorus is at an average level';
        recommendationPhosphorus = 'No recommendation';
      });
    } else if (phosphorus >= 30 && phosphorus <= 49) {
      setState(() {
        interpretationPhosphorus = 'Phosphorus is at a low level';
        recommendationPhosphorus = 'Consider turning on the irrigation system';
      });
    } else if (phosphorus >= 0 && phosphorus <= 29) {
      setState(() {
        interpretationPhosphorus = 'Phosphorus level is critical';
        recommendationPhosphorus = 'Turn on irrigation system ';
      });
    }
  }

  getInterpretationPotassium() {
    if (potassium >= 80 && potassium <= 100) {
      setState(() {
        interpretationPotassium = 'Potassium is at an excellent level';
        recommendationPotassium = 'No recommendation';
      });
    } else if (potassium >= 60 && potassium <= 79) {
      setState(() {
        interpretationPotassium = 'Potassium is at a very good level';
        recommendationPotassium = 'No recommendation';
      });
    } else if (potassium >= 50 && potassium <= 59) {
      setState(() {
        interpretationPotassium = 'Potassium is at an average level';
        recommendationPotassium = 'No recommendation';
      });
    } else if (potassium >= 30 && potassium <= 49) {
      setState(() {
        interpretationPotassium = 'Potassium is at a low level';
        recommendationPotassium = 'Consider turning on the irrigation system';
      });
    } else if (potassium >= 0 && potassium <= 29) {
      setState(() {
        interpretationPotassium = 'Potassium level is critical';
        recommendationPotassium = 'Turn on irrigation system ';
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
                  'N : P : K',
                  style: kHeaderTextStyle,
                ),
                SizedBox(height: 40.0),

                Column(
                  children: [
                    // nitrogen
                    SensorDetails(
                      toggleResults: seeResultsNitrogen,
                      resourceValue: nitrogen,
                      resourceText: 'Nitrogen',
                      interpretationText: interpretationNitrogen,
                      recommendationText: recommendationNitrogen,
                      onPressed: () {
                        setState(() {
                          getInterpretationNitrogen();
                          seeResultsNitrogen = !seeResultsNitrogen;
                        });
                      },
                    ),

                    //phosphorus
                    SensorDetails(
                      toggleResults: seeResultsPhosphorus,
                      resourceValue: phosphorus,
                      resourceText: 'Phosphorus',
                      interpretationText: interpretationPhosphorus,
                      recommendationText: recommendationPhosphorus,
                      onPressed: () {
                        setState(() {
                          getInterpretationPhosphorus();
                          seeResultsPhosphorus = !seeResultsPhosphorus;
                        });
                      },
                    ),

                    // potassium
                    SensorDetails(
                      toggleResults: seeResultsPotassium,
                      resourceValue: potassium,
                      resourceText: 'Potassium',
                      interpretationText: interpretationPotassium,
                      recommendationText: recommendationPotassium,
                      onPressed: () {
                        setState(() {
                          getInterpretationPotassium();
                          seeResultsPotassium = !seeResultsPotassium;
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
