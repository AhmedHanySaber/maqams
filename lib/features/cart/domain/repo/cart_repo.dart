import 'package:dartz/dartz.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';

abstract class CartRepo {
  Future<Either<Failure,bool>> addToCart(TripModel trip);

  Future<Either<Failure,bool>> removeFromCart(TripModel trip);
  Future<Either<Failure,bool>> removeAllCartItems();

  Future<Either<Failure,List<TripModel>>> getCartItems();
}
