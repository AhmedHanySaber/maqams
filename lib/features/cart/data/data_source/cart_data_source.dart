import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../trips/data/model/trip_model.dart';

abstract class CartDataSource {
  /// to be exchanged with tripId in apis version
  Future<bool> addToCart(TripModel trip);

  /// to be exchanged with tripId in apis version
  Future<bool> removeFromCart(TripModel trip);

  Future<bool> removeAllCartItems();

  Future<List<TripModel>> getCartItems();
}

class CartDataSourceImp extends CartDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartDataSourceImp({required this.firestore, required this.auth});

  @override
  Future<bool> addToCart(TripModel trip) async {
    await firestore
        .collection("user")
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc("${trip.name}&${trip.location}")
        .set(trip.toMap());
    return true;
  }

  @override
  Future<List<TripModel>> getCartItems() async {
    final data = await firestore
        .collection("user")
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .get();

    final tripList =
        data.docs.map((doc) => TripModel.fromMap(doc.data())).toList();
    print(tripList.length);
    return tripList;
  }

  @override
  Future<bool> removeAllCartItems() async {
    firestore.collection("user").doc(auth.currentUser!.uid).collection("cart");
    return true;
  }

  @override
  Future<bool> removeFromCart(TripModel trip) async {
    await firestore
        .collection("user")
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc("${trip.name}&${trip.location}")
        .delete();
    return true;
  }
}
