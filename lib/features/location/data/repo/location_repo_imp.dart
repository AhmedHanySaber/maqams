import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/location/data/data_source/location_data_source.dart';
import 'package:maqam_v2/features/location/data/model/location_model.dart';
import '../../domain/repo/location_repo.dart';

class LocationRepoImp extends LocationRepo {
  final LocationDataSource locationDataSource;

  LocationRepoImp({required this.locationDataSource});

  @override
  Future<Either<Failure, LocationModel?>> getCurrentLocation() async {
    try {
      final result = await locationDataSource.getCurrentLocation();
      return Right(result);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      debugPrint('General Error: $e');
      return Left(GeneralError());
    }
  }
}
