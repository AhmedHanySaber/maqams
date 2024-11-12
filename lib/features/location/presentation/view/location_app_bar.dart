import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/location/presentation/managers/location_cubit.dart';
import 'package:maqam_v2/features/location/presentation/managers/location_state.dart';

class LocationAppBar extends StatefulWidget {
  const LocationAppBar({super.key});

  @override
  State<LocationAppBar> createState() => _LocationAppBarState();
}

class _LocationAppBarState extends State<LocationAppBar> {
  late final AuthCubit authCubit;
  late final LocationCubit locationCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCubit = AuthCubit.get(context);
    locationCubit = LocationCubit.get(context);
    locationCubit.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final user = authCubit.userChecker();
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (user == false) {
          if (state is LocationLoaded) {
            return SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Change your Location".tr,
                          style: AppFontStyle.white_22,
                        ),
                        if (locationCubit.locationModel != null)
                          Text(
                            "(${locationCubit.locationModel?.address ?? ""})",
                            style: AppFontStyle.white_12,
                          ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.white),
                  ],
                ),
              ),
            );
          } else if (state is LocationLoading) {
            return SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      "Select Location".tr,
                      style: AppFontStyle.white_22,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 60,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Lottie.asset(
                              fit: BoxFit.fill, "assets/wivey_loading.json"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            print("${(state as LocationError).message} ");
            return SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      "Select Location".tr,
                      style: AppFontStyle.white_22,
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () async => await locationCubit.getLocation(),
                        child: const Icon(Icons.arrow_forward_ios,
                            color: AppColors.white)),
                  ],
                ),
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
