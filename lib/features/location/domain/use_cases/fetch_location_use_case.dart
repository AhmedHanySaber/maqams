import 'package:dartz/dartz.dart';
import 'package:maqam_v2/features/location/data/model/location_model.dart';
import 'package:maqam_v2/features/location/domain/repo/location_repo.dart';

import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';

class FetchLocationUseCase extends UseCase<LocationModel?, NoParam> {
  final LocationRepo locationRepo;

  FetchLocationUseCase({
    required this.locationRepo,
  });

  @override
  Future<Either<Failure, LocationModel?>> call([void param]) {
    return locationRepo.getCurrentLocation();
  }
}
