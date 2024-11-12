import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/features/cart/presentation/view/screen.dart';
import 'package:maqam_v2/features/search/presentation/view/search_screen.dart';
import '../../../../config/network.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/localization_service.dart';
import '../../../settings/presentation/settings_screen.dart';
import '../../../trips/presentation/view/screens/home_screen.dart';
import '../controller/drawer_cubit.dart';
import '../controller/drawer_state.dart';
import 'menu_screen.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  DateTime? currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkInfo.checkConnectivity(context);
  }

  bool onPop() {
    var index = DrawerCubit.get(context).currentIndex;
    if (index != 0) {
      DrawerCubit.get(context).changeTab(0);
      return false;
    } else {
      return true;
      // DateTime date = DateTime.now();
      // if (currentBackPressTime == null ||
      //     date.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      //   currentBackPressTime = date;
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: AppColors.primaryColor,
      //       behavior: SnackBarBehavior.floating,
      //       content: Text(AppStrings.exit),
      //       duration: const Duration(seconds: 1),
      //     ),
      //   );
      //   return false;
      // } else {
      //   return true;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrawerCubit, DrawerPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          var index = DrawerCubit.get(context).currentIndex;
          return WillPopScope(
            onWillPop: () async => onPop(),
            child: ZoomDrawer(
              isRtl: localeService.isArabic ? true : false,
              duration: const Duration(milliseconds: 250),
              controller: AppColor2.zoomDrawerController,
              style: DrawerStyle.style3,
              menuScreen: const MenuScreen(),
              mainScreen: [
                const HomeScreen(),
                const SearchScreen(),
                const CartScreen(),
                const SettingsScreen()
              ][index],
              mainScreenTapClose: false,
              borderRadius: 70.0,
              showShadow: true,
              angle: 0,
              menuBackgroundColor: AppColors.primaryColor,
              slideWidth: MediaQuery.of(context).size.width * 0.75,
            ),
          );
        });
  }
}
