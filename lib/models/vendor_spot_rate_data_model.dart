import 'dart:convert';

VendorSpotRateDataModel vendorSpotRateDataModelFromJson(String str) =>
    VendorSpotRateDataModel.fromJson(json.decode(str));

String vendorSpotRateDataModelToJson(VendorSpotRateDataModel data) => json.encode(data.toJson());

class VendorSpotRateDataModel {
  int? id;
  String? vendorName;
  String? vendorCity;
  String? vendorSpotHeading;
  String? vendorSpotDetails;
  DateTime? vendorSpotCreatedDate;
  String? vendorSpotCreatedTime;
  String? categoriesImages;

  VendorSpotRateDataModel({
    this.id,
    this.vendorName,
    this.vendorCity,
    this.vendorSpotHeading,
    this.vendorSpotDetails,
    this.vendorSpotCreatedDate,
    this.vendorSpotCreatedTime,
    this.categoriesImages,
  });

  factory VendorSpotRateDataModel.fromJson(Map<String, dynamic> json) => VendorSpotRateDataModel(
    id: json["id"],
    vendorName: json["vendor_name"],
    vendorCity: json["vendor_city"],
    vendorSpotHeading: json["vendor_spot_heading"],
    vendorSpotDetails: json["vendor_spot_details"],
    vendorSpotCreatedDate: json["vendor_spot_created_date"] == null ? null :
    DateTime.parse(json["vendor_spot_created_date"]),
    vendorSpotCreatedTime: json["vendor_spot_created_time"],
    categoriesImages: json["categories_images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_name": vendorName,
    "vendor_city": vendorCity,
    "vendor_spot_heading": vendorSpotHeading,
    "vendor_spot_details": vendorSpotDetails,
    "vendor_spot_created_date": vendorSpotCreatedDate?.toIso8601String(),
    "vendor_spot_created_time": vendorSpotCreatedTime,
    "categories_images": categoriesImages,
  };

}
