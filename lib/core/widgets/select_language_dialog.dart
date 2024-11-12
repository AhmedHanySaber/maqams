import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import '../../core/enums/language.dart';
import '../../core/utils/localization_service.dart';
import '../utils/colors.dart';

final selectLanguageProvider = StateProvider.autoDispose<Language>((ref) {
  return localeService.getLocale();
});

class SelectLanguageDialog extends ConsumerWidget {
  const SelectLanguageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final currentLang = ref.read(selectLanguageProvider);
    return Container(
      height: 200.h,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
            initialItem: currentLang.index,
          ),
          itemExtent: 60,
          onSelectedItemChanged: (value) {
            localeService.changeLocale(Language.values
                .firstWhere((element) => element.index == value));
          },
          children: Language.values
              .map((e) => Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      e.name.tr,
                      style: AppFontStyle.black_14,
                    ),
                  ))
              .toList()),
    );
  }
}
