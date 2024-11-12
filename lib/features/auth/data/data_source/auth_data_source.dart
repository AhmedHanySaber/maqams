import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/core/utils/localization_service.dart';

import '../models/user_model.dart';

abstract class AuthDataSource {
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

class AuthDataSourceImp extends AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthDataSourceImp({required this.firebaseAuth, required this.firestore});

  @override
  Future<UserCredential?> createAccount(
      {required String fullName,
      required String email,
      required String password}) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    // getting object from the user model
    UserModel user = UserModel(
        fullName: fullName,
        email: email,
        password: password,
        uid: firebaseAuth.currentUser!.uid);

    // stores the user data in firebase firestore docs
    await firestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.toMap());
    await localDataManager.saveUser(user);

    return credential;
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    final user = await firestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    final userData = UserModel.fromMap(user.data()!);
    return userData;
  }

  @override
  Future<UserModel?> getUserDataById({required String userId}) async {
    final user = await firestore.collection("users").doc(userId).get();

    final userData = UserModel.fromMap(user.data()!);
    return userData;
  }

  @override
  Future<UserCredential?> login(
      {required String email, required String password}) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    UserModel user = UserModel(
        fullName: credential.user!.displayName??"",
        email: email,
        password: password,
        uid: firebaseAuth.currentUser!.uid);

    await localDataManager.saveUser(user);

    return credential;
  }

  @override
  Future<UserCredential?> signInAsGuest() async {
    final user = await firebaseAuth.signInAnonymously();
    return user;
  }
}
