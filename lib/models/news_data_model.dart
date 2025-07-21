// To parse this JSON data, do
//
//     final newsDataModel = newsDataModelFromJson(jsonString);

import 'dart:convert';

NewsDataModel newsDataModelFromJson(String str) => NewsDataModel.fromJson(json.decode(str));

String newsDataModelToJson(NewsDataModel data) => json.encode(data.toJson());

class NewsDataModel {
  int? id;
  String? newsHeadlines;
  String? newsContent;
  String? newsImage;
  DateTime? newsCreatedDate;

  NewsDataModel({
    this.id,
    this.newsHeadlines,
    this.newsContent,
    this.newsImage,
    this.newsCreatedDate,
  });

  factory NewsDataModel.fromJson(Map<String, dynamic> json) => NewsDataModel(
    id: json["id"],
    newsHeadlines: json["news_headlines"],
    newsContent: json["news_content"],
    newsImage: json["news_image"],
    newsCreatedDate: json["news_created_date"] == null ? null : DateTime.parse(json["news_created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "news_headlines": newsHeadlines,
    "news_content": newsContent,
    "news_image": newsImage,
    "news_created_date": newsCreatedDate?.toIso8601String(),
  };
}
