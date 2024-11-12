import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import '../../../data/models/module_model.dart';
import 'module_container.dart';

class ModulesWrap extends StatelessWidget {
  final List<ModuleModel> modules;

  const ModulesWrap({super.key, required this.modules});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            ...modules.map((e) => ModuleContainer(moduleModel: e)),
          ],
        ),
        if (modules.length > 6)
          Column(
            children: [
              const Gap(10),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor4,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 4,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(5),
                        Text(
                          "Explore",
                          style: AppFontStyle.primaryBold_18,
                        ),
                        Icon(
                          Icons.navigate_next_outlined,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
      ],
    );
  }
}

class ModulesShimmerWrap extends StatelessWidget {
  const ModulesShimmerWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      spacing: 20.w,
      runSpacing: 10.h,
      children: const [
        ModuleShimmerContainer(),
        ModuleShimmerContainer(),
        ModuleShimmerContainer(),
        ModuleShimmerContainer(),
        ModuleShimmerContainer(),
      ],
    );
  }
}
