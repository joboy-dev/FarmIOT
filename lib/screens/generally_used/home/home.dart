// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, must_call_super, unused_field, prefer_final_fields, use_build_context_synchronously

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/models/sensors.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FarmIOT/components/bottom_sheet.dart';
import 'package:FarmIOT/components/dialog_box.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/generally_used/profile/notifications.dart';
import 'package:FarmIOT/screens/generally_used/sensor_screens/npk.dart';
import 'package:FarmIOT/screens/generally_used/sensor_screens/soil_moisture.dart';
import 'package:FarmIOT/screens/generally_used/sensor_screens/temp_humidity.dart';
import 'package:FarmIOT/screens/scrollable_sheet/logout.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const id = 'home';
  static Home home = Home();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // switch for irrigation system toggle button
  bool _switchValue = false;

  // switch for button to grant users access to the sensors in the IoT sysytem
  bool _isConnected = false;

  bool _isLoading = false;

  List<PopupMenuItem> dropDownItems = [
    PopupMenuItem(
      value: 'Refresh',
      child: Row(
        children: [
          Icon(
            Icons.refresh_rounded,
            color: kTextColor,
          ),
          SizedBox(width: 10.0),
          Text(
            'Refresh',
            style: kNormalTextStyle,
          ),
        ],
      ),
    ),
    PopupMenuItem(
      value: 'Logout',
      child: Row(
        children: [
          Icon(
            Icons.logout_rounded,
            color: kTextColor,
          ),
          SizedBox(width: 10.0),
          Text(
            'Log out',
            style: kNormalTextStyle,
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get current user data. from here you can access all the data in the firestore
    // document
    final userData = Provider.of<UserData?>(context);

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: userData == null
          ? Center(child: Loader())
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: kAppPadding.copyWith(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TOP BAR
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Welcome, ${userData.firstName}',
                              style: kOtherTextStyle.copyWith(
                                color: kInfoColor,
                                fontSize: 19.0,
                              ),
                              maxLines: 2,
                            ),
                          ),

                          // Notifications
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Notifications.id);
                              },
                              iconSize: kIconSize25,
                              color: kTextColor,
                              splashRadius: 30.0,
                              splashColor: kTextColor.withOpacity(0.2),
                              icon: Icon(FontAwesomeIcons.bell),
                            ),
                          ),

                          // Drop Down Menu
                          // NOTE TO SELF: Don't forget to make it work
                          Expanded(
                            flex: 0,
                            child: PopupMenuButton(
                              itemBuilder: (context) {
                                return dropDownItems;
                              },
                              onSelected: (value) {
                                if (value == 'Logout') {
                                  showSheet(screen: LogOut(), context: context);
                                }
                              },
                              position: PopupMenuPosition.under,
                              padding: kAppPadding,
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: kTextColor,
                              ),
                              iconSize: kIconSize25,
                              color: kBottomSheetBackgroundColor,
                              splashRadius: 30.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),

                      // Body
                      Column(
                        children: [
                          // return Database(uid: user?.uid)
                          //           .updateSensorDataOnConnection();

                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Icon(
                                  Icons.sensors_rounded,
                                  color: kTextFieldContainerBorderColor,
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Sensors',
                                  style: kOtherTextStyle,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String message = '';

                                    // get current user
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    String userId = auth.currentUser!.uid;

                                    // call function to toggle connection to sensors status

                                    // Note that I used userData.connected as the
                                    // argument to pass in the function named
                                    // parameter. I did this because userData is
                                    // connected to a Provider drawing data from
                                    // a UserData stream. This is the only way to
                                    // maintain the state of the page even when
                                    // you leave that page and come back

                                    if (userData.connected == false) {
                                      dynamic result =
                                          await Database(uid: userId)
                                              .updateSensorDataOnConnection();

                                      print(result);
                                    }

                                    await Database(uid: userId)
                                        .toggleConnection(
                                      connected: userData.connected,
                                    );

                                    setState(() {
                                      userData.connected = !userData.connected;
                                      message = userData.connected
                                          ? 'Connected to sensors.'
                                          : 'Disconnected from sensors.';
                                    });
                                    displaySnackBar(context, message);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // NOTE: set a colour for 'connecting...'
                                    backgroundColor: userData.connected
                                        ? kTextFieldContainerBorderColor
                                        : kRedColor.withOpacity(0.65),
                                  ),
                                  child: Text(
                                    userData.connected
                                        // ? (_switchValue
                                        //     ? 'Connected'
                                        //     : 'Connecting...')
                                        // : 'Connect',
                                        ? 'Connected'
                                        : 'Disconnected',
                                    style: kNormalTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 30.0),

                          // Sensors
                          // Soil Moisture Sensor
                          GestureDetector(
                            onTap: () {
                              // check if user is connected to the sensors before
                              // taking them to the appropriate page

                              userData.connected
                                  ? Navigator.pushNamed(
                                      context, SoilMoisture.id)
                                  : displaySnackBar(context,
                                      'You need to connect to the sensors to have access to this page');
                            },
                            child: Sensors(
                              icon: FontAwesomeIcons.glassWaterDroplet,
                              text: 'Soil Moisture',
                            ),
                          ),
                          SizedBox(height: 20.0),

                          // Temperature and Humidity Sensor
                          GestureDetector(
                            onTap: () {
                              // check if user is connected to the sensors before
                              // taking them to the appropriate page

                              userData.connected
                                  ? Navigator.pushNamed(
                                      context, TempHumidity.id)
                                  : displaySnackBar(context,
                                      'You need to connect to the sensors to have access to this page');
                            },
                            child: Sensors(
                              icon: FontAwesomeIcons.temperatureHalf,
                              text: 'Temperature and Humidity',
                            ),
                          ),
                          SizedBox(height: 20.0),

                          // NPK Sensor
                          GestureDetector(
                            onTap: () {
                              // check if user is connected to the sensors before
                              // taking them to the appropriate page

                              userData.connected
                                  ? Navigator.pushNamed(context, Npk.id)
                                  : displaySnackBar(context,
                                      'You need to connect to the sensors to have access to this page');
                            },
                            child: Sensors(
                              icon: FontAwesomeIcons.seedling,
                              text: 'N : P : K',
                            ),
                          ),
                          SizedBox(height: 50.0),

                          // Irrigation System
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.water,
                                      color: kTextFieldContainerBorderColor,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      'Irrigation System',
                                      style: kOtherTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              // Info Button
                              Expanded(
                                flex: 0,
                                child: IconButton(
                                  onPressed: () {
                                    // Show Dialog Box
                                    showDialogBox(
                                      dialogText:
                                          'You can turn on the irrigation system by switching the toggle button or it can be activated automatically when the soil moisture is low.',
                                      context: context,
                                    );
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.circleInfo,
                                  ),
                                  color: kInfoColor,
                                  iconSize: kIconSizeSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    _switchValue
                                        ? 'Turn off the Irrigation System'
                                        : 'Turn on the Irrigation System',
                                    style: kNormalTextStyle.copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.0),
                              Expanded(
                                flex: 0,
                                child: Switch(
                                  value: _switchValue,
                                  onChanged: (value) {
                                    // check if user is connected to the sensors before
                                    // turning on the irrigation system

                                    if (userData.connected) {
                                      // Turn on irrigation system
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    } else {
                                      // set value to false so the user won't be
                                      // able to switch the toggle button
                                      setState(() {
                                        value = false;
                                      });

                                      // show a dialog box prompting the user on
                                      // what to do
                                      displaySnackBar(context,
                                          'You need to connect to the sensors to have access to the irrigation system');
                                    }
                                  },
                                  activeColor: kTextFieldContainerBorderColor,
                                  activeTrackColor: kTextColor,
                                  inactiveThumbColor: kTextColor,
                                  inactiveTrackColor:
                                      kTextFieldContainerBorderColor,
                                  splashRadius: 30.0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class Sensors extends StatelessWidget {
  Sensors({
    required this.icon,
    required this.text,
  });

  IconData icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: kBottomSheetBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: kAppPadding,
        child: Row(
          children: [
            Icon(
              icon,
              color: kTextColor,
            ),
            SizedBox(width: 30.0),
            Text(
              text,
              style: kNormalTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
