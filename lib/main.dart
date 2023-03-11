// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_print

import 'package:FarmIOT/backend/auth.dart';
import 'package:FarmIOT/backend/cloud_messaging.dart';
import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/models/sensors.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/crop_screens/cassava.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/crop_screens/cocoa.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/crop_screens/corn.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/my_crops.dart';
import 'package:FarmIOT/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/components/bottom_navbar.dart';
import 'package:FarmIOT/screens/auth_screens/login.dart';
import 'package:FarmIOT/screens/auth_screens/sign_up.dart';
import 'package:FarmIOT/screens/generally_used/home/home.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/add_crops.dart';
import 'package:FarmIOT/screens/generally_used/profile/notifications.dart';
import 'package:FarmIOT/screens/generally_used/sensor_screens/npk.dart';
import 'package:FarmIOT/screens/generally_used/sensor_screens/soil_moisture.dart';
import 'package:FarmIOT/screens/generally_used/sensor_screens/temp_humidity.dart';
import 'package:FarmIOT/screens/onboarding/get_started.dart';
import 'package:FarmIOT/screens/onboarding/onboarding_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await CloudMessaging().pushNotification();

  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId = auth.currentUser?.uid;

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        StreamProvider<UserData?>.value(
          value: Database(uid: userId).userData,
          // catchError: (context, error) {
          //   print(error);
          //   print(context);
          //   return null;
          // },
          initialData: null,
          // initialData: UserData(uid: '', firstName: '', lastName: '', email: '', profilePic: '', crops: [], connected: false,),
        ),
        StreamProvider<SensorData>.value(
          value: Database(uid: userId).sensorData,
          // initialData: null,
          initialData: SensorData(
            soilMoisture: 0.0,
            temperature: 0.0,
            humidity: 0.0,
            nitrogen: 0.0,
            phosphorus: 0.0,
            potassium: 0.0,
            userId: '',
          ),
        )
      ],
      child: FarmIOT(),
    ),
  );
}

class FarmIOT extends StatelessWidget {
  const FarmIOT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // wrap material app with a stream provider to get auth state changes
    // create stream start point
    return MaterialApp(
      title: 'Farm I⚙️T',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.android,
        backgroundColor: kAppBackgroundColor,
      ),
      initialRoute: OnboardingScreen.id,
      routes: {
        OnboardingScreen.id: (context) => OnboardingScreen(),
        GetStarted.id: (context) => GetStarted(),
        Wrapper.id: (context) => Wrapper(),
        SignUp.id: (context) => SignUp(),
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
        MyCrops.id: (context) => MyCrops(),
        BottomNavBar.id: (context) => BottomNavBar(),
        Notifications.id: (context) => Notifications(),
        AddCrops.id: (context) => AddCrops(),
        SoilMoisture.id: (context) => SoilMoisture(),
        TempHumidity.id: (context) => TempHumidity(),
        Npk.id: (context) => Npk(),

        /* 
        
        IMPORTANT
        I used string here instead of the usual because I want to navigate
        to th approproate page based on user selection since I am looping
        through a list in MyCrops() page of strings with the same names
        as the names here so as to avois issues

        */
        'Corn': (context) => Corn(),
        'Cassava': (context) => Cassava(),
        'Cocoa': (context) => Cocoa(),
      },
    );
  }
}
