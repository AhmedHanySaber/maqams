import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/features/notifications/presentation/view/notifications_screen.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import 'package:maqam_v2/features/trips/presentation/view/screens/see_all_location.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/head_home_title.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/location_list_view.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/trips.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../di_container.dart';
import '../../../../search/presentation/view/search_screen.dart';
import 'all_trips_screeen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.appName.tr,
        isRoot: true,
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () => Get.to(() => const NotificationsScreen()),
            child: Icon(
              Icons.notifications_active_rounded,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
      body: BlocConsumer<TripsCubit, TripsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final TripsCubit cubit = sl<TripsCubit>();
          return StreamBuilder(
            stream: cubit.getTrips(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final tripsData = snapshot.data!;
                final trips = tripsData.toList();
                return ListView(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const SearchScreen(searchBar: true)));
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    AppStrings.search.tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeadHomeTitle(title: "Locations".tr),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SeeAllLocationScreen(trips: trips),
                                    ),
                                  );
                                },
                                child: GestureDetector(
                                  child: Text('See All'.tr,
                                      style: AppFontStyle.grey_14),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 40,
                            child: LocationListView(
                                future: cubit.getLocation(), trips: trips)),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeadHomeTitle(title: 'Popular Trips'.tr),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllTripsScreen(
                                        trips: trips,
                                        categoryName: 'Popular Trips'.tr,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('See All'.tr,
                                    style: AppFontStyle.grey_14),
                              )
                            ],
                          ),
                        ),
                        Trips(trips: trips),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeadHomeTitle(title: 'Recommended Trips'.tr),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllTripsScreen(
                                        trips: trips,
                                        categoryName: 'Recommended Trips'.tr,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(AppStrings.seeAll.tr,
                                    style: AppFontStyle.grey_14),
                              )
                            ],
                          ),
                        ),
                        Trips(trips: trips),
                      ]))
                ]);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const SearchScreen(searchBar: true)));
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppStrings.search,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HeadHomeTitle(title: AppStrings.location),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HeadHomeTitle(title: AppStrings.popularNow),
                                SizedBox(
                                  height: 40,
                                  child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Text(AppStrings.seeAll)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.green.shade300,
                              child: Container(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HeadHomeTitle(
                                    title: AppStrings.recommendedTrips),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            },
          );
        },
      ),
    );
  }
}
/*

* */
