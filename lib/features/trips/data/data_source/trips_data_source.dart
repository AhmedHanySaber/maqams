import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maqam_v2/features/trips/domain/entity/location.dart';
import 'package:maqam_v2/features/trips/domain/entity/maqam_entity.dart';

import '../model/trip_model.dart';

abstract class TripsDataSource {
  Stream<Iterable<TripModel>> getTrips();

  Stream<Iterable<TripModel>> getTripsByName({required String name});

  Stream<Iterable<MaqamEntity>> getMaqam(String tripName);

  List<TripModel> filterTrips(List<TripModel> trips, String location);

  Future<List<LocationEntity>> getLocations();
}

class TripsDataSourceImp extends TripsDataSource {
  final FirebaseFirestore firestore;

  TripsDataSourceImp({required this.firestore});

  @override
  Stream<Iterable<TripModel>> getTrips() {
    final controller = StreamController<Iterable<TripModel>>();

    final sub = firestore.collection("trip").snapshots().listen((snapshot) {
      final trips = snapshot.docs.map(
        (tripData) => TripModel.fromMap(
          tripData.data(),
        ),
      );
      controller.sink.add(trips);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Stream<Iterable<TripModel>> getTripsByName({required String name}) {
    final controller = StreamController<Iterable<TripModel>>();

    final sub = firestore
        .collection("trip")
        .where("name", isGreaterThanOrEqualTo: name)
        .where("name", isLessThanOrEqualTo: "$name\uf8ff")
        .snapshots()
        .listen((snapshot) {
      final trips = snapshot.docs.map(
        (tripData) => TripModel.fromMap(
          tripData.data(),
        ),
      );
      controller.sink.add(trips);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  List<TripModel> filterTrips(List<TripModel> trips, String location) {
    List<TripModel> filterTrips = [];
    for (int i = 0; i < trips.length; i++) {
      if (trips[i].location == location) {
        filterTrips.add(trips[i]);
      }
    }
    return filterTrips;
  }

  @override
  Future<List<LocationEntity>> getLocations() async {
    QuerySnapshot querySnapshot = await firestore.collection('locations').get();
    print(querySnapshot);
    return querySnapshot.docs.map((doc) {
      return LocationEntity.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Stream<Iterable<MaqamEntity>> getMaqam(String tripName) {
    final controller = StreamController<Iterable<MaqamEntity>>();

    final sub = firestore
        .collection("maqam")
        .where("trip", isEqualTo: tripName)
        .snapshots()
        .listen((snapshot) {
      final maqamat = snapshot.docs.map(
        (maqamData) => MaqamEntity.fromMap(
          maqamData.data(),
        ),
      );
      controller.sink.add(maqamat);
    });

    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }
}
