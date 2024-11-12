import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../features/auth/data/models/user_model.dart';
import '../enums/language.dart';

abstract class LocalDataManager {
  Future<void> saveToken(String token);

  Future<void> removeToken();

  Future<void> setFCMToken(String? token);

  String? getFCMToken();

  Future<void> saveUser(UserModel user);

  Future<void> logout();

  UserModel? getUser();

  String? getToken();

  bool get isFirstTime;

  Future<void> setSecondTime();

  Future<void> setLanguage(Language lang);

  Language? get getLanguage;
}

class LocalDataManagerImpl extends LocalDataManager {
  final GetStorage box = GetStorage();

  LocalDataManagerImpl();

  @override
  Future<void> saveToken(String token) async {
    await box.write('token', token);
  }

  @override
  String? getToken() {
    return box.read('token');
  }

  @override
  Future<void> removeToken() {
    return box.remove('token');
  }

  @override
  UserModel? getUser() {
    final res = box.read('user');
    if (res == null) {
      return null;
    } else {
      return UserModel.fromMap(jsonDecode(res));
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return box.write('user', jsonEncode(user.toMap()));
  }

  @override
  Future<void> logout() {
    return box.erase();
  }

  @override
  Future<void> setLanguage(Language lang) async {
    return box.write("language", lang.locale.languageCode);
  }

  @override
  Language? get getLanguage {
    return Language.values.firstWhereOrNull(
            (element) => element.locale.languageCode == box.read("language")) ??
        Language.values.first;
  }

  @override
  bool get isFirstTime => box.read("second_time") != true;

  @override
  Future<void> setSecondTime() {
    return box.write("second_time", true);
  }

  @override
  String? getFCMToken() {
    return box.read('fcmToken');
  }

  @override
  Future<void> setFCMToken(String? token) {
    return box.write('fcmToken', token);
  }
}
