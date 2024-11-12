import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';

abstract class SearchRepo{
  Stream<Either<Failure,Iterable<TripModel>>> streamTripsByName({required String name});
}