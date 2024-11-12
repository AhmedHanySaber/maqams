import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

class AppColor2 {
  // static var Green = HexColor('#059843');
  // static var yellow = HexColor('#E1D800');
  // static var gray = HexColor('#F7F7F7');
  static final ZoomDrawerController zoomDrawerController =
      ZoomDrawerController();
}

class AppStrings {
  AppStrings._();

  static String appName = "Maqam";
  static String appName2 = "Maqam Travels";
  static String copyRights = "@Developed by CodeX Team";
  static String appVersion = "0.2.10";
  static String exit = 'Press back again to exit';
  static String boolNow = "Book Now";
  static String settings = "settings";
  static String alreadyInCart = "Already in cart";
  static String notes = "This pricing is for 1 or 2 persons otherwise the pricing will be on each-one else ";
  static String note = "Note";
  static String seeAll = 'See All';
  static String search = 'Search';
  static String location = "Locations";
  static String popularNow = 'Popular Trips';
  static String recommendedTrips = 'Recommended Trips';
  static String pending = "Pending";
  static String reserved = "Reserved";
  static String unKnownError = "Something went wrong";
  static String noReservations = "There is no reservations until now please Go back to the home screen";
}
