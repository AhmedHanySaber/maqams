import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import 'package:maqam_v2/features/modules/domain/entities/ad_entity.dart';

abstract class ModulesRepo {
  Future<Either<Failure, List<ModuleModel>>> getModules();

  Future<Either<Failure, ModuleModel>> getFeaturedModule();

  Future<Either<Failure, List<AdEntity>>> getAds();
}
