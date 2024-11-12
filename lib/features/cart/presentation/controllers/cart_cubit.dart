import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/cart/domain/repo/cart_repo.dart';
import 'package:maqam_v2/features/cart/presentation/controllers/cart_state.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;

  CartCubit(this.cartRepo) : super(CartInitial());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  List<TripModel> cartItems = [];

  Future<bool> addToCart(TripModel trip) async {
    emit(AddLoading());
    final res = await cartRepo.addToCart(trip);
    return res.fold((l) {
      emit(AddError(error: "unable to add to the cart"));
      const SnackBar(
        content: Text('unable to add to the cart'),
        backgroundColor: Colors.red,
      );
      return false;
    }, (r) {
      emit(AddSuccess());
      const SnackBar(
        content: Text('item has been added successfully'),
        backgroundColor: Colors.green,
      );
      return true;
    });
  }

  Future<bool> remove(TripModel trip) async {
    emit(RemoveLoading());
    final res = await cartRepo.removeFromCart(trip);
    return res.fold((l) {
      emit(RemoveError(error: "unable to remove ${trip.name}"));
      return false;
    }, (r) {
      emit(RemoveSuccess());
      return true;
    });
  }

  Future<bool> removeAllCart() async {
    emit(RemoveLoading());
    final res = await cartRepo.removeAllCartItems();
    return res.fold((l) {
      emit(RemoveError(error: "unable to remove"));
      return false;
    }, (r) {
      emit(RemoveSuccess());
      return true;
    });
  }

  Future<List<TripModel>> getItems() async {
    emit(GetCartLoading());
    final res = await cartRepo.getCartItems();
    return res.fold((l) {
      emit(GetCartError(error: l.message));
      return cartItems;
    }, (r) {
      cartItems = r;
      emit(GetCartSuccess(trips: cartItems));
      return cartItems;
    });
  }

  bool isTripInCart(TripModel tripToCheck) =>
      cartItems.any((tripInCart) => tripInCart.name == tripToCheck.name);
}
