class TripModel {
  final String name;
  final String location;
  final String description;
  final double price;
  final List<String> images;

  TripModel({
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "location": location,
      "description": description,
      "image": images,
      "price": price
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      description: map["description"] ?? '',
      name: map['name'] ?? '',
      location: map["location"] ?? '',
      price: map["price"],
      images: List<String>.from(
        (map["image"] ?? []),
      ),
    );
  }
}
