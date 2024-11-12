import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/auth/domain/repo/auth_repo.dart';
import 'package:maqam_v2/features/auth/data/models/user_model.dart';

import '../../../../di_container.dart';
import '../data_source/auth_data_source.dart';

class AuthRepoImp extends AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImp({required this.authDataSource});

  @override
  Future<UserCredential?> createAccount({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return authDataSource.createAccount(
        fullName: fullName, email: email, password: password);
    // try {
    //   final credential = await firebaseAuth.createUserWithEmailAndPassword(
    //       email: email, password: password);
    //
    //   // getting object from the user model
    //   UserModel user = UserModel(
    //       fullName: fullName,
    //       email: email,
    //       password: password,
    //       uid: firebaseAuth.currentUser!.uid);
    //
    //   // stores the user data in firebase firestore docs
    //   await firestore
    //       .collection('user')
    //       .doc(firebaseAuth.currentUser!.uid)
    //       .set(user.toMap());
    //
    //   return credential;
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

  @override
  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    return authDataSource.login(email: email, password: password);
    // try {
    //   final credential = await firebaseAuth.signInWithEmailAndPassword(
    //       email: email, password: password);
    //
    //   return credential;
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    final res = await authDataSource.getCurrentUserData();
    return res;
    // try {
    //   final user = await firestore
    //       .collection("users")
    //       .doc(firebaseAuth.currentUser!.uid)
    //       .get();
    //
    //   final userData = UserModel.fromMap(user.data()!);
    //   return userData;
    // } catch (e) {
    //   print(e);
    //   throw Exception(e);
    // }
  }

  @override
  Future<UserModel?> getUserDataById({required String userId}) async {
    return authDataSource.getUserDataById(userId: userId);
    // try {
    //   final user = await firestore.collection("users").doc(userId).get();
    //
    //   final userData = UserModel.fromMap(user.data()!);
    //   return userData;
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }

  @override
  Future<UserCredential?> signInAsGuest() async {
    // return authDataSource.signInAsGuest();
    try {
      final user = await sl<FirebaseAuth>().signInAnonymously();
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }
}
