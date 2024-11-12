import 'dart:convert';

class NotificationEntity {
  final int id;
  final String title;
  final String logo;
  final String description;
  final int seen;
  final int related;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.logo,
    required this.description,
    required this.seen,
    required this.related,
  });

  factory NotificationEntity.fromNotificationModel(NotificationModel model) {
    return NotificationEntity(
      id: model.id,
      title: model.title,
      logo: model.logo,
      description: model.description,
      seen: model.seen,
      related: model.related,
    );
  }
}

class NotificationModel {
  final int id;
  final int customerId;
  final String title;
  final String logo;
  final String description;
  final String type;
  final int seen;
  final int related;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.id,
    required this.customerId,
    required this.title,
    required this.logo,
    required this.description,
    required this.type,
    required this.seen,
    required this.related,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        customerId: json["customer_id"],
        title: json["title"],
        logo: json["logo"],
        description: json["description"],
        type: json["type"],
        seen: json["seen"],
        related: json["related"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "title": title,
        "logo": logo,
        "description": description,
        "type": type,
        "seen": seen,
        "related": related,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}


List<NotificationModel> notifications = [
  NotificationModel(
    id: 1,
    customerId: 1,
    title: "تم انشاء الطلب جارى المراجعه",
    logo: "https://loan.salfny-kw.com/images/1715301529.png",
    description: "تم انشاء الطلب جارى المراجعه",
    type: "order",
    seen: 1,
    related: 1,
    createdAt: "2024-06-06T09:32:53.000000Z",
    updatedAt: "2024-06-06T14:31:36.000000Z",
  ),
  NotificationModel(
    id: 2,
    customerId: 1,
    title: "تم انشاء الطلب جارى المراجعه",
    logo: "https://loan.salfny-kw.com/images/1715301529.png",
    description: "تم انشاء الطلب جارى المراجعه",
    type: "order",
    seen: 1,
    related: 2,
    createdAt: "2024-06-06T14:54:01.000000Z",
    updatedAt: "2024-06-08T02:53:38.000000Z",
  ),
  NotificationModel(
    id: 3,
    customerId: 1,
    title: "تم انشاء الطلب جارى المراجعه",
    logo: "https://loan.salfny-kw.com/images/1715301529.png",
    description: "تم انشاء الطلب جارى المراجعه",
    type: "order",
    seen: 1,
    related: 3,
    createdAt: "2024-06-08T03:10:46.000000Z",
    updatedAt: "2024-06-08T03:10:57.000000Z",
  ),
  NotificationModel(
    id: 4,
    customerId: 1,
    title: "تم انشاء الطلب جارى المراجعه",
    logo: "https://loan.salfny-kw.com/images/1715301529.png",
    description: "تم انشاء الطلب جارى المراجعه",
    type: "order",
    seen: 1,
    related: 4,
    createdAt: "2024-06-09T12:24:28.000000Z",
    updatedAt: "2024-06-09T12:24:41.000000Z",
  ),
  NotificationModel(
    id: 5,
    customerId: 1,
    title: "تم انشاء الطلب جارى المراجعه",
    logo: "https://loan.salfny-kw.com/images/1715301529.png",
    description: "تم انشاء الطلب جارى المراجعه",
    type: "order",
    seen: 1,
    related: 5,
    createdAt: "2024-06-09T16:34:35.000000Z",
    updatedAt: "2024-06-11T22:46:20.000000Z",
  ),
];

