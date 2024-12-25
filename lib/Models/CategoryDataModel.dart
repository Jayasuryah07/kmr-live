// To parse this JSON data, do
//
//     final categoryDataModel = categoryDataModelFromJson(jsonString);

import 'dart:convert';

CategoryDataModel categoryDataModelFromJson(String str) =>
    CategoryDataModel.fromJson(json.decode(str));

String categoryDataModelToJson(CategoryDataModel data) =>
    json.encode(data.toJson());

class CategoryDataModel {
  int? id;
  String? categoryName;
  String? categoriesImages;

  CategoryDataModel({
    this.id,
    this.categoryName,
    this.categoriesImages,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryDataModel(
        id: json["id"],
        categoryName: json["category_name"],
        categoriesImages: json["categories_images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "categories_images": categoriesImages,
      };
}
