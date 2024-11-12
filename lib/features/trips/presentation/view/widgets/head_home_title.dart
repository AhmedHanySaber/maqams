import 'package:flutter/material.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import '../../../../../core/utils/colors.dart';

class HeadHomeTitle extends StatelessWidget {
  final String title;
  const HeadHomeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFontStyle.primaryBold_22
    );
  }
}
