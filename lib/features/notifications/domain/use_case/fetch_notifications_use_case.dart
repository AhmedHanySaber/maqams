import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';
import '../entities/notification_entity.dart';
import '../repos/notification_repo.dart';

class FetchNotificationUseCase
    extends UseCase<List<NotificationEntity>, Map<String, dynamic>> {
  final NotificationRepo notificationRepo;

  FetchNotificationUseCase({required this.notificationRepo});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      [Map<String, dynamic>? param]) async {
    final res = await notificationRepo.getNotifications(param!);
    return res;
  }
}
