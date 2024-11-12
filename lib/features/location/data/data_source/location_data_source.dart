import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maqam_v2/core/utils/api_service.dart';
import 'package:maqam_v2/features/location/data/model/location_model.dart';

abstract class LocationDataSource {
  Future<LocationModel?> getCurrentLocation();
}

class LocationDataSourceImp extends LocationDataSource {
  final ApiService apiService;
  final Location _location = Location();

  LocationDataSourceImp({required this.apiService});

  @override
  Future<LocationModel?> getCurrentLocation() async {
    if (await _enableService() && await _requestPermission()) {
      final locationData = await _location.getLocation();
      return _mapLocationData(locationData);
    }
  }

  Future<bool> _enableService() async {
    print("aaa");
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    return serviceEnabled;
  }

  Future<bool> _requestPermission() async {
    print("aaaasasd");
    PermissionStatus permission = await _location.hasPermission();
    debugPrint('Initial permission status: $permission');
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      debugPrint('Requested permission status: $permission');
    }
    return permission == PermissionStatus.granted;
  }

  LocationModel _mapLocationData(LocationData locationData) {
    return LocationModel(
      address: "address",
      id: 1,
      lat: locationData.latitude.toString(),
      long: locationData.longitude.toString(),
      userId: 1,
      userName: "userName",
    );
  }
}
