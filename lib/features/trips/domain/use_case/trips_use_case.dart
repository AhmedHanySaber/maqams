import 'package:dartz/dartz.dart';
import 'package:maqam_v2/features/trips/domain/entity/maqam_entity.dart';
import 'package:maqam_v2/features/trips/domain/repo/trips_repo.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/trips.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';
import '../../data/model/trip_model.dart';

class FetchTripsUseCase extends StreamUseCase<Iterable<TripModel>, NoParam> {
  final TripRepo tripRepo;

  FetchTripsUseCase({
    required this.tripRepo,
  });

  @override
  Stream<Either<Failure, Iterable<TripModel>>> call([void param]) async* {
    yield* tripRepo.getTrips();
  }
}

class FetchMaqamUseCase extends StreamUseCase<Iterable<MaqamEntity>, String> {
  final TripRepo tripRepo;

  FetchMaqamUseCase({
    required this.tripRepo,
  });

  @override
  Stream<Either<Failure, Iterable<MaqamEntity>>> call([String? param]) async* {
    yield* tripRepo.getMaqam(param ?? "");
  }
}

class FetchTripsByNameUseCase extends StreamUseCase<Iterable<TripModel>, String> {
  final TripRepo tripRepo;

  FetchTripsByNameUseCase({
    required this.tripRepo,
  });

  @override
  Stream<Either<Failure, Iterable<TripModel>>> call([String? param]) async* {
    yield* tripRepo.getTripsByName(name: param ?? "");
  }
}
