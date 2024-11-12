import 'package:dartz/dartz.dart';
import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import 'package:maqam_v2/features/modules/domain/repo/modules_repo.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';
import '../entities/ad_entity.dart';

class FetchAdsUseCase extends UseCase<List<AdEntity>, NoParam> {
  final ModulesRepo modulesRepo;

  FetchAdsUseCase({
    required this.modulesRepo,
  });

  @override
  Future<Either<Failure, List<AdEntity>>> call([void param]) {
    return modulesRepo.getAds();
  }
}

class FetchModulesUseCase extends UseCase<List<ModuleModel>, NoParam> {
  final ModulesRepo modulesRepo;

  FetchModulesUseCase({
    required this.modulesRepo,
  });

  @override
  Future<Either<Failure, List<ModuleModel>>> call([void param]) {
    return modulesRepo.getModules();
  }
}

class FetchFeaturedModulesUseCase extends UseCase<ModuleModel, NoParam> {
  final ModulesRepo modulesRepo;

  FetchFeaturedModulesUseCase({
    required this.modulesRepo,
  });

  @override
  Future<Either<Failure, ModuleModel>> call([void param]) {
    return modulesRepo.getFeaturedModule();
  }
}
