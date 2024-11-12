class LocationEntity {
  final String location;

  LocationEntity({required this.location});

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      location: json['location'],
    );
  }
}
