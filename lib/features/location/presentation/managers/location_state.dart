import 'package:maqam_v2/features/location/data/model/location_model.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationModel model;

  LocationLoaded({required this.model});
}

class LocationError extends LocationState {
  final String message;

  LocationError({required this.message});
}
