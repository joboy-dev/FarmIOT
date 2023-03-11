// ignore_for_file: prefer_const_constructors

import 'package:FarmIOT/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 25.0,
      color: kInfoColor,
    );
  }
}
