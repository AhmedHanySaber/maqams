import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import 'package:maqam_v2/features/modules/domain/entities/ad_entity.dart';

abstract class ModulesState {}

class ModulesInitial extends ModulesState {}

class ModulesLoading extends ModulesState {}

class ModulesSuccess extends ModulesState {
  final List<ModuleModel> modules;

  ModulesSuccess({required this.modules});
}

class ModulesError extends ModulesState {
  final String error;

  ModulesError({required this.error});
}

class FeaturedModulesLoading extends ModulesState {}

class FeaturedModulesSuccess extends ModulesState {
  final ModuleModel modules;

  FeaturedModulesSuccess({required this.modules});
}

class FeaturedModulesError extends ModulesState {
  final String error;

  FeaturedModulesError({required this.error});
}

class AdsLoading extends ModulesState {}

class AdsSuccess extends ModulesState {
  final List<AdEntity> ads;

  AdsSuccess({required this.ads});
}

class AdsError extends ModulesState {
  final String error;

  AdsError({required this.error});
}
