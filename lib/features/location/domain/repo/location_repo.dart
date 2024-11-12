import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/utils/api_service.dart';

import '../../data/model/location_model.dart';

abstract class LocationRepo {
  Future<Either<Failure,LocationModel?>> getCurrentLocation();
}