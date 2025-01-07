import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ConstHelper.dart';


class SpotPage extends StatefulWidget {
  const SpotPage({super.key});

  @override
  State<SpotPage> createState() => _SpotPageState();
}

class _SpotPageState extends State<SpotPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    homeController.getSpotRateData(
        categoryValue: homeController.selectCategoryData.value.categoryName!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ConstHelper.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 30,
        ),
        child: Obx(
          () => homeController.loadData.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: ConstHelper.darkBlueColor,
                  ),
                )
              : homeController.searchStart.value
                  ? homeController.searchedSpotRateDataList.isEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getSpotRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Get.height / 2.8),
                                child: Center(
                                  child: Text(
                                    ConstHelper.dataNotAvailableMsg,
                                    style: TextStyle(
                                      color: ConstHelper.darkBlueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getSpotRateData(
                              categoryValue: 'Oil',
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView.builder(
                            itemCount:
                                homeController.searchedSpotRateDataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: Get.width / 30,
                                  bottom: (index + 1) !=
                                          homeController
                                              .searchedSpotRateDataList.length
                                      ? 0
                                      : Get.width / 30,
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: ConstHelper.whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ConstHelper.cementColor
                                            .withOpacity(0.6),
                                        blurRadius: 1,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: Get.width / 5,
                                          width: Get.width / 5,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            child: CachedNetworkImage(
                                              imageUrl:  ConstHelper.categoryImagePath+( homeController
                                                  .searchedSpotRateDataList[
                                              index]
                                                  .categoriesImages??"") ,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6),
                                                      color: ConstHelper
                                                          .whiteColor,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: Get.width / 20,
                                                      width: Get.width / 20,
                                                      child:
                                                      CircularProgressIndicator(
                                                        color: ConstHelper
                                                            .orangeColor,
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6),
                                                      color: ConstHelper
                                                          .whiteColor,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/image/imageNotFound.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: Get.width / 60,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homeController
                                                                .searchedSpotRateDataList[
                                                                    index]
                                                                .vendorSpotHeading ==
                                                            null ||
                                                        homeController
                                                            .searchedSpotRateDataList[
                                                                index]
                                                            .vendorSpotHeading!
                                                            .trim()
                                                            .isEmpty
                                                    ? 'Heading N/A'
                                                    : homeController
                                                        .searchedSpotRateDataList[
                                                            index]
                                                        .vendorSpotHeading!,
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                homeController
                                                                .searchedSpotRateDataList[
                                                                    index]
                                                                .vendorSpotDetails ==
                                                            null ||
                                                        homeController
                                                            .searchedSpotRateDataList[
                                                                index]
                                                            .vendorSpotDetails!
                                                            .trim()
                                                            .isEmpty
                                                    ? 'Details N/A'
                                                    : homeController
                                                        .searchedSpotRateDataList[
                                                            index]
                                                        .vendorSpotDetails!,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Divider(),
                                              Row(
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: homeController
                                                                          .searchedSpotRateDataList[
                                                                              index]
                                                                          .vendorSpotCreatedDate ==
                                                                      null ||
                                                                  homeController
                                                                          .searchedSpotRateDataList[
                                                                              index]
                                                                          .vendorSpotCreatedDate!
                                                                          .year <=
                                                                      0
                                                              ? 'Date N/A'
                                                              : DateFormat(
                                                                      'dd/MMM/yyyy')
                                                                  .format(homeController
                                                                      .searchedSpotRateDataList[
                                                                          index]
                                                                      .vendorSpotCreatedDate!),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: ConstHelper
                                                                .blackColor
                                                                .withOpacity(0.6),
                                                          ),
                                                        ),
                                                        const TextSpan(text: '  '),
                                                        TextSpan(
                                                          text: homeController
                                                                          .searchedSpotRateDataList[
                                                                              index]
                                                                          .vendorSpotCreatedTime ==
                                                                      null ||
                                                                  homeController
                                                                      .searchedSpotRateDataList[
                                                                          index]
                                                                      .vendorSpotCreatedTime!
                                                                      .trim()
                                                                      .isEmpty
                                                              ? 'Time N/A'
                                                              : DateFormat(
                                                                      'hh:mm a')
                                                                  .format(DateFormat(
                                                                          "HH:mm:ss")
                                                                      .parse(homeController
                                                                          .searchedSpotRateDataList[
                                                                              index]
                                                                          .vendorSpotCreatedTime!)),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: ConstHelper
                                                                .blackColor
                                                                .withOpacity(0.6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: InkWell(
                                                          onTap: () {
                                                            showDialog(context: context, builder: (context) {
                                                              return Dialog(
                                                                backgroundColor: ConstHelper.whiteColor,
                                                                surfaceTintColor: ConstHelper.whiteColor,
                                                                child: SingleChildScrollView(
                                                                  child: Container(
                                                                    padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.03,vertical:  MediaQuery.of(context).size.height*0.01),
                                                                    decoration: BoxDecoration(
                                                                      color: ConstHelper.whiteColor,
                                                                      border: Border.all(color: ConstHelper.darkBlueColor),
                                                                      borderRadius:
                                                                      BorderRadius.circular(5),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        Text(
                                                                          homeController
                                                                              .searchedSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotHeading ==
                                                                              null ||
                                                                              homeController
                                                                                  .searchedSpotRateDataList[
                                                                              index]
                                                                                  .vendorSpotHeading!
                                                                                  .trim()
                                                                                  .isEmpty
                                                                              ? 'Heading N/A'
                                                                              : homeController
                                                                              .searchedSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotHeading!.toUpperCase(),
                                                                          style: TextStyle(
                                                                            color: ConstHelper.blackColor,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 18,
                                                                          ),
                                                                        ),
                                                                        Divider(),
                                                                        Text(
                                                                          homeController
                                                                              .searchedSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotDetails ==
                                                                              null ||
                                                                              homeController
                                                                                  .searchedSpotRateDataList[
                                                                              index]
                                                                                  .vendorSpotDetails!
                                                                                  .trim()
                                                                                  .isEmpty
                                                                              ? 'Details N/A'
                                                                              : homeController
                                                                              .searchedSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotDetails!,
                                                                          style: TextStyle(
                                                                            color: ConstHelper.blackColor
                                                                                .withOpacity(0.6),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },);
                                                          },
                                                          splashColor: Colors.transparent,
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Text("View More",style: TextStyle(color: ConstHelper.greyColor,fontSize: 12,fontWeight: FontWeight.w600),)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                  : homeController.allSpotRateDataList.isEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getSpotRateData(
                              categoryValue: homeController.selectCategoryData.value.categoryName!,
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Get.height / 2.8),
                                child: Center(
                                  child: Text(
                                    ConstHelper.dataNotAvailableMsg,
                                    style: TextStyle(
                                      color: ConstHelper.darkBlueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getSpotRateData(
                              categoryValue: homeController.selectCategoryData.value.categoryName!,
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView.builder(
                            itemCount:
                                homeController.allSpotRateDataList.length,
                            itemBuilder: (context, index) {
                              print(ConstHelper.categoryImagePath+( homeController
                                  .allSpotRateDataList[
                              index]
                                  .categoriesImages??""));
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: Get.width / 30,
                                  bottom: (index + 1) !=
                                          homeController
                                              .allSpotRateDataList.length
                                      ? 0
                                      : Get.width / 30,
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: ConstHelper.whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ConstHelper.cementColor
                                            .withOpacity(0.6),
                                        blurRadius: 1,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: Get.width / 5,
                                          width: Get.width / 5,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            child: CachedNetworkImage(
                                              imageUrl:  ConstHelper.categoryImagePath+( homeController
                                                  .allSpotRateDataList[
                                              index]
                                                  .categoriesImages??"") ,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6),
                                                      color: ConstHelper
                                                          .whiteColor,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: Get.width / 20,
                                                      width: Get.width / 20,
                                                      child:
                                                      CircularProgressIndicator(
                                                        color: ConstHelper
                                                            .orangeColor,
                                                        strokeWidth: 2,
                                                      ),
                                                    ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          6),
                                                      color: ConstHelper
                                                          .whiteColor,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/image/imageNotFound.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: Get.width / 60,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                homeController
                                                                .allSpotRateDataList[
                                                                    index]
                                                                .vendorSpotHeading ==
                                                            null ||
                                                        homeController
                                                            .allSpotRateDataList[
                                                                index]
                                                            .vendorSpotHeading!
                                                            .trim()
                                                            .isEmpty
                                                    ? 'Heading N/A'
                                                    : homeController
                                                        .allSpotRateDataList[
                                                            index]
                                                        .vendorSpotHeading!,
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                homeController
                                                                .allSpotRateDataList[
                                                                    index]
                                                                .vendorSpotDetails ==
                                                            null ||
                                                        homeController
                                                            .allSpotRateDataList[
                                                                index]
                                                            .vendorSpotDetails!
                                                            .trim()
                                                            .isEmpty
                                                    ? 'Details N/A'
                                                    : homeController
                                                        .allSpotRateDataList[
                                                            index]
                                                        .vendorSpotDetails!,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Divider(),
                                             
                                              Row(
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: homeController
                                                              .allSpotRateDataList[
                                                          index]
                                                              .vendorSpotCreatedDate ==
                                                              null ||
                                                              homeController
                                                                  .allSpotRateDataList[
                                                              index]
                                                                  .vendorSpotCreatedDate!
                                                                  .year <=
                                                                  0
                                                              ? 'Date N/A'
                                                              : DateFormat(
                                                              'dd/MMM/yyyy')
                                                              .format(homeController
                                                              .allSpotRateDataList[
                                                          index]
                                                              .vendorSpotCreatedDate!),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: ConstHelper
                                                                .blackColor
                                                                .withOpacity(0.6),
                                                          ),
                                                        ),
                                                        const TextSpan(text: '  '),

                                                        TextSpan(
                                                          text: homeController
                                                              .allSpotRateDataList[
                                                          index]
                                                              .vendorSpotCreatedTime ==
                                                              null ||
                                                              homeController
                                                                  .allSpotRateDataList[
                                                              index]
                                                                  .vendorSpotCreatedTime!
                                                                  .trim()
                                                                  .isEmpty
                                                              ? 'Time N/A'
                                                              : DateFormat(
                                                              'hh:mm a')
                                                              .format(DateFormat(
                                                              "HH:mm:ss")
                                                              .parse(homeController
                                                              .allSpotRateDataList[
                                                          index]
                                                              .vendorSpotCreatedTime!)),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: ConstHelper
                                                                .blackColor
                                                                .withOpacity(0.6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: InkWell(
                                                          onTap: () {
                                                            showDialog(context: context, builder: (context) {
                                                              return Dialog(
                                                                backgroundColor: ConstHelper.whiteColor,
                                                                surfaceTintColor: ConstHelper.whiteColor,
                                                                child: SingleChildScrollView(
                                                                  child: Container(
                                                                    padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.03,vertical:  MediaQuery.of(context).size.height*0.01),
                                                                    decoration: BoxDecoration(
                                                                      color: ConstHelper.whiteColor,
                                                                      border: Border.all(color: ConstHelper.darkBlueColor),
                                                                      borderRadius:
                                                                      BorderRadius.circular(5),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                      children: [
                                                                        Text(
                                                                          homeController
                                                                              .allSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotHeading ==
                                                                              null ||
                                                                              homeController
                                                                                  .allSpotRateDataList[
                                                                              index]
                                                                                  .vendorSpotHeading!
                                                                                  .trim()
                                                                                  .isEmpty
                                                                              ? 'Heading N/A'
                                                                              : homeController
                                                                              .allSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotHeading!.toUpperCase(),
                                                                          style: TextStyle(
                                                                            color: ConstHelper.blackColor,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 18,
                                                                          ),
                                                                        ),
                                                                       Divider(),
                                                                        Text(
                                                                          homeController
                                                                              .allSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotDetails ==
                                                                              null ||
                                                                              homeController
                                                                                  .allSpotRateDataList[
                                                                              index]
                                                                                  .vendorSpotDetails!
                                                                                  .trim()
                                                                                  .isEmpty
                                                                              ? 'Details N/A'
                                                                              : homeController
                                                                              .allSpotRateDataList[
                                                                          index]
                                                                              .vendorSpotDetails!,
                                                                          style: TextStyle(
                                                                            color: ConstHelper.blackColor
                                                                                .withOpacity(0.6),
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 14,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },);
                                                          },
                                                          splashColor: Colors.transparent,
                                                          borderRadius: BorderRadius.circular(10),
                                                          child: Text("View More",style: TextStyle(color: ConstHelper.greyColor,fontSize: 12,fontWeight: FontWeight.w600),)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
        ),
      ),
    ),
    );
  }
}
