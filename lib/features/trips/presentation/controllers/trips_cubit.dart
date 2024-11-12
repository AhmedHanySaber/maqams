import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/trips/domain/repo/trips_repo.dart';
import 'package:maqam_v2/features/trips/domain/entity/location.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import 'package:maqam_v2/features/trips/domain/use_case/trips_use_case.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import '../../../../di_container.dart';
import '../../domain/entity/maqam_entity.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepo tripsRepo;

  TripsCubit(this.tripsRepo) : super(TripsInitial());

  static TripsCubit get(BuildContext context) => BlocProvider.of(context);


  Stream<Iterable<TripModel>> getTrips() async* {
    final resultStream = sl<FetchTripsUseCase>().call();
    await for (final result in resultStream) {
      yield* result.fold(
        (failure) async* {
          throw failure;
        },
        (trips) async* {
          yield trips;
        },
      );
    }
  }

  Stream<Iterable<MaqamEntity>> getMaqam({required tripName}) async* {
    final resultStream = sl<FetchMaqamUseCase>().call(tripName);
    await for (final result in resultStream) {
      yield* result.fold(
        (failure) async* {
          throw failure;
        },
        (trips) async* {
          yield trips;
        },
      );
    }
  }

  Stream<Iterable<TripModel>> getTripsByName({required String name}) async* {
    final resultStream = sl<FetchTripsUseCase>().call(name);
    await for (final result in resultStream) {
      yield* result.fold(
        (failure) async* {
          throw failure;
        },
        (trips) async* {
          yield trips;
        },
      );
    }
  }

  Future<List<LocationEntity>> getLocation() async {
    final res = await tripsRepo.getLocations();
    return res.fold((l) {
      throw l;
    }, (r) {
      return r.toList();
    });
  }
}
