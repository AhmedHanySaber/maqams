import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import '../../../domain/entities/notification_entity.dart';

class NotificationContainer extends ConsumerWidget {
  final NotificationEntity notificationEntity;

  const NotificationContainer({super.key, required this.notificationEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: notificationEntity.seen == 0
          ? () async {
              // try {
              //   ref
              //       .read(isLoadingProvider("Seen${notificationEntity.id}")
              //           .notifier)
              //       .state = true;
              //
              //   final history = await sl<SeenNotificationUseCase>()
              //       .call(notificationEntity.id);
              //
              //   return history.fold((l) {
              //     ref
              //         .read(isLoadingProvider("Seen${notificationEntity.id}")
              //             .notifier)
              //         .state = false;
              //     UIHelper.showAlert(l.message, type: DialogType.error);
              //   }, (r) {
              //     ref.invalidate(fetchNotificationsProvider);
              //   });
              // } finally {
              //   ref
              //       .read(isLoadingProvider("Seen${notificationEntity.id}")
              //           .notifier)
              //       .state = false;
              // }
            }
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: AppColors.grayC4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Badge(
            isLabelVisible: notificationEntity.seen == 0,
            smallSize: 15,
            largeSize: 15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor4,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FancyShimmerImage(
                          shimmerHighlightColor: AppColors.primaryColor2,
                          shimmerBaseColor: AppColors.primaryColor3,
                          imageUrl: notificationEntity.logo,
                          errorWidget: Image.asset('assets/images/error.png'),
                          boxFit: BoxFit.cover,
                        ),
                        // child: ImageOrSvg(notificationEntity.logo),
                      ),
                    ),
                    const Gap(10),
                    Flexible(
                      child: Text(
                        notificationEntity.title,
                        style: AppFontStyle.black_16,
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Text(
                  notificationEntity.description,
                  style: AppFontStyle.black_12,
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
