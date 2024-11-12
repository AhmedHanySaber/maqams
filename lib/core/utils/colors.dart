// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants.dart';

class AppColors {
  static Color primaryColor = HexColor('#059843'); // Green
  static Color blendedColor = HexColor('#82CCAA'); // Blended color between green and white
  static Color primaryColor1 = HexColor('#059843').withOpacity(.8);
  static Color primaryColor4 = HexColor('#059843').withOpacity(.1);
  static Color primaryColor3 = HexColor('#059843').withOpacity(.3);
  static Color primaryColor2 = HexColor('#059843').withOpacity(.5);
  static const Color primaryColor5 = Color(0xFFc5c6c7);
  static const Color primaryColorSALEK1 = Color.fromRGBO(123	,124,	127	,1); // Dark blue
  static const Color primaryColorSALEK2 = Color.fromRGBO(0	,0,	0,1	);
  static const Color secondaryColor = Color(0xFF365486); // Blue
  static const Color lightColor = Color(0xFF7FC7D9); // Light blue
  static const Color lightColor2 = Color(0xff13828E); // Light blue
  static const Color deepOrange = primaryColorSALEK2; // Light blue
  static const Color black = Color(0xFF000000);
  static const Color grayC4 = Color(0xFFC4C4C4);
  static const Color white = Color(0xFFFFFFFF);
  static LinearGradient gradient = LinearGradient(
    colors: [AppColors.white, AppColors.primaryColor1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// class Background extends StatelessWidget {
//   const Background({super.key, required this.child});
//
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF365486), Color(0xFF0F1035)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: child,
//     );
//   }
// }

// Color color1 = Color(0xFF7FC7D9);
// Color color2 = Color(0xFF365486);
// Color color3 = Color(0xFF0F1035);

// int averageRed = ((color1.red + color2.red + color3.red) ~/ 3).toInt();
// int averageGreen = ((color1.green + color2.green + color3.green) ~/ 3).toInt();
// int averageBlue = ((color1.blue + color2.blue + color3.blue) ~/ 3).toInt();

// Color averagedColor = Color.fromRGBO(averageRed, averageGreen, averageBlue, 1);
