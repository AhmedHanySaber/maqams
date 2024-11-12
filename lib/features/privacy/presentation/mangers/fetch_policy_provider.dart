import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../di_container.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/use_case/fetch_policy_use_case.dart';

final fetchPolicyProvider = FutureProvider.autoDispose<Message>((ref) async {
  final res = await sl<FetchPolicyUseCase>().call();
  return res.fold((l) => throw l, (r) => r);
});
