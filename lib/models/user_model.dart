// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? code;
  Data? data;

  UserModel({
    this.code,
    this.data,
  });

  UserModel copyWith({
    int? code,
    Data? data,
  }) =>
      UserModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? email;
  dynamic city;
  DateTime? validityDate;

  Data({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.city,
    this.validityDate,
  });

  Data copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    dynamic city,
    DateTime? validityDate,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        city: city ?? this.city,
        validityDate: validityDate ?? this.validityDate,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    city: json["city"],
    validityDate: json["validity_date"] == null ? null : DateTime.parse(json["validity_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "city": city,
    "validity_date": "${validityDate!.year.toString().padLeft(4, '0')}-${validityDate!.month.toString().padLeft(2, '0')}-${validityDate!.day.toString().padLeft(2, '0')}",
  };
}
