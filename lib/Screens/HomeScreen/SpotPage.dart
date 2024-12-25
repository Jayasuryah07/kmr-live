import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmr/Controllers/HomeController.dart';
import 'package:kmr/Utils/ConstHelper.dart';

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
                                        Container(
                                          height: Get.width / 4,
                                          width: Get.width / 4,
                                          color: Color(0xffF7F7F7),
                                          child: Image.asset(
                                            'assets/image/imageNotFound.png',
                                            fit: BoxFit.cover,
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
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Divider(),
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
                                        Container(
                                          height: Get.width / 4,
                                          width: Get.width / 4,
                                          color: Color(0xffF7F7F7),
                                          child: Image.asset(
                                            'assets/image/imageNotFound.png',
                                            fit: BoxFit.cover,
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
                                                style: TextStyle(
                                                  color: ConstHelper.blackColor
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Divider(),
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
    ));
  }
}
