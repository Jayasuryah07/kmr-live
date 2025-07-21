// To parse this JSON data, do
//
//     final categoryItemModel = categoryItemModelFromJson(jsonString);

import 'dart:convert';

CategoryItemModel categoryItemModelFromJson(String str) => CategoryItemModel.fromJson(json.decode(str));

String categoryItemModelToJson(CategoryItemModel data) => json.encode(data.toJson());

class CategoryItemModel {
  int? code;
  List<CategoryItem>? data;

  CategoryItemModel({
    this.code,
    this.data,
  });

  CategoryItemModel copyWith({
    int? code,
    List<CategoryItem>? data,
  }) =>
      CategoryItemModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) => CategoryItemModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<CategoryItem>.from(json["data"]!.map((x) => CategoryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryItem {
  DateTime? vendorProductUpdatedDate;
  String? vendorProductUpdatedTime;
  int? vendorProductRate;

  CategoryItem({
    this.vendorProductUpdatedDate,
    this.vendorProductUpdatedTime,
    this.vendorProductRate,
  });

  CategoryItem copyWith({
    DateTime? vendorProductUpdatedDate,
    String? vendorProductUpdatedTime,
    int? vendorProductRate,
  }) =>
      CategoryItem(
        vendorProductUpdatedDate: vendorProductUpdatedDate ?? this.vendorProductUpdatedDate,
        vendorProductUpdatedTime: vendorProductUpdatedTime ?? this.vendorProductUpdatedTime,
        vendorProductRate: vendorProductRate ?? this.vendorProductRate,
      );

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    vendorProductUpdatedDate: json["vendor_product_updated_date"] == null ? null : DateTime.parse(json["vendor_product_updated_date"]),
    vendorProductUpdatedTime: json["vendor_product_updated_time"],
    vendorProductRate: json["vendor_product_rate"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_product_updated_date": "${vendorProductUpdatedDate!.year.toString().padLeft(4, '0')}-${vendorProductUpdatedDate!.month.toString().padLeft(2, '0')}-${vendorProductUpdatedDate!.day.toString().padLeft(2, '0')}",
    "vendor_product_updated_time": vendorProductUpdatedTime,
    "vendor_product_rate": vendorProductRate,
  };
}
