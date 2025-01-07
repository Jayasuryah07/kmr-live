// To parse this JSON data, do
//
//     final subCategoryDataModel = subCategoryDataModelFromJson(jsonString);

import 'dart:convert';

class SubCategoryModel {
  int? code;
  List<SubCategoryDataModel>? data;

  SubCategoryModel({
    this.code,
    this.data,
  });

  SubCategoryModel copyWith({
    int? code,
    List<SubCategoryDataModel>? data,
  }) =>
      SubCategoryModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory SubCategoryModel.fromRawJson(String str) => SubCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<SubCategoryDataModel>.from(json["data"]!.map((x) => SubCategoryDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubCategoryDataModel {
  String? vendorProductCategorySub;
  String? categoriesSubImages;

  SubCategoryDataModel({
    this.vendorProductCategorySub,
    this.categoriesSubImages,
  });

  SubCategoryDataModel copyWith({
    String? vendorProductCategorySub,
    String? categoriesSubImages,
  }) =>
      SubCategoryDataModel(
        vendorProductCategorySub: vendorProductCategorySub ?? this.vendorProductCategorySub,
        categoriesSubImages: categoriesSubImages ?? this.categoriesSubImages,
      );

  factory SubCategoryDataModel.fromRawJson(String str) => SubCategoryDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubCategoryDataModel.fromJson(Map<String, dynamic> json) => SubCategoryDataModel(
    vendorProductCategorySub: json["vendor_product_category_sub"],
    categoriesSubImages: json["categories_sub_images"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_product_category_sub": vendorProductCategorySub,
    "categories_sub_images": categoriesSubImages,
  };
}
