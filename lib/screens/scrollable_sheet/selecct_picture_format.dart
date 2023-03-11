// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:FarmIOT/backend/cloud_storage.dart';
import 'package:FarmIOT/components/button.dart';
import 'package:FarmIOT/components/loader.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';

class SelectImageFormat extends StatefulWidget {
  const SelectImageFormat({super.key});

  @override
  State<SelectImageFormat> createState() => _SelectImageFormatState();
}

class _SelectImageFormatState extends State<SelectImageFormat> {
  // String to store download url for use in firestore
  String imageUrl = '';
  bool _isLoading = false;

  CloudStorage cloudStorage = CloudStorage();
  String message = '';

  // get image from camera
  getImageFromCamera() async {
    setState(() {
      _isLoading = true;
    });

    dynamic result = await cloudStorage.imageFromCamera();

    if (result != null) {
      setState(() {
        _isLoading = false;
        message = 'Successfully updated profile picture';
      });
      Navigator.pop(context);
    } else {
      setState(() {
        _isLoading = false;
        message = 'Something went wrong. Try again.';
      });
    }
    displaySnackBar(context, message);
  }

  // get image from gallery
  getImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    dynamic result = await cloudStorage.imageFromGallery();

    if (result != null) {
      setState(() {
        _isLoading = false;
        message = 'Successfully updated profile picture';
      });
      Navigator.pop(context);
    } else {
      setState(() {
        _isLoading = false;
        message = 'Something went wrong. Try again.';
      });
    }
    displaySnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kAppPadding,
      child: Stack(
        children: [
          Positioned(
            left: 135.0,
            top: 15.0,
            child: Container(
              height: 5.0,
              width: 60.0,
              decoration: BoxDecoration(
                color: kTextFieldContainerBorderColor,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40.0),
              Text(
                'Select how you want to take your picture',
                style: kHeaderTextStyle,
              ),
              SizedBox(height: 40.0),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      buttonText: 'Gallery',
                      onPressed: () {
                        getImageFromGallery();
                      },
                      color: kBrownButton,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Button(
                      buttonText: 'Camera',
                      onPressed: () {
                        getImageFromCamera();
                      },
                      color: kTextFieldContainerBorderColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              _isLoading ? Loader() : SizedBox(height: 0.0),
              SizedBox(height: 15.0),
              _isLoading
                  ? Text(
                      'Please wait while your picture is being updated',
                      style: kNormalTextStyle.copyWith(color: kInfoColor),
                      textAlign: TextAlign.center,
                    )
                  : Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
