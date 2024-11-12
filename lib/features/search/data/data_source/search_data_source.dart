import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';

abstract class SearchDataSource {
  Stream<Iterable<TripModel>> streamTripsByName({required String name});
}

class SearchDataSourceImp extends SearchDataSource {
  final FirebaseFirestore firestore;

  SearchDataSourceImp({required this.firestore});

  @override
  Stream<Iterable<TripModel>> streamTripsByName({required String name}) {
    final controller = StreamController<Iterable<TripModel>>();
    late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>> sub;
    if (name.isEmpty || name == "") {
      controller.sink.add([]);
    } else {
      sub = firestore
          .collection("trip")
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: "$name\uf8ff")
          .snapshots()
          .listen((snapshot) {
        final Iterable<TripModel> trips;
        trips = snapshot.docs.map(
          (tripData) => TripModel.fromMap(
            tripData.data(),
          ),
        );
        controller.sink.add(trips);
      });
    }
    controller.onCancel = () {
      sub.cancel();
      controller.close();
    };

    return controller.stream;
  }
}
