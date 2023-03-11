// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/carousel.dart';
import 'package:FarmIOT/components/soil_conditions.dart';
import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';

class Cassava extends StatefulWidget {
  const Cassava({super.key});

  @override
  State<Cassava> createState() => _CassavaState();
}

class _CassavaState extends State<Cassava> {
  List images = [
    'Cassava.jpg',
    'Cassava2.jpg',
    'Cassava3.jpg',
    'Cassava4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // soil conditions list
    List<SoilCondition> soilConditions = [
      SoilCondition(resource: 'Soil Moisture', percentText: '30.4'),
      SoilCondition(resource: 'Temperature', percentText: '30.4'),
      SoilCondition(resource: 'Humidity', percentText: '30.4'),
      SoilCondition(resource: 'Nitrogen', percentText: '30.4'),
      SoilCondition(resource: 'Phosphorus', percentText: '30.4'),
      SoilCondition(resource: 'Potassium', percentText: '30.4'),
    ];

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding.copyWith(top: 30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Back(),
                SizedBox(height: 30.0),
                Text(
                  'Cassava Details and Info',
                  style: kOtherTextStyle,
                ),
                SizedBox(height: 30.0),

                // carousel
                Carousel(imagesList: images),
                SizedBox(height: 25.0),

                Divider(
                  thickness: 0.75,
                  color: kTextFieldContainerBorderColor,
                ),
                SizedBox(height: 20.0),

                Text(
                  'Soil Requirements to Plant Cassava',
                  style: kOtherTextStyle,
                ),
                SizedBox(height: 20.0),

                Text(
                  'Current Soil Conditions',
                  style: kOtherTextStyle.copyWith(color: kInfoColor),
                ),
                SizedBox(height: 25.0),

                // soil conditions widgets
                Center(
                  child: Wrap(
                    spacing: MediaQuery.of(context).size.width * 0.225,
                    runSpacing: 20.0,
                    children: soilConditions.map((condition) {
                      return SoilCondition(
                        resource: condition.resource,
                        percentText: condition.percentText,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






// BACKUP IN CASE GRID DOESN'T WORK
// Column(
//                   children: [
//                     Text(
//                       'Soil Moisture',
//                       style: kNormalTextStyle.copyWith(
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10.0),
//                     PercentIndicator(
//                       percent: 0.345,
//                       percentText: '34.5%',
//                     ),
//                   ],
//                 ),


// Column(
//                       children: [
//                         Text(
//                           'Soil Moisture',
//                           style: kNormalTextStyle.copyWith(
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 10.0),
//                         PercentIndicator(
//                           percent: 0.345,
//                           percentText: '34.5%',
//                         ),
//                       ],
//                     );
