import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maqam_v2/features/search/domain/repo/search_repo.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';

import '../../../../core/utils/api_service.dart';
import '../data_source/search_data_source.dart';

class SearchRepoImp extends SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImp({required this.searchDataSource});

  @override
  Stream<Either<Failure, Iterable<TripModel>>> streamTripsByName(
      {required String name}) async* {
    try {
      final res = searchDataSource.streamTripsByName(name: name);
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
}
