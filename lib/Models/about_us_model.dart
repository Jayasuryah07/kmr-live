// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  int? code;
  Data? data;

  AboutUsModel({
    this.code,
    this.data,
  });

  AboutUsModel copyWith({
    int? code,
    Data? data,
  }) =>
      AboutUsModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  String? companyName;
  String? companyDes;
  String? companyEmail;
  String? companyMobile;
  String? companyWebsite;

  Data({
    this.companyName,
    this.companyDes,
    this.companyEmail,
    this.companyMobile,
    this.companyWebsite,
  });

  Data copyWith({
    String? companyName,
    String? companyDes,
    String? companyEmail,
    String? companyMobile,
    String? companyWebsite,
  }) =>
      Data(
        companyName: companyName ?? this.companyName,
        companyDes: companyDes ?? this.companyDes,
        companyEmail: companyEmail ?? this.companyEmail,
        companyMobile: companyMobile ?? this.companyMobile,
        companyWebsite: companyWebsite ?? this.companyWebsite,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    companyName: json["company_name"],
    companyDes: json["company_des"],
    companyEmail: json["company_email"],
    companyMobile: json["company_mobile"],
    companyWebsite: json["company_website"],
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "company_des": companyDes,
    "company_email": companyEmail,
    "company_mobile": companyMobile,
    "company_website": companyWebsite,
  };
}
