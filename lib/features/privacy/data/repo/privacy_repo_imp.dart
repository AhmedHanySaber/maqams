import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/privacy/data/data_source/privacy_data_source.dart';
import 'package:maqam_v2/features/privacy/domain/entities/message_entity.dart';
import 'package:maqam_v2/features/privacy/domain/repo/privacy_repo.dart';

class PrivacyRepoImp extends PrivacyRepo {
  final PrivacyPolicyDataSource policyDataSource;

  PrivacyRepoImp({required this.policyDataSource});

  @override
  Future<Either<Failure, Message>> getPrivacy() async {
    try {
      final res = await policyDataSource.getPolicy();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, Message>> getWhoAreWe() async {
    try {
      final res = await policyDataSource.getWhoAreWe();
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
