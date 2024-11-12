import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/reservation/models/reservation_model.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/colors.dart';

class AllReservationScreen extends StatefulWidget {
  const AllReservationScreen({super.key});

  @override
  State<AllReservationScreen> createState() => _AllReservationScreenState();
}

class _AllReservationScreenState extends State<AllReservationScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  Future<void> loadData() async {
    await ReservationCubit.get(context).reservations();
    await ReservationCubit.get(context).acceptedReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Reservations", isRoot: false),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                height: 60.h,
                child: TabBar(controller: controller, tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Divider(color: AppColors.primaryColor)),
                      Gap(10.w),
                      Text(
                        AppStrings.pending.tr,
                        style: AppFontStyle.primaryBold_14,
                      ),
                      Gap(10.w),
                      Expanded(child: Divider(color: AppColors.primaryColor)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: Divider(color: Colors.green)),
                      Gap(10.w),
                      Text(
                        "Confirmed".tr,
                        style: AppFontStyle.primaryBold_14,
                      ),
                      Gap(10.w),
                      const Expanded(child: Divider(color: Colors.green)),
                    ],
                  ),
                ]),
              ),
            ),
            Gap(10.h),
            Expanded(
              child: TabBarView(controller: controller, children: [
                FutureBuilder<List<ReservationModel>>(
                  future: ReservationCubit.get(context).reservations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Shimmer.fromColors(
                              baseColor: AppColors.primaryColor.withOpacity(.3),
                              highlightColor:
                                  AppColors.primaryColor.withOpacity(.1),
                              child: Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasData) {
                      final list = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (list!.isEmpty) {
                            return Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/img2.png",
                                    height: 200.h,
                                    color: Colors.green,
                                  ),
                                  Gap(20.h),
                                  Flexible(
                                    child: Text(
                                      AppStrings.noReservations,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }

                          final item = list[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(.15),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: AppColors.primaryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(item.name.toUpperCase(),
                                            style: AppFontStyle.primary_16),
                                        const SizedBox(height: 5),
                                        Text(item.email,
                                            style: AppFontStyle.primary_16),
                                        const SizedBox(height: 5),
                                        Text(item.phoneNumber,
                                            style: AppFontStyle.primaryBold_16),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text("Places : ".tr,
                                                style: AppFontStyle.primary_14),
                                            for (var i in item.cartItems)
                                              Text("$i, ",
                                                  style: AppFontStyle.primary_14),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(AppStrings.reserved.tr,
                                                style: AppFontStyle.primary_16),
                                            const SizedBox(width: 5),
                                            item.reserved == true
                                                ? const Icon(
                                                    Icons.circle,
                                                    color: Colors.green,
                                                  )
                                                : const Icon(
                                                    Icons.circle_outlined,
                                                    color: Colors.green,
                                                  )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/error.png",
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppStrings.unKnownError,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                FutureBuilder<List<ReservationModel>>(
                  future: ReservationCubit.get(context).acceptedReservations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Shimmer.fromColors(
                              baseColor: AppColors.primaryColor.withOpacity(.3),
                              highlightColor:
                              AppColors.primaryColor.withOpacity(.1),
                              child: Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                  AppColors.primaryColor.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasData) {
                      final list = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (list!.isEmpty) {
                            return Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/img2.png",
                                    height: 200.h,
                                    color: Colors.green,
                                  ),
                                  Gap(20.h),
                                  Flexible(
                                    child: Text(
                                      AppStrings.noReservations,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }

                          final item = list[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(.15),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: AppColors.primaryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(item.name.toUpperCase(),
                                            style: AppFontStyle.primary_16),
                                        const SizedBox(height: 5),
                                        Text(item.email,
                                            style: AppFontStyle.primary_16),
                                        const SizedBox(height: 5),
                                        Text(item.phoneNumber,
                                            style: AppFontStyle.primaryBold_16),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text("Places : ".tr,
                                                style: AppFontStyle.primary_14),
                                            for (var i in item.cartItems)
                                              Text("$i, ",
                                                  style: AppFontStyle.primary_14),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(AppStrings.reserved.tr,
                                                style: AppFontStyle.primary_16),
                                            const SizedBox(width: 5),
                                            item.reserved == true
                                                ? const Icon(
                                              Icons.circle,
                                              color: Colors.green,
                                            )
                                                : const Icon(
                                              Icons.circle_outlined,
                                              color: Colors.green,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/error.png",
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppStrings.unKnownError,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ]),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Expanded(child: Divider(color: AppColors.primaryColor)),
            //       const Gap(10),
            //       Text(
            //         AppStrings.pending.tr,
            //         style: AppFontStyle.primaryBold_14,
            //       ),
            //       const Gap(10),
            //       Expanded(child: Divider(color: AppColors.primaryColor)),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Expanded(child: Divider(color: Colors.green)),
            //       const Gap(10),
            //       Text(
            //         "Confirmed".tr,
            //         style: AppFontStyle.primaryBold_14,
            //       ),
            //       const Gap(10),
            //       const Expanded(child: Divider(color: Colors.green)),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
