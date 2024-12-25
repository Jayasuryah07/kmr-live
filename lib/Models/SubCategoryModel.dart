// To parse this JSON data, do
//
//     final subCategoryDataModel = subCategoryDataModelFromJson(jsonString);

import 'dart:convert';

SubCategoryDataModel subCategoryDataModelFromJson(String str) => SubCategoryDataModel.fromJson(json.decode(str));

String subCategoryDataModelToJson(SubCategoryDataModel data) => json.encode(data.toJson());

class SubCategoryDataModel {
  int? id;
  String? categorySubName;

  SubCategoryDataModel({
    this.id,
    this.categorySubName,
  });

  factory SubCategoryDataModel.fromJson(Map<String, dynamic> json) => SubCategoryDataModel(
    id: json["id"],
    categorySubName: json["category_sub_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_sub_name": categorySubName,
  };
}
