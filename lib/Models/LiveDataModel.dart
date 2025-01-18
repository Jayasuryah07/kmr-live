// To parse this JSON data, do
//
//     final liveDataListModel = liveDataListModelFromJson(jsonString);

import 'dart:convert';

import 'VendorRateDataModel.dart';

LiveDataListModel liveDataListModelFromJson(String str) => LiveDataListModel.fromJson(json.decode(str));

String liveDataListModelToJson(LiveDataListModel data) => json.encode(data.toJson());

class LiveDataListModel {
  int? code;
  List<SubCatg>? subCatg;
  List<LiveDataModel>? data;

  LiveDataListModel({
    this.code,
    this.subCatg,
    this.data,
  });

  LiveDataListModel copyWith({
    int? code,
    List<SubCatg>? subCatg,
    List<LiveDataModel>? data,
  }) =>
      LiveDataListModel(
        code: code ?? this.code,
        subCatg: subCatg ?? this.subCatg,
        data: data ?? this.data,
      );

  factory LiveDataListModel.fromJson(Map<String, dynamic> json) => LiveDataListModel(
    code: json["code"],
    subCatg: json["subCatg"] == null ? [] : List<SubCatg>.from(json["subCatg"]!.map((x) => SubCatg.fromJson(x))),
    data: json["data"] == null ? [] : List<LiveDataModel>.from(json["data"]!.map((x) => LiveDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "subCatg": subCatg == null ? [] : List<dynamic>.from(subCatg!.map((x) => x.toJson())),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LiveDataModel {
  int? id;
  int? vendorId;
  String? vendorName;
  VendorProductCategory? vendorProductCategory;
  VendorProductCategorySub? vendorProductCategorySub;
  String? vendorProduct;
  String? vendorProductSize;
  double? vendorProductRate;
  int? oldVendorProductRate;
  DateTime? vendorProductCreatedDate;
  String? vendorProductCreatedTime;
  DateTime? vendorProductUpdatedDate;
  String? vendorProductUpdatedTime;

  LiveDataModel({
    this.id,
    this.vendorId,
    this.vendorName,
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

  LiveDataModel copyWith({
    int? id,
    int? vendorId,
    String? vendorName,
    VendorProductCategory? vendorProductCategory,
    VendorProductCategorySub? vendorProductCategorySub,
    String? vendorProduct,
    String? vendorProductSize,
    double? vendorProductRate,
    int? oldVendorProductRate,
    DateTime? vendorProductCreatedDate,
    String? vendorProductCreatedTime,
    DateTime? vendorProductUpdatedDate,
    String? vendorProductUpdatedTime,
  }) =>
      LiveDataModel(
        id: id ?? this.id,
        vendorId: vendorId ?? this.vendorId,
        vendorName: vendorName ?? this.vendorName,
        vendorProductCategory: vendorProductCategory ?? this.vendorProductCategory,
        vendorProductCategorySub: vendorProductCategorySub ?? this.vendorProductCategorySub,
        vendorProduct: vendorProduct ?? this.vendorProduct,
        vendorProductSize: vendorProductSize ?? this.vendorProductSize,
        vendorProductRate: vendorProductRate ?? this.vendorProductRate,
        oldVendorProductRate: oldVendorProductRate ?? this.oldVendorProductRate,
        vendorProductCreatedDate: vendorProductCreatedDate ?? this.vendorProductCreatedDate,
        vendorProductCreatedTime: vendorProductCreatedTime ?? this.vendorProductCreatedTime,
        vendorProductUpdatedDate: vendorProductUpdatedDate ?? this.vendorProductUpdatedDate,
        vendorProductUpdatedTime: vendorProductUpdatedTime ?? this.vendorProductUpdatedTime,
      );

  factory LiveDataModel.fromJson(Map<String, dynamic> json) => LiveDataModel(
    id: json["id"],
    vendorId: json["vendor_id"],
    vendorName: json["vendor_name"],
    vendorProductCategory: vendorProductCategoryValues.map[json["vendor_product_category"]],
    vendorProductCategorySub: vendorProductCategorySubValues.map[json["vendor_product_category_sub"]],
    vendorProduct: json["vendor_product"],
    vendorProductSize: json["vendor_product_size"],
    vendorProductRate: json["vendor_product_rate"]?.toDouble(),
    oldVendorProductRate: json["old_vendor_product_rate"],
    vendorProductCreatedDate: json["vendor_product_created_date"] == null ? null : DateTime.parse(json["vendor_product_created_date"]),
    vendorProductCreatedTime: json["vendor_product_created_time"],
    vendorProductUpdatedDate: json["vendor_product_updated_date"] == null ? null : DateTime.parse(json["vendor_product_updated_date"]),
    vendorProductUpdatedTime: json["vendor_product_updated_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "vendor_name": vendorName,
    "vendor_product_category": vendorProductCategoryValues.reverse[vendorProductCategory],
    "vendor_product_category_sub": vendorProductCategorySubValues.reverse[vendorProductCategorySub],
    "vendor_product": vendorProduct,
    "vendor_product_size": vendorProductSize,
    "vendor_product_rate": vendorProductRate,
    "old_vendor_product_rate": oldVendorProductRate,
    "vendor_product_created_date": "${vendorProductCreatedDate!.year.toString().padLeft(4, '0')}-${vendorProductCreatedDate!.month.toString().padLeft(2, '0')}-${vendorProductCreatedDate!.day.toString().padLeft(2, '0')}",
    "vendor_product_created_time": vendorProductCreatedTime,
    "vendor_product_updated_date": "${vendorProductUpdatedDate!.year.toString().padLeft(4, '0')}-${vendorProductUpdatedDate!.month.toString().padLeft(2, '0')}-${vendorProductUpdatedDate!.day.toString().padLeft(2, '0')}",
    "vendor_product_updated_time": vendorProductUpdatedTime,
  };
}

enum VendorProductCategory {
  OIL
}

final vendorProductCategoryValues = EnumValues({
  "Oil": VendorProductCategory.OIL
});

enum VendorProductCategorySub {
  EDIBLE_OIL
}

final vendorProductCategorySubValues = EnumValues({
  "edible Oil": VendorProductCategorySub.EDIBLE_OIL
});



class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
