import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<UserCredential?> createAccount({
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserCredential?> login({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
  Future<UserCredential?> signInAsGuest();

  Future<UserModel?> getUserDataById({required String userId});
}
