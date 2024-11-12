import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maqam_v2/features/cart/domain/repo/cart_repo.dart';
import 'package:maqam_v2/features/reservation/models/reservation_model.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/api_service.dart';
import '../data_source/cart_data_source.dart';

class CartRepoImp extends CartRepo {
  final CartDataSource cartDataSource;

  CartRepoImp({required this.cartDataSource});

  @override
  Future<Either<Failure, bool>> addToCart(TripModel trip) async {
    try {
      final res = await cartDataSource.addToCart(trip);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, List<TripModel>>> getCartItems() async {
    try {
      final res = await cartDataSource.getCartItems();
      return Right(res);
    } catch (e) {
      print(e);
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromCart(TripModel trip) async {
    try {
      final res = await cartDataSource.removeFromCart(trip);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> removeAllCartItems() async {
    try {
      final res = await cartDataSource.removeAllCartItems();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }
}
