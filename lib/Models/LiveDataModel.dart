// To parse this JSON data, do
//
//     final liveDataModel = liveDataModelFromJson(jsonString);

import 'dart:convert';

LiveDataModel liveDataModelFromJson(String str) => LiveDataModel.fromJson(json.decode(str));

String liveDataModelToJson(LiveDataModel data) => json.encode(data.toJson());

class LiveDataModel {
  int? id;
  int? vendorId;
  String? vendorProductCategory;
  String? vendorProductCategorySub;
  String? vendorProduct;
  String? vendorProductSize;
  num? vendorProductRate;
  num? oldVendorProductRate;
  DateTime? vendorProductCreatedDate;
  String? vendorProductCreatedTime;
  DateTime? vendorProductUpdatedDate;
  String? vendorProductUpdatedTime;

  LiveDataModel({
    this.id,
    this.vendorId,
    this.vendorProductCategory,
    this.vendorProductCategorySub,
    this.vendorProduct,
    this.vendorProductSize,
    this.vendorProductRate,
    this.oldVendorProductRate,
    this.vendorProductCreatedDate,
    this.vendorProductCreatedTime,
    this.vendorProductUpdatedDate,
    this.vendorProductUpdatedTime,
  });

  factory LiveDataModel.fromJson(Map<String, dynamic> json) => LiveDataModel(
    id: json["id"],
    vendorId: json["vendor_id"],
    vendorProductCategory: json["vendor_product_category"],
    vendorProductCategorySub: json["vendor_product_category_sub"],
    vendorProduct: json["vendor_product"],
    vendorProductSize: json["vendor_product_size"],
    vendorProductRate: json["vendor_product_rate"],
    oldVendorProductRate: json["old_vendor_product_rate"],
    vendorProductCreatedDate: json["vendor_product_created_date"] == null ? null : DateTime.parse(json["vendor_product_created_date"]),
    vendorProductCreatedTime: json["vendor_product_created_time"],
    vendorProductUpdatedDate: json["vendor_product_updated_date"] == null ? null : DateTime.parse(json["vendor_product_updated_date"]),
    vendorProductUpdatedTime: json["vendor_product_updated_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "vendor_product_category": vendorProductCategory,
    "vendor_product_category_sub": vendorProductCategorySub,
    "vendor_product": vendorProduct,
    "vendor_product_size": vendorProductSize,
    "vendor_product_rate": vendorProductRate,
    "old_vendor_product_rate": oldVendorProductRate,
    "vendor_product_created_date": vendorProductCreatedDate?.toIso8601String(),
    "vendor_product_created_time": vendorProductCreatedTime,
    "vendor_product_updated_date": vendorProductUpdatedDate?.toIso8601String(),
    "vendor_product_updated_time": vendorProductUpdatedTime,
  };
}
