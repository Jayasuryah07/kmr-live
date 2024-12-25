// To parse this JSON data, do
//
//     final vendorRateDataModel = vendorRateDataModelFromJson(jsonString);

import 'dart:convert';

VendorRateDataModel vendorRateDataModelFromJson(String str) => VendorRateDataModel.fromJson(json.decode(str));

String vendorRateDataModelToJson(VendorRateDataModel data) => json.encode(data.toJson());

class VendorRateDataModel {
  String? vendorName;
  int? id;
  String? vendorCategory;
  String? vendorMobile;
  String? vendorEmail;
  String? vendorCity;
  DateTime? vendorCreatedDate;
  String? vendorCreatedTime;
  DateTime? vendorUpdatedDate;
  String? vendorUpdatedTime;
  List<VendorProduct>? vendorProduct;

  VendorRateDataModel({
    this.vendorName,
    this.id,
    this.vendorCategory,
    this.vendorMobile,
    this.vendorEmail,
    this.vendorCity,
    this.vendorCreatedDate,
    this.vendorCreatedTime,
    this.vendorUpdatedDate,
    this.vendorUpdatedTime,
    this.vendorProduct,
  });

  factory VendorRateDataModel.fromJson(Map<String, dynamic> json) => VendorRateDataModel(
    vendorName: json["vendor_name"],
    id: json["id"],
    vendorCategory: json["vendor_category"],
    vendorMobile: json["vendor_mobile"],
    vendorEmail: json["vendor_email"],
    vendorCity: json["vendor_city"],
    vendorCreatedDate: json["vendor_created_date"] == null ? null : DateTime.parse(json["vendor_created_date"]),
    vendorCreatedTime: json["vendor_created_time"],
    vendorUpdatedDate: json["vendor_updated_date"] == null ? null : DateTime.parse(json["vendor_updated_date"]),
    vendorUpdatedTime: json["vendor_updated_time"],
    vendorProduct: json["vendor__product"] == null ? [] : List<VendorProduct>.from(json["vendor__product"]!.map((x) => VendorProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vendor_name": vendorName,
    "id": id,
    "vendor_category": vendorCategory,
    "vendor_mobile": vendorMobile,
    "vendor_email": vendorEmail,
    "vendor_city": vendorCity,
    "vendor_created_date": vendorCreatedDate?.toIso8601String(),
    "vendor_created_time": vendorCreatedTime,
    "vendor_updated_date": vendorUpdatedDate?.toIso8601String(),
    "vendor_updated_time": vendorUpdatedTime,
    "vendor__product": vendorProduct == null ? [] : List<dynamic>.from(vendorProduct!.map((x) => x.toJson())),
  };
}

class VendorProduct {
  int? id;
  int? vendorId;
  String? vendorProductCategorySub;
  String? vendorProduct;
  String? vendorProductSize;
  num? vendorProductRate;

  VendorProduct({
    this.id,
    this.vendorId,
    this.vendorProductCategorySub,
    this.vendorProduct,
    this.vendorProductSize,
    this.vendorProductRate,
  });

  factory VendorProduct.fromJson(Map<String, dynamic> json) => VendorProduct(
    id: json["id"],
    vendorId: json["vendor_id"],
    vendorProductCategorySub: json["vendor_product_category_sub"],
    vendorProduct: json["vendor_product"],
    vendorProductSize: json["vendor_product_size"],
    vendorProductRate: json["vendor_product_rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "vendor_product_category_sub": vendorProductCategorySub,
    "vendor_product": vendorProduct,
    "vendor_product_size": vendorProductSize,
    "vendor_product_rate": vendorProductRate,
  };
}
