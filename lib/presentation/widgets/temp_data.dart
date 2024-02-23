// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

List<Widget> bannerImages = [
  AspectRatio(
    aspectRatio: 1.6 / 1,
    child: Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/shopzo-banner.jpg'
              )),
    )),
  ),
  AspectRatio(
    aspectRatio: 1.6 / 1,
    child: Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/banner2.jpg'
              )),
    )),
  ),
  AspectRatio(
    aspectRatio: 1.6 / 1,
    child: Container(
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/banner3.jpg'
              )),
    )),
  ),
];


const String img1 =
    'assets/images/gridimage1.jpeg';
const img2 =
    'assets/images/gridimage2.jpeg';
const img3 =
    'assets/images/gridimage3.jpeg';
const img4 =
    'assets/images/gridimage4.jpeg';
