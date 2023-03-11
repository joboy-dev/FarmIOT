// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:FarmIOT/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    required this.imagesList,
  });

  final List imagesList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imagesList.length,
      itemBuilder: (context, index, pageIndex) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: kBottomSheetBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 320.0,
          width: double.infinity,
          child: Image(
            image: AssetImage('assets/images/${imagesList[index]}'),
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        height: 320.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        viewportFraction: 0.9,
        enlargeFactor: 0.5,
      ),
    );
  }
}