import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import '../../../../core/utils/colors.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primaryColor4,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: AppColors.primaryColor),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.green.withOpacity(0.5),
            //     spreadRadius: 0.5,
            //   )
            // ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: color ?? AppColors.primaryColor,
              ),
              Gap(20.w),
              Text(title,style: AppFontStyle.black_14,),
            ],
          )),
    );
  }
}
