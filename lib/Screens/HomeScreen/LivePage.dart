
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ConstHelper.dart';
import '../../Models/CategoryItemModel.dart';

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
    if(homeController.allSubCategoryDataList.isNotEmpty){
      homeController.getLiveData(
          categoryValue: homeController.selectCategoryData.value.categoryName!,
          subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ConstHelper.whiteColor,
      body: Column(
        children: [
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
                                    subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!
                                  );
                                },
                                backgroundColor: ConstHelper.whiteColor,
                                color: ConstHelper.darkBlueColor,
                                child:ListView(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Get.height / 3.8,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Error: No information available for this category.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: ConstHelper.darkBlueColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Get.width*0.045,
                                                  letterSpacing: 1
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await homeController.getLiveData(
                                      categoryValue: homeController.selectCategoryData.value.categoryName!,
                                      subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!
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
                                      child:InkWell(
                                        onTap: () async {
                                          await homeController.getCategoryItemData(id: homeController.searchedLiveDataList[index].id?.toString()??"");
                                          if(homeController.categoryFirstItem.isNotEmpty &&  homeController.searchedLiveDataList[index].vendorProductUpdatedDate !=
                                              null &&
                                              homeController.searchedLiveDataList[index].vendorProductUpdatedDate!.year >=
                                                  0) {
                                            showDialog(context: context, builder: (context) {
                                              return Dialog(
                                                backgroundColor: ConstHelper.whiteColor,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.07,vertical:  MediaQuery.of(context).size.height*0.03),
                                                    decoration: BoxDecoration(
                                                    color: ConstHelper.whiteColor,
                                                    border: Border.all(color: ConstHelper.darkBlueColor),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                homeController.searchedLiveDataList[index].vendorName?.toString()??"".toUpperCase(),
                                                                style: TextStyle(
                                                                  color: ConstHelper.blackColor,
                                                                  fontWeight: FontWeight.w400,
                                                                    fontSize: Get.width*0.045,
                                                                    letterSpacing: 1
                                                                ),
                                                              ),
                                                            ),

                                                            Text(
                                                              "₹${homeController.searchedLiveDataList[index].vendorProductRate?.toString()??""}",
                                                              style: TextStyle(
                                                                color: ConstHelper.blackColor
                                                                    .withOpacity(0.6),
                                                                fontWeight: FontWeight.w500,
                                                                  fontSize: Get.width*0.04,
                                                                  letterSpacing: 1
                                                              ),
                                                            ),
                                                            Text(
                                                              homeController.searchedLiveDataList[index].oldVendorProductRate != null && homeController.searchedLiveDataList[index].oldVendorProductRate!= 0?"+(${(homeController.searchedLiveDataList[index].vendorProductRate??0) -(homeController.searchedLiveDataList[index].oldVendorProductRate??0)})":"(+0)",
                                                              style:
                                                              TextStyle(
                                                                  color:Color(
                                                                      0xff507503),
                                                                  fontSize: Get.width*0.03,
                                                                  letterSpacing: 1,
                                                                  fontWeight: FontWeight.w600
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          homeController.searchedLiveDataList[index].vendorProductCategory?.toString()??"".toUpperCase(),
                                                          style: TextStyle(
                                                            color: ConstHelper.blackColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: Get.width*0.05,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                homeController.searchedLiveDataList[index].vendorProductSize??"",
                                                                style: TextStyle(
                                                                  color: ConstHelper.blackColor
                                                                      .withOpacity(0.6),
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: Get.width*0.04,
                                                                  letterSpacing: 1,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Align(
                                                                alignment: Alignment.centerRight,
                                                                child: Text.rich(
                                                                  TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: homeController.searchedLiveDataList[index].vendorProductUpdatedDate ==
                                                                            null ||
                                                                            homeController.searchedLiveDataList[index].vendorProductUpdatedDate!.year <=
                                                                                0
                                                                            ? 'Date N/A'
                                                                            : DateFormat('dd/MMM/yyyy').format(homeController.searchedLiveDataList[index].vendorProductUpdatedDate!),

                                                                        style:
                                                                        TextStyle(
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
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
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
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
                                                            ),
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        if(homeController.categoryFirstItem.isNotEmpty)
                                                          Text("Last 10 Prices",
                                                            textAlign:TextAlign.start,
                                                            style: TextStyle(
                                                              color: ConstHelper.darkBlueColor,
                                                              fontWeight: FontWeight. w600,
                                                              fontSize: Get.width*0.045,
                                                              letterSpacing: 1,
                                                            ),).paddingOnly(bottom: Get.height/60),
                                                        if(homeController.categoryFirstItem.isNotEmpty)
                                                          ListView.separated(
                                                              shrinkWrap: true,
                                                              itemBuilder: (context, index) {
                                                                return Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text.rich(
                                                                          TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: homeController.categoryFirstItem[index].vendorProductUpdatedDate ==
                                                                                    null ||
                                                                                    homeController.categoryFirstItem[index].vendorProductUpdatedDate!.year <=
                                                                                        0
                                                                                    ? 'Date N/A'
                                                                                    : DateFormat('dd-MMM-yyyy').format(homeController.categoryFirstItem[index].vendorProductUpdatedDate!),

                                                                                style:
                                                                                TextStyle(
                                                                                  fontSize: Get.width*0.04,
                                                                                  letterSpacing: 1,
                                                                                  color: ConstHelper
                                                                                      .blackColor
                                                                                      .withOpacity(
                                                                                      0.6),
                                                                                ),
                                                                              ),
                                                                              const TextSpan(
                                                                                  text: '  '),
                                                                              TextSpan(
                                                                                text: homeController.categoryFirstItem[index].vendorProductUpdatedTime ==
                                                                                    null ||
                                                                                    homeController
                                                                                        .categoryFirstItem[
                                                                                    index]
                                                                                        .vendorProductUpdatedTime!
                                                                                        .trim()
                                                                                        .isEmpty
                                                                                    ? 'Time N/A'
                                                                                    : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                                    .categoryFirstItem[
                                                                                index]
                                                                                    .vendorProductUpdatedTime!)),
                                                                                style:
                                                                                TextStyle(
                                                                                  fontSize: Get.width*0.04,
                                                                                  letterSpacing: 1,
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
                                                                    ),
                                                                    Text("₹ ${homeController.categoryFirstItem[index].vendorProductRate?.toString()??""}",
                                                                      textAlign:TextAlign.end,
                                                                      style: TextStyle(
                                                                        color: ConstHelper.darkBlueColor,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: Get.width*0.04,
                                                                        letterSpacing: 1,
                                                                      ),),],);
                                                              }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: homeController.categoryFirstItem.length)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },);
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'No Data Available',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Colors.black.withOpacity(0.5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                behavior: SnackBarBehavior.floating, // Makes it float above content
                                                action: SnackBarAction(
                                                  label: 'DISMISS',
                                                  onPressed: () {},
                                                  textColor: Colors.white,
                                                ),
                                              ),
                                            );

                                          }
                                        },
                                        splashColor: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
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
                                                SizedBox(
                                                  height: Get.width / 6,
                                                  width: Get.width / 6,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(6),
                                                    child: CachedNetworkImage(
                                                      imageUrl:  ConstHelper.subCategoryImagePath+(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categoriesSubImages??"") ,
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
                                                                  homeController.searchedLiveDataList[index].vendorName ==
                                                                              null ||
                                                                          homeController
                                                                              .searchedLiveDataList[
                                                                                  index]
                                                                              .vendorName!
                                                                              .trim()
                                                                              .isEmpty
                                                                      ? 'Name N/A'
                                                                      : homeController
                                                                          .searchedLiveDataList[
                                                                              index]
                                                                          .vendorName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: ConstHelper
                                                                        .blackColor,
                                                                        fontSize: Get.width*0.05,
                                                                        letterSpacing: 1,
                                                                  ),
                                                                ),
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
                                                                    fontSize: Get.width*0.045,
                                                                    letterSpacing: 1,
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
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
                                                                    Column(
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
                                                                                fontSize: Get.width*0.045,
                                                                                letterSpacing: 1,
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          Get.width /
                                                                              60,
                                                                    ),
                                                                    Text(
                                                                      homeController.searchedLiveDataList[index].oldVendorProductRate != null && homeController.searchedLiveDataList[index].oldVendorProductRate!= 0?"+(${(homeController.searchedLiveDataList[index].vendorProductRate??0) -(homeController.searchedLiveDataList[index].oldVendorProductRate??0)})":"(+0)",
                                                                      style:
                                                                          TextStyle(
                                                                        color: ConstHelper
                                                                            .lightGreenColor,
                                                                            fontSize: Get.width*0.03,
                                                                            letterSpacing: 1,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Get.width*0.2,
                                                                child: Text(
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
                                                                  textAlign: TextAlign.end,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style:
                                                                  TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    color: ConstHelper
                                                                        .blackColor
                                                                        .withOpacity(
                                                                        0.6),
                                                                    fontSize: Get.width*0.04,
                                                                    letterSpacing: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Expanded(
                                                            child: Text.rich(
                                                              TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: homeController.searchedLiveDataList[index].vendorProductUpdatedDate ==
                                                                                null ||
                                                                            homeController.searchedLiveDataList[index].vendorProductUpdatedDate!.year <=
                                                                                0
                                                                        ? DateFormat('dd/MMM/yyyy').format(homeController
                                                                        .searchedLiveDataList[
                                                                    index]
                                                                        .vendorProductCreatedDate!)
                                                                        : DateFormat('dd/MMM/yyyy').format(homeController
                                                                            .searchedLiveDataList[
                                                                                index]
                                                                            .vendorProductUpdatedDate!),
                                                                    style:
                                                                        TextStyle(
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
                                                                      color: ConstHelper
                                                                          .blackColor
                                                                          .withOpacity(
                                                                              0.6),
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                      text: '  '),
                                                                  TextSpan(
                                                                    text: homeController.searchedLiveDataList[index].vendorProductUpdatedTime ==
                                                                                null ||
                                                                            homeController
                                                                                .searchedLiveDataList[
                                                                                    index]
                                                                                .vendorProductUpdatedTime!
                                                                                .trim()
                                                                                .isEmpty
                                                                        ? DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                        .searchedLiveDataList[
                                                                    index]
                                                                        .vendorProductCreatedTime!))
                                                                        : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                            .searchedLiveDataList[
                                                                                index]
                                                                            .vendorProductUpdatedTime!)),
                                                                    style:
                                                                        TextStyle(
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
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
                                                          homeController.searchedLiveDataList[index].vendorProductUpdatedDate ==
                                                              null ||
                                                              homeController.searchedLiveDataList[index].vendorProductUpdatedDate!.year <=
                                                                  0
                                                              ?SizedBox():  Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Text("View More",style: TextStyle(color: ConstHelper.darkBlueColor,decoration: TextDecoration.underline, fontSize: Get.width*0.035,
                                                                  letterSpacing: 1,fontWeight: FontWeight.w600),))
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
                                      subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!
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
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Error: No information available for this category.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ConstHelper.darkBlueColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: Get.width*0.045,
                                                letterSpacing: 1
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await homeController.getLiveData(
                                      categoryValue: homeController.selectCategoryData.value.categoryName!,
                                      subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!
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
                                      child:InkWell(
                                        onTap: () async {
                                          await homeController.getCategoryItemData(id: homeController.allLiveDataList[index].id?.toString()??"");
                                          if(homeController.categoryFirstItem.isNotEmpty &&  homeController.allLiveDataList[index].vendorProductUpdatedDate !=
                                              null ||
                                              homeController.allLiveDataList[index].vendorProductUpdatedDate!.year >=
                                                  0
                                              ) {
                                            showDialog(context: context, builder: (context) {
                                              return Dialog(
                                                backgroundColor: ConstHelper.whiteColor,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.07,vertical:  MediaQuery.of(context).size.height*0.03),
                                                  decoration: BoxDecoration(
                                                    color: ConstHelper.whiteColor,
                                                    border: Border.all(color: ConstHelper.darkBlueColor),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                homeController.allLiveDataList[index].vendorName?.toString()??"".toUpperCase(),
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: ConstHelper
                                                                      .blackColor,
                                                                  fontSize: Get.width*0.05,
                                                                  letterSpacing: 1,
                                                                ),
                                                              ),
                                                            ),

                                                            Text(
                                                              "₹${homeController.allLiveDataList[index].vendorProductRate?.toString()??""}",
                                                              style: TextStyle(
                                                                color: ConstHelper.blackColor
                                                                    .withOpacity(0.6),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: Get.width*0.04,
                                                                letterSpacing: 1,
                                                              ),
                                                            ),
                                                             Text(
                                                              ((homeController.allLiveDataList[index].vendorProductRate??0) -(homeController.allLiveDataList[index].oldVendorProductRate??0)).toString(),
                                                              style:
                                                              TextStyle(
                                                                  color:Color(
                                                                      0xff507503),
                                                                  fontSize: Get.width*0.03,
                                                                  letterSpacing: 1,
                                                                  fontWeight: FontWeight.w600
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          homeController.allLiveDataList[index].vendorProduct?.toString()??"".toUpperCase(),
                                                          style: TextStyle(
                                                            color: ConstHelper.blackColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: Get.width*0.05,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),

                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                                            Text(
                                                              homeController.allLiveDataList[index].vendorProductSize??"",
                                                              style: TextStyle(
                                                                color: ConstHelper.blackColor
                                                                    .withOpacity(0.6),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: Get.width*0.04,
                                                                letterSpacing: 1,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Align(
                                                                alignment: Alignment.centerRight,
                                                                child: Text.rich(
                                                                  TextSpan(

                                                                    children: [
                                                                      TextSpan(
                                                                        text: homeController.allLiveDataList[index].vendorProductUpdatedDate ==
                                                                            null ||
                                                                            homeController.allLiveDataList[index].vendorProductUpdatedDate!.year <=
                                                                                0
                                                                            ? 'Date N/A'
                                                                            : DateFormat('dd/MMM/yyyy').format(homeController.allLiveDataList[index].vendorProductUpdatedDate!),

                                                                        style:
                                                                        TextStyle(
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
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
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
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
                                                            ),
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        if(homeController.categoryFirstItem.isNotEmpty)
                                                          Text("Last 10 Prices",
                                                            textAlign:TextAlign.start,
                                                            style: TextStyle(
                                                              color: ConstHelper.darkBlueColor,
                                                              fontWeight: FontWeight. w600,
                                                              fontSize: Get.width*0.045,
                                                              letterSpacing: 1,
                                                            ),).paddingOnly(bottom: Get.height/60),
                                                        if(homeController.categoryFirstItem.isNotEmpty)
                                                          ListView.separated(
                                                              shrinkWrap: true,
                                                              itemBuilder: (context, index) {
                                                                return Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text.rich(
                                                                          TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: homeController.categoryFirstItem[index].vendorProductUpdatedDate ==
                                                                                    null ||
                                                                                    homeController.categoryFirstItem[index].vendorProductUpdatedDate!.year <=
                                                                                        0
                                                                                    ? 'Date N/A'
                                                                                    : DateFormat('dd-MMM-yyyy').format(homeController.categoryFirstItem[index].vendorProductUpdatedDate!),

                                                                                style:
                                                                                TextStyle(
                                                                                  fontSize: Get.width*0.04,
                                                                                  letterSpacing: 1,
                                                                                  color: ConstHelper
                                                                                      .blackColor
                                                                                      .withOpacity(
                                                                                      0.6),
                                                                                ),
                                                                              ),
                                                                              const TextSpan(
                                                                                  text: '  '),
                                                                              TextSpan(
                                                                                text: homeController.categoryFirstItem[index].vendorProductUpdatedTime ==
                                                                                    null ||
                                                                                    homeController
                                                                                        .categoryFirstItem[
                                                                                    index]
                                                                                        .vendorProductUpdatedTime!
                                                                                        .trim()
                                                                                        .isEmpty
                                                                                    ? 'Time N/A'
                                                                                    : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                                    .categoryFirstItem[
                                                                                index]
                                                                                    .vendorProductUpdatedTime!)),
                                                                                style:
                                                                                TextStyle(
                                                                                  fontSize: Get.width*0.04,
                                                                                  letterSpacing: 1,
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
                                                                    ),

                                                                    Text("₹ ${homeController.categoryFirstItem[index].vendorProductRate?.toString()??""}",
                                                                      textAlign:TextAlign.end,
                                                                      style: TextStyle(
                                                                        color: ConstHelper.darkBlueColor,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: Get.width*0.04,
                                                                        letterSpacing: 1,
                                                                      ),),],);
                                                              }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: homeController.categoryFirstItem.length)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },);
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'No Data Available',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: Colors.black.withOpacity(0.5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                behavior: SnackBarBehavior.floating, // Makes it float above content
                                                action: SnackBarAction(
                                                  label: 'DISMISS',
                                                  onPressed: () {},
                                                  textColor: Colors.white,
                                                ),
                                              ),
                                            );

                                          }
                                        },
                                        splashColor: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
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
                                                SizedBox(
                                                  height: Get.width / 6,
                                                  width: Get.width / 6,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(6),
                                                    child: CachedNetworkImage(
                                                      imageUrl:  ConstHelper.subCategoryImagePath+(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categoriesSubImages??"") ,
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
                                                                  homeController.allLiveDataList[index].vendorName ==
                                                                              null ||
                                                                          homeController
                                                                              .allLiveDataList[
                                                                                  index]
                                                                              .vendorName!
                                                                              .trim()
                                                                              .isEmpty
                                                                      ? 'Name N/A'
                                                                      : homeController
                                                                          .allLiveDataList[
                                                                              index]
                                                                          .vendorName!,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: ConstHelper
                                                                        .blackColor,
                                                                    fontSize: Get.width*0.04,
                                                                  ),
                                                                ), Text(
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
                                                                        fontSize: Get.width*0.045,
                                                                        letterSpacing: 1,
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
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
                                                                            fontSize: Get.width*0.045,
                                                                            letterSpacing: 1,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          Get.width /
                                                                              60,
                                                                    ),
                                                                    Text(
                                                                      homeController.allLiveDataList[index].oldVendorProductRate != null && homeController.allLiveDataList[index].oldVendorProductRate!= 0?"+(${(homeController.allLiveDataList[index].vendorProductRate??0) -(homeController.allLiveDataList[index].oldVendorProductRate??0)})":"(+0)",

                                                                      style:
                                                                          TextStyle(
                                                                        color: ConstHelper
                                                                            .lightGreenColor,
                                                                            fontSize: Get.width*0.03,
                                                                            letterSpacing: 1,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Get.width*0.2,
                                                                child: Text(
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
                                                                  textAlign: TextAlign.end,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style:
                                                                  TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    color: ConstHelper
                                                                        .blackColor
                                                                        .withOpacity(
                                                                        0.6),
                                                                    fontSize: Get.width*0.04,
                                                                    letterSpacing: 1,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,

                                                        children: [
                                                          Expanded(
                                                            child: Text.rich(
                                                              TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: homeController.allLiveDataList[index].vendorProductUpdatedDate ==
                                                                                null ||
                                                                            homeController.allLiveDataList[index].vendorProductUpdatedDate!.year <=
                                                                                0
                                                                        ? DateFormat('dd/MMM/yyyy').format(homeController
                                                                  .allLiveDataList[
                                                              index]
                                                                  .vendorProductCreatedDate!)
                                                                        : DateFormat('dd/MMM/yyyy').format(homeController
                                                                            .allLiveDataList[
                                                                                index]
                                                                            .vendorProductUpdatedDate!),
                                                                    style:
                                                                        TextStyle(
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
                                                                      color: ConstHelper
                                                                          .blackColor
                                                                          .withOpacity(
                                                                              0.6),
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                      text: '  '),
                                                                  TextSpan(
                                                                    text: homeController.allLiveDataList[index].vendorProductUpdatedTime ==
                                                                                null ||
                                                                            homeController
                                                                                .allLiveDataList[
                                                                                    index]
                                                                                .vendorProductUpdatedTime!
                                                                                .trim()
                                                                                .isEmpty
                                                                        ? DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                        .allLiveDataList[
                                                                    index]
                                                                        .vendorProductCreatedTime!))
                                                                        : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController
                                                                            .allLiveDataList[
                                                                                index]
                                                                            .vendorProductUpdatedTime!)),
                                                                    style:
                                                                        TextStyle(
                                                                          fontSize: Get.width*0.035,
                                                                          letterSpacing: 1,
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
                                                          homeController.allLiveDataList[index].vendorProductUpdatedDate ==
                                                              null ||
                                                              homeController.allLiveDataList[index].vendorProductUpdatedDate!.year <=
                                                                  0
                                                              ?SizedBox():  Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Text("View More",style: TextStyle(color: ConstHelper.darkBlueColor,decoration: TextDecoration.underline, fontSize: Get.width*0.035,
                                                                  letterSpacing: 1,fontWeight: FontWeight.w600),))
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
    ),);
  }
   categoryItemShowDialog({String? title, String? amount,String? size, String? date, List<CategoryItem>? itemList}){
    return Get.dialog(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20),
        ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child:Text((title??"").toUpperCase(), style: TextStyle(
                  color: ConstHelper.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width*0.045,
                  letterSpacing: 1,
                ),),),
                Expanded(child:  Text("₹${amount??""}", style: TextStyle(
                  color: ConstHelper.darkBlueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.width*0.045,
                  letterSpacing: 1,
                ),),),

              ],
            ),
            ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context, index) {
              return Row(
                  children: [
             Text(
              itemList[index].vendorProductUpdatedDate?.toString()??"" , style: TextStyle(
              color: ConstHelper.blackColor,
              fontWeight: FontWeight.w400,
              fontSize: Get.width*0.045,
                  letterSpacing: 1,
              ),),
              Expanded(child:  Text(itemList[index].vendorProductRate?.toString()??"",
                textAlign:TextAlign.end,
                style: TextStyle(
              color: ConstHelper.darkBlueColor,
              fontWeight: FontWeight.w400,
              fontSize: Get.width*0.045,
                  letterSpacing: 1,
              ),),)]);
            }, separatorBuilder: (context, index) => const SizedBox(height: 10,), itemCount: itemList!.length)
          ],
        ),
      ),
    );
  }
}
