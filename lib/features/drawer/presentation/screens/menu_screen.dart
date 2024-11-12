import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/localization_service.dart';
import 'package:maqam_v2/features/auth/presentation/view/login_screen.dart';
import 'package:maqam_v2/features/drawer/presentation/controller/drawer_cubit.dart';
import 'dart:math' as math;
import '../../../../../config/routes.dart';
import '../../../../../core/widgets/drawer_item.dart';
import '../../../../core/utils/colors.dart';
import '../../../../di_container.dart';
import '../../../auth/presentation/controllers/auth_cubit.dart';
import '../../../auth/presentation/controllers/auth_state.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    final bool user = cubit.userChecker();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: localeService.isArabic ? math.pi / 2 : math.pi,
              child: Image.asset("assets/images/img3.png"),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 40,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/logo.png",
              color: Colors.green.shade800,
              height: 100,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 75,
              ),
              DrawerItem(
                title: 'Home'.tr,
                icon: Icons.home,
                index: 0,
              ),
              const SizedBox(
                height: 10,
              ),
              DrawerItem(
                title: AppStrings.search.tr,
                icon: Icons.search,
                index: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (user == true) {
                    return DrawerItem(
                      title: 'Cart'.tr,
                      icon: Icons.shopping_cart,
                      index: 2,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  "Unauthorized".tr,
                                  style: AppFontStyle.black_18,
                                ),
                                content: Text(
                                  "please login to access the cart".tr,
                                  style: AppFontStyle.black_12,
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'.tr),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Get.offAllNamed(AppRoutes.loginScreen);
                                      if (AuthCubit.get(context)
                                          .userChecker()) {
                                        sl<FirebaseAuth>()
                                            .currentUser
                                            ?.delete();
                                      }
                                    },
                                    child: Text('Login'.tr),
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  }
                  return DrawerItem(
                    title: 'Cart'.tr,
                    icon: Icons.shopping_cart,
                    index: 2,
                  );
                },
              ),
              const SizedBox(height: 10),
              DrawerItem(
                  title: AppStrings.settings.tr,
                  icon: Icons.settings,
                  index: 3),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (user == false) {
                    return DrawerItem(
                      title: 'Logout'.tr,
                      icon: Icons.logout,
                      index: 4,
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        DrawerCubit.get(context).currentIndex = 0;
                        Get.offAll(() => const LoginScreen());
                      },
                    );
                  } else {
                    return DrawerItem(
                      title: 'Login'.tr,
                      icon: Icons.login_outlined,
                      index: 4,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.loginScreen);
                        sl<FirebaseAuth>().currentUser?.delete();
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
