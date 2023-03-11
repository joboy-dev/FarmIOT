// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddCrops extends StatefulWidget {
  const AddCrops({super.key});
  static const id = 'add_crops';

  @override
  State<AddCrops> createState() => _AddCropsState();
}

class _AddCropsState extends State<AddCrops> {
  final formKey = GlobalKey<FormState>();

  /*

  IMPORTANT
  This list comes in handy for various things which are: 
    /*
    * Adding data to firestore based on user choice
    * Displaying name of crop on MyCrops() screen
    * Displaying crop picture on MyCrops() screen
    * Navigating from MyCrops() screen  to either of Corn(), Cassava(), or Cocoa()
      screens since I named the route the same name as the items in this list
    */

  */

  final List<String> _cropItems = ['Corn', 'Cocoa', 'Cassava'];

  String? initValue;
  bool _isLoading = false;
  String message = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  validateForm() async {
    // get surrent user
    final user = Provider.of<UserModel?>(context, listen: false);
    String? userId = user?.uid;

    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // invoke function to add crops to database
      dynamic result = await Database(uid: userId).addCrops(initValue!);
      print(result);

      if (result == null) {
        setState(() {
          message = 'Crop already exists in your dashboard';
          _isLoading = false;
        });
      } else {
        setState(() {
          message = result;
          // message = 'Crop has been added to your dashboard';
          _isLoading = false;
        });
        Navigator.pop(context);
      }
      displaySnackBar(context, message);
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),

                  // Header Text
                  Row(
                    children: [
                      Back(),
                      SizedBox(width: 20.0),
                      Text(
                        'Select a crop to add',
                        style: kOtherTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),

                  DropdownButtonFormField(
                    value: initValue,
                    decoration: kTextFieldDecoration.copyWith(
                      prefixIcon: Padding(
                        padding: kAppPadding,
                        child: Icon(
                          FontAwesomeIcons.seedling,
                          size: kIconSize25,
                        ),
                      ),
                      prefixIconColor: kTextFieldContainerBorderColor,
                      hintText: 'Select a crop',
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    dropdownColor: kBottomSheetBackgroundColor,
                    itemHeight: 50.0,
                    elevation: 0,
                    items: _cropItems.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item, style: kNormalTextStyle),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        initValue = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a crop';
                      } else {
                        print(value);
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Button(
                    buttonText: 'Add Crop',
                    onPressed: () {
                      validateForm();
                    },
                    color: kBrownButton,
                  ),
                  SizedBox(height: 20.0),
                  _isLoading ? Loader() : SizedBox(height: 0.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
