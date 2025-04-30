// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  int? code;
  List<NotificationData>? data;

  NotificationModel({
    this.code,
    this.data,
  });

  NotificationModel copyWith({
    int? code,
    List<NotificationData>? data,
  }) =>
      NotificationModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationData {
  int? id;
  DateTime? notificationCreateDate;
  String? notificationHeading;
  String? notificationDescription;
  String? notificationImage;

  NotificationData({
    this.id,
    this.notificationCreateDate,
    this.notificationHeading,
    this.notificationDescription,
    this.notificationImage,
  });

  NotificationData copyWith({
    int? id,
    DateTime? notificationCreateDate,
    String? notificationHeading,
    String? notificationDescription,
    String? notificationImage,
  }) =>
      NotificationData(
        id: id ?? this.id,
        notificationCreateDate: notificationCreateDate ?? this.notificationCreateDate,
        notificationHeading: notificationHeading ?? this.notificationHeading,
        notificationDescription: notificationDescription ?? this.notificationDescription,
        notificationImage: notificationImage ?? this.notificationImage,
      );

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    notificationCreateDate: json["notification_create_date"] == null ? null : DateTime.parse(json["notification_create_date"]),
    notificationHeading: json["notification_heading"],
    notificationDescription: json["notification_description"],
    notificationImage: json["notification_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "notification_create_date": "${notificationCreateDate!.year.toString().padLeft(4, '0')}-${notificationCreateDate!.month.toString().padLeft(2, '0')}-${notificationCreateDate!.day.toString().padLeft(2, '0')}",
    "notification_heading": notificationHeading,
    "notification_description": notificationDescription,
    "notification_image": notificationImage,
  };
}
