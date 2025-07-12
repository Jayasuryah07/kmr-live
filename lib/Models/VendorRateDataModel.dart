// To parse this JSON data, do
//
//     final vendorRateModel = vendorRateModelFromJson(jsonString);

import 'dart:convert';

VendorRateModel vendorRateModelFromJson(String str) => VendorRateModel.fromJson(json.decode(str));

String vendorRateModelToJson(VendorRateModel data) => json.encode(data.toJson());

class VendorRateModel {
  int? code;
  List<SubCatg>? subCatg;
  List<VendorRateDataModel>? data;

  VendorRateModel({
    this.code,
    this.subCatg,
    this.data,
  });

  VendorRateModel copyWith({
    int? code,
    List<SubCatg>? subCatg,
    List<VendorRateDataModel>? data,
  }) =>
      VendorRateModel(
        code: code ?? this.code,
        subCatg: subCatg ?? this.subCatg,
        data: data ?? this.data,
      );

  factory VendorRateModel.fromJson(Map<String, dynamic> json) => VendorRateModel(
    code: json["code"],
    subCatg: json["subCatg"] == null ? [] : List<SubCatg>.from(json["subCatg"]!.map((x) => SubCatg.fromJson(x))),
    data: json["data"] == null ? [] : List<VendorRateDataModel>.from(json["data"]!.map((x) => VendorRateDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "subCatg": subCatg == null ? [] : List<dynamic>.from(subCatg!.map((x) => x.toJson())),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class VendorRateDataModel {
  String? vendorName;
  int? id;
  VendorCategory? vendorCategory;
  String? vendorMobile;
  String? vendorEmail;
  String? vendorCity;
  DateTime? vendorCreatedDate;
  String? vendorCreatedTime;
  dynamic vendorUpdatedDate;
  dynamic vendorUpdatedTime;
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

  VendorRateDataModel copyWith({
    String? vendorName,
    int? id,
    VendorCategory? vendorCategory,
    String? vendorMobile,
    String? vendorEmail,
    String? vendorCity,
    DateTime? vendorCreatedDate,
    String? vendorCreatedTime,
    dynamic vendorUpdatedDate,
    dynamic vendorUpdatedTime,
    List<VendorProduct>? vendorProduct,
  }) =>
      VendorRateDataModel(
        vendorName: vendorName ?? this.vendorName,
        id: id ?? this.id,
        vendorCategory: vendorCategory ?? this.vendorCategory,
        vendorMobile: vendorMobile ?? this.vendorMobile,
        vendorEmail: vendorEmail ?? this.vendorEmail,
        vendorCity: vendorCity ?? this.vendorCity,
        vendorCreatedDate: vendorCreatedDate ?? this.vendorCreatedDate,
        vendorCreatedTime: vendorCreatedTime ?? this.vendorCreatedTime,
        vendorUpdatedDate: vendorUpdatedDate ?? this.vendorUpdatedDate,
        vendorUpdatedTime: vendorUpdatedTime ?? this.vendorUpdatedTime,
        vendorProduct: vendorProduct ?? this.vendorProduct,
      );

  factory VendorRateDataModel.fromJson(Map<String, dynamic> json) => VendorRateDataModel(
    vendorName: json["vendor_name"],
    id: json["id"],
    vendorCategory: vendorCategoryValues.map[json["vendor_category"]],
    vendorMobile: json["vendor_mobile"],
    vendorEmail: json["vendor_email"],
    vendorCity: json["vendor_city"],
    vendorCreatedDate: json["vendor_created_date"] == null ? null : DateTime.parse(json["vendor_created_date"]),
    vendorCreatedTime: json["vendor_created_time"],
    vendorUpdatedDate: json["vendor_updated_date"],
    vendorUpdatedTime: json["vendor_updated_time"],
    vendorProduct: json["vendor__product"] == null ? [] : List<VendorProduct>.from(json["vendor__product"]!.map((x) => VendorProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vendor_name": vendorName,
    "id": id,
    "vendor_category": vendorCategoryValues.reverse[vendorCategory],
    "vendor_mobile": vendorMobile,
    "vendor_email": vendorEmail,
    "vendor_city": vendorCity,
    "vendor_created_date": "${vendorCreatedDate!.year.toString().padLeft(4, '0')}-${vendorCreatedDate!.month.toString().padLeft(2, '0')}-${vendorCreatedDate!.day.toString().padLeft(2, '0')}",
    "vendor_created_time": vendorCreatedTime,
    "vendor_updated_date": vendorUpdatedDate,
    "vendor_updated_time": vendorUpdatedTime,
    "vendor__product": vendorProduct == null ? [] : List<dynamic>.from(vendorProduct!.map((x) => x.toJson())),
  };
}

enum VendorCategory {
  OIL
}

final vendorCategoryValues = EnumValues({
  "Oil": VendorCategory.OIL
});

class VendorProduct {
  int? id;
  int? vendorId;
  VendorProductCategorySub? vendorProductCategorySub;
  String? vendorProduct;
  String? vendorProductSize;
  dynamic vendorProductRate;
  String? categoriesSubImages;

  VendorProduct({
    this.id,
    this.vendorId,
    this.vendorProductCategorySub,
    this.vendorProduct,
    this.vendorProductSize,
    this.vendorProductRate,
    this.categoriesSubImages,
  });

  VendorProduct copyWith({
    int? id,
    int? vendorId,
    VendorProductCategorySub? vendorProductCategorySub,
    String? vendorProduct,
    String? vendorProductSize,
    String? categoriesSubImages,
    int? vendorProductRate,
  }) =>
      VendorProduct(
        id: id ?? this.id,
        vendorId: vendorId ?? this.vendorId,
        vendorProductCategorySub: vendorProductCategorySub ?? this.vendorProductCategorySub,
        vendorProduct: vendorProduct ?? this.vendorProduct,
        vendorProductSize: vendorProductSize ?? this.vendorProductSize,
        vendorProductRate: vendorProductRate ?? this.vendorProductRate,
        categoriesSubImages: categoriesSubImages ?? this.categoriesSubImages,
      );

  factory VendorProduct.fromJson(Map<String, dynamic> json) => VendorProduct(
    id: json["id"],
    vendorId: json["vendor_id"],
    vendorProductCategorySub: vendorProductCategorySubValues.map[json["vendor_product_category_sub"]],
    vendorProduct: json["vendor_product"],
    vendorProductSize: json["vendor_product_size"],
    vendorProductRate: json["vendor_product_rate"],
    categoriesSubImages: json["categories_sub_images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "vendor_product_category_sub": vendorProductCategorySubValues.reverse[vendorProductCategorySub],
    "vendor_product": vendorProduct,
    "vendor_product_size": vendorProductSize,
    "vendor_product_rate": vendorProductRate,
    "categories_sub_images": categoriesSubImages,
  };
}

enum VendorProductCategorySub {
  EDIBLE_OIL
}

final vendorProductCategorySubValues = EnumValues({
  "edible Oil": VendorProductCategorySub.EDIBLE_OIL
});

class SubCatg {
  String? vendorProductCategorySub;
  String? categoriesSubImages;

  SubCatg({
    this.vendorProductCategorySub,
    this.categoriesSubImages,
  });

  SubCatg copyWith({
    String? vendorProductCategorySub,
    String? categoriesSubImages,
  }) =>
      SubCatg(
        vendorProductCategorySub: vendorProductCategorySub ?? this.vendorProductCategorySub,
        categoriesSubImages: categoriesSubImages ?? this.categoriesSubImages,
      );

  factory SubCatg.fromJson(Map<String, dynamic> json) => SubCatg(
    vendorProductCategorySub: json["vendor_product_category_sub"],
    categoriesSubImages: json["categories_sub_images"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_product_category_sub": vendorProductCategorySub,
    "categories_sub_images": categoriesSubImages,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
