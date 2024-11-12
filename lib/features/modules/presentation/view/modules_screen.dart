import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import 'package:maqam_v2/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:maqam_v2/features/modules/presentation/mangers/modules_cubit.dart';
import 'package:maqam_v2/features/modules/presentation/mangers/modules_state.dart';
import 'package:maqam_v2/features/modules/presentation/view/widgets/featured_module_container.dart';
import 'package:maqam_v2/features/modules/presentation/view/widgets/modules_wrapper.dart';
import '../../../../di_container.dart';
import 'dart:math' as math;

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ModulesCubit>()..getModules(),
      child: Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  FutureBuilder(
                      future: sl<ModulesCubit>().getFeaturedModule(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ShimmerFeaturedModuleContainer();
                        } else if (snapshot.hasData) {
                          return snapshot.data!.fold((l) {
                            return const SizedBox();
                          }, (r) {
                            return FeaturedModuleContainer(moduleModel: r);
                          });
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                  // BlocConsumer<ModulesCubit, ModulesState>(
                  //   listener: (context, state) {
                  //     if (state is ModulesSuccess) {
                  //       if (state.modules.length == 1) {
                  //         Get.to(() => const DrawerPage());
                  //       }
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     final cubit = sl<ModulesCubit>().getFeaturedModule();
                  //   },
                  // ),
                  Gap(10.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: BlocConsumer<ModulesCubit, ModulesState>(
                      listener: (context, state) {
                        if (state is ModulesSuccess) {
                          if (state.modules.length == 1) {
                            Get.to(() => const DrawerPage());
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is ModulesLoading) {
                          return const ModulesShimmerWrap();
                        } else if (state is ModulesSuccess) {
                          return ModulesWrap(modules: state.modules);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Transform.rotate(
                angle: math.pi,
                child: Image.asset(
                  "assets/images/img3.png",
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Maqam Travels".tr,
                        style: AppFontStyle.primaryBold_18,
                      ),
                      Text(
                        AppStrings.copyRights.tr,
                        style: AppFontStyle.primary_12,
                      ),
                      Text(
                        AppStrings.appVersion,
                        style: AppFontStyle.primary_12,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
