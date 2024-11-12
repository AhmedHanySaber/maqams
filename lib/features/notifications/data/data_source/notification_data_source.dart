import '../../../../core/utils/api_service.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationDataSource {
  Future<List<NotificationModel>> getNotification(Map<String, dynamic> data);
}

class NotificationDataSourceImp extends NotificationDataSource {
  final ApiService apiService;

  NotificationDataSourceImp({required this.apiService});

  @override
  Future<List<NotificationModel>> getNotification(
      Map<String, dynamic> data) async {
    // final status = data['status'];
    await Future.delayed(const Duration(seconds: 2));
    return notifications;
    // final res = await apiService.get(
    //   url: '${ApiPath.notifications}$status',
    // );
    // final List<NotificationModel> list =
    //     (res as List).map((e) => NotificationModel.fromJson(e)).toList();
    // return list;
  }

  // @override
  // Future<bool> seen(int id) async {
  //   await apiService.get(
  //     url: '${ApiPath.seen}/$id',
  //   );
  //   return true;
  // }
}
