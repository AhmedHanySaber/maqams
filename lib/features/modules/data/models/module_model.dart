class ModuleModel {
  final int id;
  final String name;
  final String email;
  final bool isFeatured;
  final String imageUrl;
  final String backgroundImageUrl;
  final String phoneNumber;

  const ModuleModel({
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.isFeatured,
    required this.backgroundImageUrl,
    required this.email,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "email": email,
      "id": id,
      "is_featured": isFeatured,
      "background_image_url": backgroundImageUrl,
      "image_url": imageUrl,
      "phone_number": phoneNumber,
    };
  }

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      name: json["name"] ?? "",
      email: json["email"] ?? '',
      phoneNumber: json["phone_number"] ?? "",
      id: json["id"] ?? "",
      isFeatured: json["is_featured"] ?? false,
      imageUrl: json["image_url"],
      backgroundImageUrl: json["background_image_url"],
    );
  }
}
