import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/functions/riverpod.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/features/notifications/presentation/view/widgets/notification_filter_chip.dart';
import 'package:maqam_v2/features/notifications/presentation/view/widgets/notifications_container.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../managers/fetch_notificatons_provider.dart';
import '../managers/notifications_filter.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifications".tr, isRoot: false),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
              const data = NotificationFilterType.values;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                      children: data
                          .map((e) => NotificationsCustomActionChip(value: e))
                          .toList()),
                ),
              );
            }),
            Gap(10.h),
            Expanded(
              child: Consumer(builder: (context, ref, _) {
                final notificationsList = ref.watch(fetchNotificationsProvider);
                return notificationsList.customWhen(
                    ref: ref,
                    refreshable: fetchNotificationsProvider.future,
                    data: (notifications) {
                      if (notifications.isEmpty) {
                        return Text(
                          "No Notifications right now.!".tr,
                          style: AppFontStyle.primaryBold_18,
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return NotificationContainer(
                                  notificationEntity: notifications[index]);
                            },
                            separatorBuilder: (context, index) {
                              return const Gap(10);
                            },
                            itemCount: notifications.length),
                      );
                    },
                    loading: () {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[900]!,
                              highlightColor: Colors.green[100]!,
                              child: Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
