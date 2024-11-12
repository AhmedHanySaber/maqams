class MaqamEntity {
  final String name;
  final String trip;
  final String description;
  final List<String> images;

  MaqamEntity(
      {required this.name,
        required this.trip,
        required this.description,
        required this.images});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "trip": trip,
      "description": description,
      "image": images,
    };
  }

  factory MaqamEntity.fromMap(Map<String, dynamic> map) {
    return MaqamEntity(
      description: map["description"] ?? '',
      name: map['name'] ?? '',
      trip: map["trip"] ?? '',
      images: List<String>.from(
        (map["image"] ?? []),
      ),
    );
  }
}