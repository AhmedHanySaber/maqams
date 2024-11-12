import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import '../../managers/notifications_filter.dart';

class NotificationsCustomActionChip extends ConsumerWidget {
  const NotificationsCustomActionChip({
    super.key,
    required this.value,
    this.alwaysActive = false,
  });

  final NotificationFilterType value;
  final bool alwaysActive;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected =
        alwaysActive || ref.watch(notificationsProvider)['status'] == value.key;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: ActionChip(
          onPressed: () {
            ref.read(notificationsProvider.notifier).updateStatus(value);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          label: Text(
            value.name.tr,
            style: AppFontStyle.black_14.copyWith(
                color: !isSelected ? AppColors.primaryColor : AppColors.white),
          ),
          backgroundColor:
              (isSelected ? AppColors.primaryColor : AppColors.white)),
    );
  }
}
