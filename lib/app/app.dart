import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:maqam_v2/config/routes.dart';
import 'package:maqam_v2/core/constants.dart';
import 'package:maqam_v2/core/utils/app_translation.dart';
import 'package:maqam_v2/di_container.dart' as di;
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/location/presentation/managers/location_cubit.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_cubit.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import '../core/utils/localization_service.dart';
import '../features/drawer/presentation/controller/drawer_cubit.dart';
import '../features/drawer/presentation/screens/spash_screen.dart';

final ProviderContainer providerContainer = ProviderContainer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: providerContainer,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<AuthCubit>()),
          BlocProvider(create: (context) => di.sl<DrawerCubit>()),
          BlocProvider(create: (context) => di.sl<CartCubit>()),
          BlocProvider(create: (context) => di.sl<SearchCubit>()),
          BlocProvider(create: (context) => di.sl<TripsCubit>()),
          BlocProvider(create: (context) => di.sl<ReservationCubit>()),
          BlocProvider(create: (context) => di.sl<LocationCubit>())
        ],
        child: ScreenUtilInit(
          fontSizeResolver: FontSizeResolvers.height,
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: const Size(375, 812),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
            title: AppStrings.appName,
            locale: localeService.handleLocaleInMain,
            translations: Translation(),
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
