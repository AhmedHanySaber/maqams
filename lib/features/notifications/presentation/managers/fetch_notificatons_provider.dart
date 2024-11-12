import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../di_container.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/use_case/fetch_notifications_use_case.dart';
import 'notifications_filter.dart';

final fetchNotificationsProvider =
    FutureProvider.autoDispose<List<NotificationEntity>>((ref) async {
  final attribute = ref.watch(notificationsProvider);

  final notes = await sl<FetchNotificationUseCase>().call(attribute);

  return notes.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
