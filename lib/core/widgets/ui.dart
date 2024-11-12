import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

abstract class UIHelper {
  UIHelper._();

  static Future<void> copy(String text, BuildContext context, {String? key}) {
    return Clipboard.setData(ClipboardData(text: text)).then((value) {
      showSnackBar('Copied'.tr + (key == null ? '' : ' [ $key ]'), context);
    });
  }

  static void showSnackBar(String text, BuildContext context,
      {Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        content: Text(
          text,
          style: TextStyle(color: textColor),
        )));
  }

  static SystemUiOverlayStyle getSystemOverlayStyle([bool? isDark]) {
    final darkMode = isDark ?? Get.isDarkMode;

    if (kIsWeb) {
      final brightness = darkMode ? Brightness.dark : Brightness.light;
      return SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        statusBarColor: Colors.transparent,
      );
    }

    SystemUiOverlayStyle? overlay;

    if (Platform.isAndroid) {
      final brightness = !darkMode ? Brightness.dark : Brightness.light;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      overlay = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarIconBrightness: brightness,
      );
    } else {
      final brightness = darkMode ? Brightness.dark : Brightness.light;
      overlay = SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        statusBarColor: Colors.transparent,
      );
    }
    return overlay;
  }

  static SliverGridDelegateWithFixedCrossAxisCount
      getResponsiveSliverGridDelegate(BuildContext context) {
    final shortestSize = context.mediaQuerySize.shortestSide;
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: shortestSize < 300 ? 1 : max(context.width ~/ 385 + 1, 2),
      crossAxisSpacing: 11.w,
      mainAxisSpacing: 11.h,
      childAspectRatio: 1.1843971631,
    );
  }

  static SnackbarController showGlobalSnackBar({
    String? title,
    String? text,
    Color color = Colors.grey,
    void Function(GetSnackBar)? onTap,
  }) {
    return Get.showSnackbar(
      GetSnackBar(
        messageText: text != null
            ? Text(
                text,
                style: const TextStyle(),
              )
            : null,
        titleText: title != null
            ? Text(
                title,
                style: const TextStyle(),
              )
            : null,
        snackPosition: SnackPosition.TOP,
        borderRadius: 15,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        duration: const Duration(seconds: 3),
        barBlur: 7.0,
        backgroundColor: color.withOpacity(0.7),
        dismissDirection: DismissDirection.vertical,
        onTap: onTap,
      ),
    );
  }

  static Size getTextSize(BuildContext context, String text, TextStyle style,
      {int? maxLines = 1, TextDirection? textDirection = TextDirection.ltr}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: maxLines,
      textScaler: MediaQuery.textScalerOf(context),
      textDirection: textDirection,
    )..layout();
    return textPainter.size;
  }

  static showDateTimePickerHelper(
    BuildContext context, {
    String? date,
    required ValueChanged<String> onSelectedDateTime,
  }) {
    showDatePicker(
      locale: const Locale('ar'),
      textDirection: TextDirection.rtl,
      currentDate: DateTime.now(),
      initialDate: date == null
          ? DateTime.now()
          : intl.DateFormat('y-MM-dd', 'en').parse(date),
      firstDate: DateTime.now().subtract(const Duration(
        days: 365 * 100,
      )),
      lastDate: DateTime.now(),
      context: context,
    ).then((value) {
      if (value != null) {
        onSelectedDateTime(intl.DateFormat('y-MM-dd', 'en').format(value));
      }
    });
  }
}
