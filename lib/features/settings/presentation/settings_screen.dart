import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/features/auth/presentation/view/login_screen.dart';
import 'package:maqam_v2/features/drawer/presentation/controller/drawer_cubit.dart';
import 'package:maqam_v2/features/settings/presentation/profile_screen.dart';
import 'package:maqam_v2/features/settings/presentation/widgets/setting_item_widget.dart';
import '../../../core/constants.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/const.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/select_language_dialog.dart';
import '../../../di_container.dart';
import '../../privacy/presentation/view/privacy_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: AppStrings.settings.tr, isRoot: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsItem(
                    onTap: () {
                      Get.to(() => const ProfileScreen());
                    },
                    icon: Icons.person,
                    title: 'Profile'.tr),
                const SizedBox(height: Constants.spaceLarge),
                SettingsItem(
                    onTap: () {
                      Get.to(() => const PrivacyPolicyScreen());
                    },
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy'.tr),
                const SizedBox(height: Constants.spaceLarge),
                SettingsItem(
                    onTap: () {
                      Get.to(() => const WhoAreWeScreen());
                    },
                    icon: Icons.info_outline,
                    title: 'Who Are We'.tr),
                const SizedBox(height: Constants.spaceLarge),
                SettingsItem(
                    onTap: () async {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return const SelectLanguageDialog();
                          });
                    },
                    icon: Icons.language,
                    title: 'Language'.tr),
                const SizedBox(height: Constants.spaceLarge),
                SettingsItem(
                    onTap: () async {
                      await sl<FirebaseAuth>().signOut();
                      DrawerCubit.get(context).currentIndex = 0;
                      Get.offAll(() => const LoginScreen());
                    },
                    icon: Icons.logout,
                    title: 'Logout'.tr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
