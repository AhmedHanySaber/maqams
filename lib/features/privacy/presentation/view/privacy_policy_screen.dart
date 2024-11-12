import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/functions/riverpod.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/localization_service.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import '../../../../core/utils/colors.dart';
import '../mangers/fetch_policy_provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: "Privacy Policy", isRoot: false),
      body: Consumer(
        builder: (context, ref, _) {
          final terms = ref.watch(fetchPolicyProvider);
          return terms.customWhen(
            refreshable: fetchPolicyProvider.future,
            ref: ref,
            data: (termsData) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: HtmlWidget(
                    localeService.isArabic
                        ? termsData.termsAr ?? ""
                        : termsData.termsEn ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: AppColors.primaryColor4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("Ok".tr, style: AppFontStyle.white_18),
          ),
        ),
      ),
    );
  }
}

class WhoAreWeScreen extends StatelessWidget {
  const WhoAreWeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(title: "Who Are We", isRoot: false),
      body: Consumer(
        builder: (context, ref, _) {
          final terms = ref.watch(fetchPolicyProvider);
          return terms.customWhen(
            refreshable: fetchPolicyProvider.future,
            ref: ref,
            data: (termsData) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: HtmlWidget(
                    localeService.isArabic
                        ? termsData.termsAr ?? ""
                        : termsData.termsEn ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: AppColors.primaryColor4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("Ok".tr, style: AppFontStyle.white_18),
          ),
        ),
      ),
    );
  }
}
