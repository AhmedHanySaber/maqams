import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import 'package:maqam_v2/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import 'package:shimmer/shimmer.dart';

class ModuleContainer extends StatelessWidget {
  final ModuleModel moduleModel;

  const ModuleContainer({super.key, required this.moduleModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ()=> Get.to(()=>const DrawerPage()),
          child: Container(
            height: 100.w,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.3),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FancyShimmerImage(
                shimmerHighlightColor: AppColors.primaryColor.withOpacity(.6),
                shimmerBaseColor: AppColors.primaryColor.withOpacity(.2),
                imageUrl: moduleModel.imageUrl,
                errorWidget: Image.asset('assets/images/error.png'),
                height: 60.w,
                width: 60.w,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Gap(6.h),
        Text(moduleModel.name,style: AppFontStyle.black_14,)
      ],
    );
  }
}

class ModuleShimmerContainer extends StatelessWidget {
  const ModuleShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.3),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.green.shade300,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
