import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/trips/domain/entity/location.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import '../entity/maqam_entity.dart';

abstract class TripRepo {
  Stream<Either<Failure, Iterable<TripModel>>> getTrips();

  Stream<Either<Failure, Iterable<TripModel>>> getTripsByName({required String name});

  Stream<Either<Failure, Iterable<MaqamEntity>>> getMaqam(String tripName);

  List<TripModel> filterTrips(List<TripModel> trips, String location);

  Future<Either<Failure, Iterable<LocationEntity>>> getLocations();
}
