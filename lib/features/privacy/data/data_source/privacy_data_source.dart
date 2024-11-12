import '../../../../core/utils/api_service.dart';
import '../../domain/entities/message_entity.dart';

abstract class PrivacyPolicyDataSource {
  Future<Message> getPolicy();
  Future<Message> getWhoAreWe();
}

class PrivacyPolicyDataSourceImpl extends PrivacyPolicyDataSource {
  final ApiService apiService;

  PrivacyPolicyDataSourceImpl({required this.apiService});

  @override
  Future<Message> getPolicy() async {
    await Future.delayed(const Duration(seconds: 2));
    return message;
    // final res = await apiService.get(url: GET_TERMS, returnDataOnly: false);
    //
    // final Message privacyPolicyModel =
    // Message.fromJson((res['message'] as List).first);
    //
    // return privacyPolicyModel;
  }

  @override
  Future<Message> getWhoAreWe() async {
    await Future.delayed(const Duration(seconds: 2));
    return message;
    // final res = await apiService.get(url: GET_TERMS, returnDataOnly: false);
    //
    // final Message privacyPolicyModel =
    // Message.fromJson((res['message'] as List).first);
    //
    // return privacyPolicyModel;
  }
}