import 'package:dartz/dartz.dart';
import 'package:maqam_v2/features/privacy/domain/repo/privacy_repo.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';
import '../entities/message_entity.dart';

class FetchPolicyUseCase extends UseCase<Message, NoParam> {
  final PrivacyRepo privacyRepo;

  FetchPolicyUseCase({required this.privacyRepo});

  @override
  Future<Either<Failure, Message>> call([void param]) async {
    final res = await privacyRepo.getPrivacy();
    return res;
  }
}
