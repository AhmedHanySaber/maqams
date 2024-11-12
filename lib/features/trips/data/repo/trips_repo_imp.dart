import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maqam_v2/features/trips/domain/repo/trips_repo.dart';
import 'package:maqam_v2/features/trips/domain/entity/location.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import '../../../../core/utils/api_service.dart';
import '../../domain/entity/maqam_entity.dart';
import '../data_source/trips_data_source.dart';

class TripRepoImp extends TripRepo {
  final TripsDataSource tripsDataSource;

  TripRepoImp({required this.tripsDataSource});

  @override
  List<TripModel> filterTrips(List<TripModel> trips, String location) {
    final res = tripsDataSource.filterTrips(trips, location);
    return res;
  }

  @override
  Stream<Either<Failure, Iterable<TripModel>>> getTrips() async* {
    try {
      final res = tripsDataSource.getTrips();
      await for (final trips in res) {
        yield Right(trips);
      }
    } catch (e) {
      if (e is DioException) {
        yield Left(ServerFailure.fromDioError(e));
      } else {
        yield Left(GeneralError());
      }
    }
  }

  @override
  Stream<Either<Failure, Iterable<TripModel>>> getTripsByName(
      {required String name}) async* {
    try {
      final res = tripsDataSource.getTrips();
      await for (final trips in res) {
        yield Right(trips);
      }
    } catch (e) {
      if (e is DioException) {
        yield Left(ServerFailure.fromDioError(e));
      } else {
        yield Left(GeneralError());
      }
    }
  }

  @override
  Stream<Either<Failure, Iterable<MaqamEntity>>> getMaqam(
      String tripName) async* {
    try {
      final res = tripsDataSource.getMaqam(tripName);
      await for (final trips in res) {
        yield Right(trips);
      }
    } catch (e) {
      if (e is DioException) {
        yield Left(ServerFailure.fromDioError(e));
      } else {
        yield Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, Iterable<LocationEntity>>> getLocations() async {
    try {
      final res = await tripsDataSource.getLocations();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }
}
