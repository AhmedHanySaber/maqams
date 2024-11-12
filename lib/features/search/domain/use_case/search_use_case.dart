import 'package:dartz/dartz.dart';
import 'package:maqam_v2/features/search/domain/repo/search_repo.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';

import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';

class FetchSearchTripsUseCase
    extends StreamUseCase<Iterable<TripModel>, String> {
  final SearchRepo searchRepo;

  FetchSearchTripsUseCase({
    required this.searchRepo,
  });

  @override
  Stream<Either<Failure, Iterable<TripModel>>> call([String? param]) async* {
    yield* searchRepo.streamTripsByName(name: param ?? "");
  }
}
