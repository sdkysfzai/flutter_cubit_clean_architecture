import 'package:flutter/material.dart';

//paddings
const defaultPadding = 16.0;
const defaultPaddingMin = 6.0;

//radius
const defaultCircularRadius = 24.0;
const defaultCircularRadiusMin = 8.0;

//sizes
const defaultFontSize = 18.0;
const defaultFontSizeMin = 16.0;
const defaultFontSizeMin2 = 12.0;

//Colors
const bgColor = Colors.white;
const blueColor = Colors.blue;
const primaryColor = Colors.orange;
const secondaryColor = Colors.white;
const selectedColor = Colors.brown;
const whiteColor = Colors.white;
const blackColor = Colors.black;
const greyColor = Colors.grey;
const darkPurpleColor = Color.fromARGB(214, 96, 23, 149);
const lightBlueColor = Color.fromARGB(147, 25, 181, 254);
const transparentColor = Colors.transparent;


//Page consts
class PageConsts {
  static const String signInPage = 'signInPage';
  static const String signUpPage = 'signUpPage';
  static const String mainScreen = 'mainScreen';
  static const String homePage = 'homePage';
  static const String myTripsPage = 'myTripsPage';
  static const String walletPage = 'walletPage';
  static const String profilePage = 'profilePage';
}

class FirebaseConsts {
  static const String users = 'users';
}


Widget sizeVer(double height) {
  return SizedBox(height: height);
}

Widget sizedHor(double width) {
  return SizedBox(width: width);
}
