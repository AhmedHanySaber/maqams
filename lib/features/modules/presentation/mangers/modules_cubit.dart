import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import 'package:maqam_v2/features/modules/domain/entities/ad_entity.dart';
import 'package:maqam_v2/features/modules/domain/use_case/modules_use_cases.dart';

import '../../../../di_container.dart';
import 'modules_state.dart';

class ModulesCubit extends Cubit<ModulesState> {
  ModulesCubit() : super(ModulesInitial());

  Future<Either<Failure, List<ModuleModel>>> getModules() async {
    emit(ModulesLoading());
    final res = await sl<FetchModulesUseCase>().call();
    return res.fold((l) {
      emit(ModulesError(error: l.message));
      throw l;
    }, (r) {
      emit(ModulesSuccess(modules: r));
      return Right(r);
    });
  }

  Future<Either<Failure, List<AdEntity>>> getAds() async {
    emit(AdsLoading());
    final res = await sl<FetchAdsUseCase>().call();
    return res.fold((l) {
      emit(AdsError(error: l.message));
      throw l;
    }, (r) {
      emit(AdsSuccess(ads: r));
      return Right(r);
    });
  }

  Future<Either<Failure, ModuleModel>> getFeaturedModule() async {
    emit(FeaturedModulesLoading());
    final res = await sl<FetchFeaturedModulesUseCase>().call();
    return res.fold((l) {
      emit(FeaturedModulesError(error: l.message));
      throw l;
    }, (r) {
      emit(FeaturedModulesSuccess(modules: r));
      return Right(r);
    });
  }
}
