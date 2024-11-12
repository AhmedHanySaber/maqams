import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/auth/data/data_source/auth_data_source.dart';
import 'package:maqam_v2/features/auth/domain/repo/auth_repo.dart';
import 'package:maqam_v2/features/auth/data/repo/auth_repo_imp.dart';
import 'package:maqam_v2/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:maqam_v2/features/cart/data/data_source/cart_data_source.dart';
import 'package:maqam_v2/features/cart/domain/repo/cart_repo.dart';
import 'package:maqam_v2/features/cart/data/repo/cart_repo_imp.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_cubit.dart';
import 'package:maqam_v2/features/location/data/data_source/location_data_source.dart';
import 'package:maqam_v2/features/location/data/repo/location_repo_imp.dart';
import 'package:maqam_v2/features/location/domain/repo/location_repo.dart';
import 'package:maqam_v2/features/location/domain/use_cases/fetch_location_use_case.dart';
import 'package:maqam_v2/features/location/presentation/managers/location_cubit.dart';
import 'package:maqam_v2/features/modules/data/data_source/modules_data_source.dart';
import 'package:maqam_v2/features/modules/data/repo/modules_repo_imp.dart';
import 'package:maqam_v2/features/modules/domain/repo/modules_repo.dart';
import 'package:maqam_v2/features/modules/domain/use_case/modules_use_cases.dart';
import 'package:maqam_v2/features/modules/presentation/mangers/modules_cubit.dart';
import 'package:maqam_v2/features/notifications/data/data_source/notification_data_source.dart';
import 'package:maqam_v2/features/notifications/data/repo/notification_repo_imp.dart';
import 'package:maqam_v2/features/notifications/domain/repos/notification_repo.dart';
import 'package:maqam_v2/features/notifications/domain/use_case/fetch_notifications_use_case.dart';
import 'package:maqam_v2/features/privacy/data/data_source/privacy_data_source.dart';
import 'package:maqam_v2/features/privacy/data/repo/privacy_repo_imp.dart';
import 'package:maqam_v2/features/privacy/domain/repo/privacy_repo.dart';
import 'package:maqam_v2/features/privacy/domain/use_case/fetch_policy_use_case.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo.dart';
import 'package:maqam_v2/features/reservation/data/reservation_repo_imp.dart';
import 'package:maqam_v2/features/reservation/presentation/controllers/reservation_cubit.dart';
import 'package:maqam_v2/features/search/data/data_source/search_data_source.dart';
import 'package:maqam_v2/features/search/domain/repo/search_repo.dart';
import 'package:maqam_v2/features/search/data/repo/search_repo_imp.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_cubit.dart';
import 'package:maqam_v2/features/trips/data/data_source/trips_data_source.dart';
import 'package:maqam_v2/features/trips/domain/repo/trips_repo.dart';
import 'package:maqam_v2/features/trips/data/repo/trips_repo_imp.dart';
import 'package:maqam_v2/features/trips/domain/use_case/trips_use_case.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'config/network.dart';
import 'core/utils/local_data_manager.dart';
import 'core/utils/localization_service.dart';
import 'features/drawer/presentation/controller/drawer_cubit.dart';
import 'features/search/domain/use_case/search_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // externals
  await GetStorage.init();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton<LocalDataManager>(() => LocalDataManagerImpl());
  sl.registerLazySingleton<LocaleService>(
          () => LocaleService(sl<LocalDataManager>()));

  // register data source
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImp(firebaseAuth: sl(), firestore: sl()));
  sl.registerLazySingleton<TripsDataSource>(
      () => TripsDataSourceImp(firestore: sl()));
  sl.registerLazySingleton<SearchDataSource>(
      () => SearchDataSourceImp(firestore: sl()));
  sl.registerLazySingleton<CartDataSource>(
      () => CartDataSourceImp(firestore: sl(), auth: sl()));
  sl.registerLazySingleton<PrivacyPolicyDataSource>(
      () => PrivacyPolicyDataSourceImpl(apiService: sl()));
  sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<LocationDataSource>(
      () => LocationDataSourceImp(apiService: sl()));

  // register repos of the app
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImp(authDataSource: sl()));
  sl.registerLazySingleton<ReservationRepo>(
      () => ReservationRepoImp(auth: sl(), firestore: sl()));
  sl.registerLazySingleton<TripRepo>(() => TripRepoImp(tripsDataSource: sl()));
  sl.registerLazySingleton<CartRepo>(() => CartRepoImp(cartDataSource: sl()));
  sl.registerLazySingleton<SearchRepo>(
      () => SearchRepoImp(searchDataSource: sl()));
  sl.registerLazySingleton<PrivacyRepo>(
      () => PrivacyRepoImp(policyDataSource: sl()));
  sl.registerLazySingleton<NotificationRepo>(
      () => NotificationRepoImp(notificationDataSource: sl()));
  sl.registerLazySingleton<LocationRepo>(
      () => LocationRepoImp(locationDataSource: sl()));

  sl.registerLazySingleton<ModulesDataSource>(
      () => ModulesDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<ModulesRepo>(
      () => ModulesRepoImp(modulesDataSource: sl()));

  sl.registerLazySingleton<FetchFeaturedModulesUseCase>(
      () => FetchFeaturedModulesUseCase(modulesRepo: sl()));
  sl.registerLazySingleton<FetchModulesUseCase>(
      () => FetchModulesUseCase(modulesRepo: sl()));
  sl.registerLazySingleton<FetchAdsUseCase>(
      () => FetchAdsUseCase(modulesRepo: sl()));
  sl.registerLazySingleton<FetchTripsUseCase>(
      () => FetchTripsUseCase(tripRepo: sl()));
  sl.registerLazySingleton<FetchMaqamUseCase>(
      () => FetchMaqamUseCase(tripRepo: sl()));
  sl.registerLazySingleton<FetchTripsByNameUseCase>(
      () => FetchTripsByNameUseCase(tripRepo: sl()));
  sl.registerLazySingleton<FetchSearchTripsUseCase>(
      () => FetchSearchTripsUseCase(searchRepo: sl()));
  sl.registerLazySingleton<FetchPolicyUseCase>(
      () => FetchPolicyUseCase(privacyRepo: sl()));
  sl.registerLazySingleton<FetchNotificationUseCase>(
      () => FetchNotificationUseCase(notificationRepo: sl()));
  sl.registerLazySingleton<FetchLocationUseCase>(
      () => FetchLocationUseCase(locationRepo: sl()));

  // register controllers of the app
  sl.registerFactory(() => TripsCubit(sl()));
  sl.registerFactory(() => DrawerCubit());
  sl.registerFactory(() => ReservationCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => SearchCubit());
  sl.registerFactory(() => CartCubit(sl()));
  sl.registerFactory(() => ModulesCubit());
  sl.registerFactory(() => LocationCubit());
}
