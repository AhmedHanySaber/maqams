import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../location/presentation/view/location_app_bar.dart';
import '../../../data/models/module_model.dart';

class FeaturedModuleContainer extends StatelessWidget {
  final ModuleModel moduleModel;

  const FeaturedModuleContainer({super.key, required this.moduleModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor1.withOpacity(.2),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12.w),
          bottomLeft: Radius.circular(12.w),
        ),
      ),
      child: Stack(
        children: [
          const PositionedDirectional(
            top: 0,
            end: 0,
            start: 0,
            child: LocationAppBar(),
          ),
          PositionedDirectional(
            start: -40.w,
            bottom: -40.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                shimmerHighlightColor: AppColors.primaryColor.withOpacity(.6),
                shimmerBaseColor: AppColors.primaryColor.withOpacity(.2),
                imageUrl: moduleModel.imageUrl,
                errorWidget: Image.asset('assets/images/error.png'),
                height: 160,
                width: 160,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerFeaturedModuleContainer extends StatelessWidget {
  const ShimmerFeaturedModuleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
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
