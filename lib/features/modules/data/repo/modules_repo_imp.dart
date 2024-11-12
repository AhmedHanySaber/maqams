import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/modules/data/data_source/modules_data_source.dart';
import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import 'package:maqam_v2/features/modules/domain/entities/ad_entity.dart';
import 'package:maqam_v2/features/modules/domain/repo/modules_repo.dart';

class ModulesRepoImp extends ModulesRepo {
  final ModulesDataSource modulesDataSource;

  ModulesRepoImp({required this.modulesDataSource});

  @override
  Future<Either<Failure, List<AdEntity>>> getAds() async {
    try {
      final res = await modulesDataSource.getAds();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, ModuleModel>> getFeaturedModule() async {
    try {
      final res = await modulesDataSource.getFeaturedModule();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, List<ModuleModel>>> getModules() async {
    try {
      final res = await modulesDataSource.getModules();
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
