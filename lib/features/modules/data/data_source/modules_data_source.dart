import 'package:maqam_v2/core/dummy_modules.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/modules/data/models/ad_model.dart';
import 'package:maqam_v2/features/modules/data/models/module_model.dart';
import '../../domain/entities/ad_entity.dart';

abstract class ModulesDataSource {
  Future<List<ModuleModel>> getModules();

  Future<List<AdEntity>> getAds();

  Future<ModuleModel> getFeaturedModule();
}

class ModulesDataSourceImp extends ModulesDataSource {
  final ApiService apiService;

  ModulesDataSourceImp({required this.apiService});

  @override
  Future<List<ModuleModel>> getModules() async {
    await Future.delayed(const Duration(seconds: 2));
    return modulesList;

    // final res=await apiService.get<List>(url: "url",returnDataOnly: true);
    // final modules=res.map((e)=>ModuleModel.fromJson(e)).toList();
    // return modules;
  }

  @override
  Future<ModuleModel> getFeaturedModule() async {
    await Future.delayed(const Duration(seconds: 2));
    return modulesList[0];

    // final res=await apiService.get(url: "url",returnDataOnly: true);
    // return ModuleModel.fromJson(res);
  }

  @override
  Future<List<AdEntity>> getAds() async {
    // TODO: implement getAds
    throw UnimplementedError();
    // final res=await apiService.get<List>(url: "url",returnDataOnly: true);
    // final modules=res.map((e)=>AdModel.fromJson(e)).toList();
    // return modules;
  }
}
