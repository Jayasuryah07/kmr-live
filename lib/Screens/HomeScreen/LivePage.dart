import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmr/Controllers/HomeController.dart';
import 'package:kmr/Models/LiveDataModel.dart';
import 'package:kmr/Utils/ApiHelper.dart';
import 'package:kmr/Utils/ConstHelper.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    homeController.getLiveData(
        categoryValue: homeController.selectCategoryData.value.categoryName!,
        subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ConstHelper.whiteColor,
      body: Column(
        children: [
          CarouselSlider(
            items: [
              1,
              2,
              3,
            ].map((i) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                child: SizedBox(
                  width: Get.width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUPIfiGgUML8G3ZqsNLHfaCnZK3I5g4tJabQ&s",
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: ConstHelper.darkBlueColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Image.asset(
                        'assets/image/imageNotFound.png',
                        color: ConstHelper.blackColor,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: Get.width / 3,
              // aspectRatio: 1,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) =>
                  homeController.sliderIndex.value = index,
            ),
          ),
          SizedBox(
            height: Get.width / 90,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                1,
                2,
                3,
              ]
                  .asMap()
                  .entries
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.only(
                        left: e.key == 0 ? 0 : Get.width / 150,
                      ),
                      height: e.key == homeController.sliderIndex.value
                          ? Get.width / 45
                          : Get.width / 80,
                      width: e.key == homeController.sliderIndex.value
                          ? Get.width / 45
                          : Get.width / 80,
                      decoration: BoxDecoration(
                        color: e.key == homeController.sliderIndex.value
                            ? ConstHelper.darkBlueColor
                            : ConstHelper.cementColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: Get.width / 20,
          ),
          Expanded(
            child: Padding(
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
                        ? homeController.searchedLiveDataList.isEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  await homeController.getLiveData(
                                    categoryValue: homeController.selectCategoryData.value.categoryName!,
                                    subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
                                  );
                                },
                                backgroundColor: ConstHelper.whiteColor,
                                color: ConstHelper.darkBlueColor,
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Get.height / 3.8,
                                      ),
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
                                  await homeController.getLiveData(
                                      categoryValue: homeController.selectCategoryData.value.categoryName!,
                                      subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
                                  );
                                },
                                backgroundColor: ConstHelper.whiteColor,
                                color: ConstHelper.darkBlueColor,
                                child: ListView.builder(
                                  itemCount: homeController
                                      .searchedLiveDataList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: index == 0 ? 0 : Get.width / 30,
                                        bottom: (index + 1) !=
                                                homeController
                                                    .searchedLiveDataList.length
                                            ? 0
                                            : Get.width / 30,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: ConstHelper.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: Get.width / 5,
                                                width: Get.width / 5,
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
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                homeController.searchedLiveDataList[index].vendorProduct ==
                                                                            null ||
                                                                        homeController
                                                                            .searchedLiveDataList[
                                                                                index]
                                                                            .vendorProduct!
                                                                            .trim()
                                                                            .isEmpty
                                                                    ? 'Name N/A'
                                                                    : homeController
                                                                        .searchedLiveDataList[
                                                                            index]
                                                                        .vendorProduct!,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: ConstHelper
                                                                      .blackColor,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController.searchedLiveDataList[index].vendorProductSize ==
                                                                            null ||
                                                                        homeController
                                                                            .searchedLiveDataList[
                                                                                index]
                                                                            .vendorProductSize!
                                                                            .trim()
                                                                            .isEmpty
                                                                    ? 'Size N/A'
                                                                    : homeController
                                                                        .searchedLiveDataList[
                                                                            index]
                                                                        .vendorProductSize!,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: ConstHelper
                                                                      .blackColor
                                                                      .withOpacity(
                                                                          0.6),
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          // height: Get.width/15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ConstHelper
                                                                .blackColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                Get.width / 75,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "₹ ${homeController.searchedLiveDataList[index].vendorProductRate == null ? 'Price N/A' : homeController.searchedLiveDataList[index].vendorProductRate!}",
                                                                style:
                                                                    TextStyle(
                                                                  color: ConstHelper
                                                                      .whiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width /
                                                                        60,
                                                              ),
                                                              Text(
                                                                "(+40)",
                                                                style:
                                                                    TextStyle(
                                                                  color: ConstHelper
                                                                      .lightGreenColor,
                                                                  fontSize: 10,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: homeController.searchedLiveDataList[index].vendorProductCreatedDate ==
                                                                              null ||
                                                                          homeController.searchedLiveDataList[index].vendorProductCreatedDate!.year <=
                                                                              0
                                                                      ? 'Date N/A'
                                                                      : DateFormat('dd/MMM/yyyy').format(homeController
                                                                          .searchedLiveDataList[
                                                                              index]
                                                                          .vendorProductCreatedDate!),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: ConstHelper
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                ),
                                                                const TextSpan(
                                                                    text: '  '),
                                                                TextSpan(
                                                                  text: homeController.searchedLiveDataList[index].vendorProductCreatedTime ==
                                                                              null ||
                                                                          homeController
                                                                              .searchedLiveDataList[
                                                                                  index]
                                                                              .vendorProductCreatedTime!
                                                                              .trim()
                                                                              .isEmpty
                                                                      ? 'Time N/A'
                                                                      : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                          .searchedLiveDataList[
                                                                              index]
                                                                          .vendorProductCreatedTime!)),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: ConstHelper
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Obx(() => Icon(Icons.favorite,color: homeController.favorite.value == false?Color(0xff5D646C):Colors.redAccent,),),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                        : homeController.allLiveDataList.isEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  await homeController.getLiveData(
                                      categoryValue: homeController.selectCategoryData.value.categoryName!,
                                      subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
                                  );
                                },
                                backgroundColor: ConstHelper.whiteColor,
                                color: ConstHelper.darkBlueColor,
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Get.height / 3.8,
                                      ),
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
                                  await homeController.getLiveData(
                                      categoryValue: homeController.selectCategoryData.value.categoryName!,
                                      subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
                                  );
                                },
                                backgroundColor: ConstHelper.whiteColor,
                                color: ConstHelper.darkBlueColor,
                                child: ListView.builder(
                                  itemCount:
                                      homeController.allLiveDataList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        top: index == 0 ? 0 : Get.width / 30,
                                        bottom: (index + 1) !=
                                                homeController
                                                    .allLiveDataList.length
                                            ? 0
                                            : Get.width / 30,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: ConstHelper.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: Get.width / 5,
                                                width: Get.width / 5,
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
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                homeController.allLiveDataList[index].vendorProduct ==
                                                                            null ||
                                                                        homeController
                                                                            .allLiveDataList[
                                                                                index]
                                                                            .vendorProduct!
                                                                            .trim()
                                                                            .isEmpty
                                                                    ? 'Name N/A'
                                                                    : homeController
                                                                        .allLiveDataList[
                                                                            index]
                                                                        .vendorProduct!,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: ConstHelper
                                                                      .blackColor,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController.allLiveDataList[index].vendorProductSize ==
                                                                            null ||
                                                                        homeController
                                                                            .allLiveDataList[
                                                                                index]
                                                                            .vendorProductSize!
                                                                            .trim()
                                                                            .isEmpty
                                                                    ? 'Size N/A'
                                                                    : homeController
                                                                        .allLiveDataList[
                                                                            index]
                                                                        .vendorProductSize!,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: ConstHelper
                                                                      .blackColor
                                                                      .withOpacity(
                                                                          0.6),
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          // height: Get.width/15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ConstHelper
                                                                .blackColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                Get.width / 75,
                                                          ),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "₹ ${homeController.allLiveDataList[index].vendorProductRate == null ? 'Price N/A' : homeController.allLiveDataList[index].vendorProductRate!}",
                                                                style:
                                                                    TextStyle(
                                                                  color: ConstHelper
                                                                      .whiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    Get.width /
                                                                        60,
                                                              ),
                                                              Text(
                                                                "(+40)",
                                                                style:
                                                                    TextStyle(
                                                                  color: ConstHelper
                                                                      .lightGreenColor,
                                                                  fontSize: 10,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text.rich(
                                                            TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: homeController.allLiveDataList[index].vendorProductCreatedDate ==
                                                                              null ||
                                                                          homeController.allLiveDataList[index].vendorProductCreatedDate!.year <=
                                                                              0
                                                                      ? 'Date N/A'
                                                                      : DateFormat('dd/MMM/yyyy').format(homeController
                                                                          .allLiveDataList[
                                                                              index]
                                                                          .vendorProductCreatedDate!),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: ConstHelper
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                ),
                                                                const TextSpan(
                                                                    text: '  '),
                                                                TextSpan(
                                                                  text: homeController.allLiveDataList[index].vendorProductCreatedTime ==
                                                                              null ||
                                                                          homeController
                                                                              .allLiveDataList[
                                                                                  index]
                                                                              .vendorProductCreatedTime!
                                                                              .trim()
                                                                              .isEmpty
                                                                      ? 'Time N/A'
                                                                      : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                          .allLiveDataList[
                                                                              index]
                                                                          .vendorProductCreatedTime!)),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: ConstHelper
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // Obx(() => Icon(Icons.favorite,color: homeController.favorite.value == false?Color(0xff5D646C):Colors.redAccent,),),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
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
        ],
      ),
    ));
  }
}
