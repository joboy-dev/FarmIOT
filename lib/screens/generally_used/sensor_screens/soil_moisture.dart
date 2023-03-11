// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/sensor_data_container.dart';
import 'package:FarmIOT/components/sensor_details.dart';
import 'package:FarmIOT/models/sensors.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/constants.dart';
import 'package:provider/provider.dart';

class SoilMoisture extends StatefulWidget {
  SoilMoisture({Key? key}) : super(key: key);

  static const id = 'soil_moisture';

  @override
  State<SoilMoisture> createState() => _SoilMoistureState();
}

class _SoilMoistureState extends State<SoilMoisture> {
  @override
  Widget build(BuildContext context) {
    // get current user
    final user = Provider.of<UserModel?>(context);

    // get sensor data
    final sensorData = Provider.of<SensorData>(context);

    double soilMoisture = sensorData.soilMoisture;
    String interpretationMoisture = '';
    String recommendationMoisture = '';

    bool seeResultsMoisture = false;

    getInterpretationMoisture() {
      if (soilMoisture >= 80 && soilMoisture <= 100) {
        setState(() {
          interpretationMoisture = 'Soil Moisture is at an excellent level';
          recommendationMoisture = 'No recommendation';
        });
      } else if (soilMoisture >= 60 && soilMoisture <= 79) {
        setState(() {
          interpretationMoisture = 'Soil Moisture is at a very good level';
          recommendationMoisture = 'No recommendation';
        });
      } else if (soilMoisture >= 50 && soilMoisture <= 59) {
        setState(() {
          interpretationMoisture = 'Soil moisture is at an average level';
          recommendationMoisture = 'No recommendation';
        });
      } else if (soilMoisture >= 30 && soilMoisture <= 49) {
        setState(() {
          interpretationMoisture = 'Soil Moisture is low';
          recommendationMoisture = 'Consider turning on the irrigation system';
        });
      } else if (soilMoisture >= 0 && soilMoisture <= 29) {
        setState(() {
          interpretationMoisture = 'Soil Moisture is critical';
          recommendationMoisture = 'Turn on irrigation system ';
        });
      }
    }

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
                  'Soil Moisture',
                  style: kHeaderTextStyle,
                ),
                SizedBox(height: 40.0),

                Column(
                  children: [
                    // container for sensor data
                    SensorDetails(
                      toggleResults: seeResultsMoisture,
                      resourceValue: soilMoisture,
                      resourceText: 'Soil Moisture',
                      interpretationText: interpretationMoisture,
                      recommendationText: recommendationMoisture,
                      onPressed: () async {
                        setState(() {
                          // dynamic result = Database(uid: user!.uid)
                          //     .updateSensorDataOnConnection();
                          // print(result);

                          getInterpretationMoisture();
                          seeResultsMoisture = !seeResultsMoisture;
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
