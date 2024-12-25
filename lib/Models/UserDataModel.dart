// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String? token;
  User? user;

  UserDataModel({
    this.token,
    this.user,
  });

  factory UserDataModel.fromJson(Map<dynamic, dynamic> json) => UserDataModel(
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? vendorId;
  int? userType;
  String? status;
  DateTime? emailVerifiedAt;
  String? cpassword;
  String? token;
  String? deviceId;
  String? trail;
  DateTime? registerDate;
  DateTime? lastLogin;
  DateTime? validityDate;
  String? remarks;
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;

  User({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.vendorId,
    this.userType,
    this.status,
    this.emailVerifiedAt,
    this.cpassword,
    this.token,
    this.deviceId,
    this.trail,
    this.registerDate,
    this.lastLogin,
    this.validityDate,
    this.remarks,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    vendorId: json["vendor_id"],
    userType: json["user_type"],
    status: json["status"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    cpassword: json["cpassword"],
    token: json["token"],
    deviceId: json["device_id"],
    trail: json["trail"],
    registerDate: json["register_date"] == null ? null : DateTime.parse(json["register_date"]),
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    validityDate: json["validity_date"] == null ? null : DateTime.parse(json["validity_date"]),
    remarks: json["remarks"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedBy: json["updated_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "vendor_id": vendorId,
    "user_type": userType,
    "status": status,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "cpassword": cpassword,
    "token": token,
    "device_id": deviceId,
    "trail": trail,
    "register_date": registerDate?.toIso8601String(),
    "last_login": lastLogin?.toIso8601String(),
    "validity_date": validityDate?.toIso8601String(),
    "remarks": remarks,
    "created_at": createdAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "updated_by": updatedBy,
  };
}
