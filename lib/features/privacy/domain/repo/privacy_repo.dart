import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/privacy/domain/entities/message_entity.dart';

abstract class PrivacyRepo {
  Future<Either<Failure,Message>> getPrivacy();
  Future<Either<Failure,Message>> getWhoAreWe();
}