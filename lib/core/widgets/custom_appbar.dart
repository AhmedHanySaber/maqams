import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.isRoot,
    this.widget,
  });

  final String title;
  final bool isRoot;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isRoot
          ? IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
            )
          : null,
      backgroundColor: Colors.transparent,
      title: Text(
        title.tr,
        style: AppFontStyle.primaryBold_24,
      ),
      actions: [widget ?? const SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
