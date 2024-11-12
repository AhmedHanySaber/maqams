class LocationModel {
  final String address;
  final int id;
  final String lat;
  final String long;
  final int userId;
  final String userName;

  LocationModel({
    required this.address,
    required this.id,
    required this.lat,
    required this.long,
    required this.userId,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "address": address,
      "id": id,
      "lat": lat,
      "long": long,
      "user_id": userId,
      "user_name": userName,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      address: map["address"] as String,
      id: map["id"] as int,
      lat: map["lat"] as String,
      long: map["long"] as String,
      userId: map["userId"] as int,
      userName: map["userName"] as String,
    );
  }
}
