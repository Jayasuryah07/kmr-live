
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ConstHelper.dart';


class RatesPage extends StatefulWidget {
  const RatesPage({super.key});

  @override
  State<RatesPage> createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    if( homeController.allSubCategoryDataList.isNotEmpty) {
      var val;
      if(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub! == "All"){
        val ="";
      }else{
        val = homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!;
      }
      homeController.getRateData(
        categoryValue: homeController.selectCategoryData.value.categoryName!,
          subCategoryValue:val
    );
    }else{
      homeController.allRatesDataList.clear();
      homeController.searchedRatesDataList.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(homeController.allRatesDataList.isEmpty);
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
              : /*homeController.searchStart.value
                  ? homeController.searchedRatesDataList.isEmpty || homeController.searchedRatesDataList.every(
                (element) => element.vendorProduct!.isEmpty,
          )
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                                subCategoryValue: homeController.allSubCategoryDataList .isEmpty?homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!:""
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: Get.height / 2.8,
                                ),
                                child: Center(
                                  child: Text(
                                    ConstHelper.dataNotAvailableMsg,
                                    style: TextStyle(
                                      color: ConstHelper.darkBlueColor,
                                      fontWeight: FontWeight.w600,
                                        fontSize: Get.width*0.045,
                                        letterSpacing: 1
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            print("GGGGGGGGGGG ${homeController.selectCategoryData.value.categoryName!}");
                            await homeController.getRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                                subCategoryValue: homeController.allSubCategoryDataList .isEmpty?homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!:""
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView.builder(
                            itemCount:
                                homeController.searchedRatesDataList.length,
                            itemBuilder: (context, index) {
                              return homeController.searchedRatesDataList[index].vendorProduct == null || homeController.searchedRatesDataList[index].vendorProduct!.isEmpty ?SizedBox():Padding(
                                padding: EdgeInsets.only(
                                  top: Get.width / 30,
                                  bottom: (index + 1) !=
                                          homeController
                                              .searchedRatesDataList.length
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
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: Get.width / 7,
                                              width: Get.width / 7,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(6),
                                                child: CachedNetworkImage(
                                                  imageUrl:  ConstHelper.subCategoryImagePath+homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!,
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
                                                                    .searchedRatesDataList[
                                                                        index]
                                                                    .vendorName ==
                                                                null ||
                                                            homeController
                                                                .searchedRatesDataList[
                                                                    index]
                                                                .vendorName!
                                                                .trim()
                                                                .isEmpty
                                                        ? 'Name N/A'
                                                        : homeController
                                                            .searchedRatesDataList[
                                                                index]
                                                            .vendorName!,
                                                    style: TextStyle(
                                                      color: ConstHelper
                                                          .blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: Get.width*0.045,
                                                    ),
                                                  ),
                                                  Text(
                                                    homeController
                                                                    .searchedRatesDataList[
                                                                        index]
                                                                    .vendorCity ==
                                                                null ||
                                                            homeController
                                                                .searchedRatesDataList[
                                                                    index]
                                                                .vendorCity!
                                                                .trim()
                                                                .isEmpty
                                                        ? 'City N/A'
                                                        : homeController
                                                            .searchedRatesDataList[
                                                                index]
                                                            .vendorCity!,
                                                    style: TextStyle(
                                                      color: ConstHelper
                                                          .blackColor
                                                          .withOpacity(0.6),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: Get.width*0.04,
                                                    ),
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: homeController
                                                                          .searchedRatesDataList[
                                                                              index]
                                                                          .vendorCreatedDate ==
                                                                      null ||
                                                                  homeController
                                                                          .searchedRatesDataList[
                                                                              index]
                                                                          .vendorCreatedDate!
                                                                          .year <=
                                                                      0
                                                              ? 'Date N/A'
                                                              : DateFormat(
                                                                      'dd/MMM/yyyy')
                                                                  .format(homeController
                                                                      .searchedRatesDataList[
                                                                          index]
                                                                      .vendorCreatedDate!),
                                                          style: TextStyle(
                                                            fontSize: Get.width*0.035,
                                                            color: ConstHelper
                                                                .blackColor
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                            text: '  '),
                                                        TextSpan(
                                                          text: homeController
                                                                          .searchedRatesDataList[
                                                                              index]
                                                                          .vendorCreatedTime ==
                                                                      null ||
                                                                  homeController
                                                                      .searchedRatesDataList[
                                                                          index]
                                                                      .vendorCreatedTime!
                                                                      .trim()
                                                                      .isEmpty
                                                              ? 'Time N/A'
                                                              : DateFormat('hh:mm a').format(DateFormat(
                                                                      "HH:mm:ss")
                                                                  .parse(homeController
                                                                      .searchedRatesDataList[
                                                                          index]
                                                                      .vendorCreatedTime!)),
                                                          style: TextStyle(
                                                            fontSize: Get.width*0.035,
                                                            color: ConstHelper
                                                                .blackColor
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width / 60,
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.call_rounded,
                                                    color:
                                                        ConstHelper.blackColor,
                                                    size: Get.width / 18,
                                                  ),
                                                ),
                                                // SizedBox(height: Get.width/60,),
                                                // Obx(
                                                //   () => Icon(Icons.favorite,color: homeController.favorite.value == true?Colors.redAccent:Color(0xffAEB2B6),size: 24,),
                                                // )
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD8F2FF),
                                            borderRadius:
                                            BorderRadius.circular(5),
                                          ),
                                          child: DataTable(
                                              columnSpacing: Get.width / 10,
                                              columns: [
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                          "BRAND",
                                                          style: TextStyle(
                                                              color: Color(0xff001417),
                                                              fontSize: Get.width*0.035,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ))),
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                          "QUANTITY",
                                                          style: TextStyle(
                                                              color: Color(0xff001417),
                                                              fontSize: Get.width*0.035,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ))),
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                          "Min/Maz (+/-)",
                                                          style: TextStyle(
                                                              color: Color(0xff001417),
                                                              fontSize: Get.width*0.035,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ))),
                                              ],
                                              rows: [

                                                for (int j = 0; j < (homeController.searchedRatesDataList[index].vendorProduct == null || homeController.searchedRatesDataList[index].vendorProduct!.isEmpty?0:homeController.searchedRatesDataList[index].vendorProduct!.sublist(0,2).length); j++)
                                                  DataRow(cells: [
                                                    DataCell(
                                                      Text(
                                                        homeController
                                                            .searchedRatesDataList[
                                                        index]
                                                            .vendorProduct![
                                                        j]
                                                            .vendorProduct ==
                                                            null ||
                                                            homeController
                                                                .searchedRatesDataList[
                                                            index]
                                                                .vendorProduct![
                                                            j]
                                                                .vendorProduct!
                                                                .trim()
                                                                .isEmpty
                                                            ? ConstHelper.naMsg
                                                            : homeController
                                                            .searchedRatesDataList[
                                                        index]
                                                            .vendorProduct![
                                                        j]
                                                            .vendorProduct!,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff5D646C),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: Get.width*0.035,),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        homeController
                                                            .searchedRatesDataList[
                                                        index]
                                                            .vendorProduct![
                                                        j]
                                                            .vendorProductSize ==
                                                            null ||
                                                            homeController
                                                                .searchedRatesDataList[
                                                            index]
                                                                .vendorProduct![
                                                            j]
                                                                .vendorProductSize!
                                                                .trim()
                                                                .isEmpty
                                                            ? ConstHelper.naMsg
                                                            : homeController
                                                            .searchedRatesDataList[
                                                        index]
                                                            .vendorProduct![
                                                        j]
                                                            .vendorProductSize!,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff5D646C),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: Get.width*0.035,),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        homeController
                                                            .searchedRatesDataList[
                                                        index]
                                                            .vendorProduct![
                                                        j]
                                                            .vendorProductRate ==
                                                            null ||
                                                            homeController
                                                                .searchedRatesDataList[
                                                            index]
                                                                .vendorProduct![
                                                            j]
                                                                .vendorProductRate ==
                                                                0
                                                            ? ConstHelper.naMsg
                                                            : '${homeController.searchedRatesDataList[index].vendorProduct![j].vendorProductRate!}',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff5D646C),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: Get.width*0.035,),
                                                      ),
                                                    ),
                                                  ]),
                                              ]),
                                        ),
                                        SizedBox(height: homeController.searchedRatesDataList[index].vendorProduct == null || homeController.searchedRatesDataList[index].vendorProduct!.isEmpty?0:Get.width/60,),
                                        homeController.searchedRatesDataList[index].vendorProduct == null || homeController.searchedRatesDataList[index].vendorProduct!.isEmpty?Text(""):
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                                onTap: () {
                                                  showDialog(context: context, builder: (context) {
                                                    return Dialog(
                                                      backgroundColor: ConstHelper.whiteColor,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: ConstHelper.whiteColor,
                                                              border: Border.all(color: ConstHelper.darkBlueColor),
                                                              borderRadius:
                                                              BorderRadius.circular(5),
                                                            ),
                                                            child: DataTable(
                                                                columnSpacing: Get.width / 10,
                                                                columns: [
                                                                  DataColumn(
                                                                      label: Expanded(
                                                                          child: Text(
                                                                            "BRAND",
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: Get.width*0.035,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ))),
                                                                  DataColumn(
                                                                      label: Expanded(
                                                                          child: Text(
                                                                            "QUANTITY",
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: Get.width*0.035,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ))),
                                                                  DataColumn(
                                                                      label: Expanded(
                                                                          child: Text(
                                                                            "Min/Maz (+/-)",
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: Get.width*0.035,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ))),
                                                                ],
                                                                rows: [

                                                                  for (int j = 0; j < (homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty?0:homeController.allRatesDataList[index].vendorProduct!.length); j++)
                                                                    DataRow(cells: [
                                                                      DataCell(
                                                                        Text(
                                                                          homeController
                                                                              .allRatesDataList[
                                                                          index]
                                                                              .vendorProduct![
                                                                          j]
                                                                              .vendorProduct ==
                                                                              null ||
                                                                              homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProduct!
                                                                                  .trim()
                                                                                  .isEmpty
                                                                              ? ConstHelper.naMsg
                                                                              : homeController
                                                                              .allRatesDataList[
                                                                          index]
                                                                              .vendorProduct![
                                                                          j]
                                                                              .vendorProduct!,
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xff5D646C),
                                                                              fontWeight:
                                                                              FontWeight.w500,
                                                                              fontSize: Get.width*0.035,),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                          homeController
                                                                              .allRatesDataList[
                                                                          index]
                                                                              .vendorProduct![
                                                                          j]
                                                                              .vendorProductSize ==
                                                                              null ||
                                                                              homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProductSize!
                                                                                  .trim()
                                                                                  .isEmpty
                                                                              ? ConstHelper.naMsg
                                                                              : homeController
                                                                              .allRatesDataList[
                                                                          index]
                                                                              .vendorProduct![
                                                                          j]
                                                                              .vendorProductSize!,
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xff5D646C),
                                                                              fontWeight:
                                                                              FontWeight.w500,
                                                                              fontSize: Get.width*0.035,),
                                                                        ),
                                                                      ),
                                                                      DataCell(
                                                                        Text(
                                                                          homeController
                                                                              .allRatesDataList[
                                                                          index]
                                                                              .vendorProduct![
                                                                          j]
                                                                              .vendorProductRate ==
                                                                              null ||
                                                                              homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProductRate ==
                                                                                  0
                                                                              ? ConstHelper.naMsg
                                                                              : '${homeController.allRatesDataList[index].vendorProduct![j].vendorProductRate!}',
                                                                          style: TextStyle(
                                                                              color: Color(
                                                                                  0xff5D646C),
                                                                              fontWeight:
                                                                              FontWeight.w500,
                                                                              fontSize: Get.width*0.035,),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },);
                                                },
                                                splashColor: Colors.transparent,
                                                borderRadius: BorderRadius.circular(10),
                                                child: Text("View More",style: TextStyle(color: ConstHelper.greyColor,fontSize: Get.width*0.035,fontWeight: FontWeight.w600),)))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                  : */homeController.allRatesDataList.isEmpty || homeController.allRatesDataList.every(
                (element) => element.vendorProduct!.isEmpty,
          )
                      ? RefreshIndicator(
                          onRefresh: () async {
                            print("GGGGGGGGGGG ${homeController.selectCategoryData.value.categoryName!}");
                            var val;
                            if(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub! == "All"){
                              val ="";
                            }else{
                              val = homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!;
                            }
                            await homeController.getRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                                subCategoryValue:val
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: Get.height*0.9,
                                width: Get.width,
                                child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [ Padding(
                                  padding: EdgeInsets.symmetric(
                                    // vertical: Get.height / 3.8,
                                    horizontal: Get.width * 0.04,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Oops! Nothing here now—fresh content incoming!",
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
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            print("PPPPPPPPPP");
                            var val;
                            if(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub! == "All"){
                              val ="";
                            }else{
                              val = homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!;
                            }
                            await homeController.getRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                                subCategoryValue:val
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView.builder(
                            itemCount: homeController.allRatesDataList.length,
                            itemBuilder: (context, index) {
                           //   print(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub);
                              return homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty ?SizedBox():Padding(
                                padding: EdgeInsets.only(
                                  top: Get.width / 30,
                                  bottom: (index + 1) !=
                                          homeController.allRatesDataList.length
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
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                     // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: Get.width / 5,
                                              width: Get.width / 5,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(6),
                                                child: CachedNetworkImage(
                                                  imageUrl:homeController.allRatesDataList[index].vendorProduct != null && homeController.allRatesDataList[index].vendorProduct!.isNotEmpty?ConstHelper.subCategoryImagePath+(homeController.allRatesDataList[index].vendorProduct?.first.categoriesSubImages??""):"",
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
                                                                    .allRatesDataList[
                                                                        index]
                                                                    .vendorName ==
                                                                null ||
                                                            homeController
                                                                .allRatesDataList[
                                                                    index]
                                                                .vendorName!
                                                                .trim()
                                                                .isEmpty
                                                        ? 'Name N/A'
                                                        : homeController
                                                            .allRatesDataList[
                                                                index]
                                                            .vendorName!,
                                                    style: TextStyle(
                                                      color: ConstHelper
                                                          .blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: Get.width*0.045,
                                                    ),
                                                  ),
                                                  Text(
                                                    homeController
                                                                    .allRatesDataList[
                                                                        index]
                                                                    .vendorCity ==
                                                                null ||
                                                            homeController
                                                                .allRatesDataList[
                                                                    index]
                                                                .vendorCity!
                                                                .trim()
                                                                .isEmpty
                                                        ? 'City N/A'
                                                        : homeController
                                                            .allRatesDataList[
                                                                index]
                                                            .vendorCity!,
                                                    style: TextStyle(
                                                      color: ConstHelper
                                                          .blackColor
                                                          .withOpacity(0.9),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: Get.width*0.04,
                                                    ),
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:  "🗓️${homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorCreatedDate ==
                                                              null ||
                                                              homeController
                                                                  .allRatesDataList[
                                                              index]
                                                                  .vendorCreatedDate!
                                                                  .year <=
                                                                  0
                                                              ? 'Date N/A'
                                                              : DateFormat(
                                                              'dd/MMM/yyyy')
                                                              .format(homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorCreatedDate!)}",
                                                          style: TextStyle(
                                                            fontSize: Get.width*0.03,
                                                            letterSpacing: 1,
                                                            fontWeight: FontWeight.w400,
                                                            color: ConstHelper.blackColor
                                                                .withOpacity(0.9),
                                                          ),
                                                        ),
                                                        const TextSpan(text: '  '),
                                                        TextSpan(
                                                          text:  "🕒${homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorCreatedTime ==
                                                              null ||
                                                              homeController
                                                                  .allRatesDataList[
                                                              index]
                                                                  .vendorCreatedTime!
                                                                  .trim()
                                                                  .isEmpty
                                                              ? 'Time N/A'
                                                              : DateFormat('hh:mm a').format(DateFormat(
                                                              "HH:mm:ss")
                                                              .parse(homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorCreatedTime!))}",
                                                          style: TextStyle(
                                                            fontSize: Get.width*0.03,
                                                            letterSpacing: 1,
                                                            fontWeight: FontWeight.w400,
                                                            color: ConstHelper.blackColor
                                                                .withOpacity(0.9),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width / 60,
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    _launchURL("tel: ${homeController
                                                        .allRatesDataList[
                                                    index]
                                                        .vendorMobile??""}");
                                                  },
                                                  icon: Icon(
                                                    Icons.call_rounded,
                                                    color:
                                                        ConstHelper.blackColor,
                                                    size: Get.width / 18,
                                                  ),
                                                ),
                                                // SizedBox(height: Get.width/60,),
                                                // Obx(
                                                //   () => Icon(Icons.favorite,color: homeController.favorite.value == true?Colors.redAccent:Color(0xffAEB2B6),size: 24,),
                                                // )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child:  DataTable(
                                                horizontalMargin: Get.width*0.02,
                                                headingRowHeight: Get.height*0.05,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffD8F2FF),
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                ),
                                                columnSpacing: Get.width *0.04,
                                                columns: [
                                                  DataColumn(
                                                    label: Expanded(
                                                      child: Text(
                                                        "BRAND",
                                                        style: TextStyle(
                                                            color: Color(0xff001417),
                                                            fontSize: Get.width*0.035,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),),),
                                                  DataColumn(
                                                    label: Expanded(
                                                      child: Text(
                                                        "QUANTITY",
                                                        style: TextStyle(
                                                            color: Color(0xff001417),
                                                            fontSize: Get.width*0.035,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),),),
                                                  DataColumn(
                                                    label: Expanded(
                                                      child: Text(
                                                        "Min/Max (+/-)",
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(0xff001417),
                                                            fontSize: Get.width*0.035,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                rows: [
                                                  for (int j = 0; j < (homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty?0:homeController.allRatesDataList[index].vendorProduct!.length < 2 ? homeController.allRatesDataList[index].vendorProduct!.length : homeController.allRatesDataList[index].vendorProduct!.sublist(0,2).length); j++)
                                                    DataRow(cells: [
                                                      DataCell(
                                                        Text(
                                                          homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorProduct![
                                                          j]
                                                              .vendorProduct ==
                                                              null ||
                                                              homeController
                                                                  .allRatesDataList[
                                                              index]
                                                                  .vendorProduct![
                                                              j]
                                                                  .vendorProduct!
                                                                  .trim()
                                                                  .isEmpty
                                                              ? ConstHelper.naMsg
                                                              : homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorProduct![
                                                          j]
                                                              .vendorProduct!,
                                                          style: TextStyle(
                                                            color:ConstHelper.blackColor
                                                                .withOpacity(0.9),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: Get.width*0.035,),
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorProduct![
                                                          j]
                                                              .vendorProductSize ==
                                                              null ||
                                                              homeController
                                                                  .allRatesDataList[
                                                              index]
                                                                  .vendorProduct![
                                                              j]
                                                                  .vendorProductSize!
                                                                  .trim()
                                                                  .isEmpty
                                                              ? ConstHelper.naMsg
                                                              : homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorProduct![
                                                          j]
                                                              .vendorProductSize!,
                                                          style: TextStyle(
                                                            color:ConstHelper.blackColor
                                                                .withOpacity(0.9),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: Get.width*0.035,),
                                                        ),
                                                      ),
                                                      DataCell(
                                                        Text(
                                                          homeController
                                                              .allRatesDataList[
                                                          index]
                                                              .vendorProduct![
                                                          j]
                                                              .vendorProductRate ==
                                                              null ||
                                                              homeController
                                                                  .allRatesDataList[
                                                              index]
                                                                  .vendorProduct![
                                                              j]
                                                                  .vendorProductRate ==
                                                                  0
                                                              ? ConstHelper.naMsg
                                                              : '₹ ${homeController.allRatesDataList[index].vendorProduct![j].vendorProductRate!}',
                                                          style: TextStyle(
                                                            color: ConstHelper.blackColor
                                                                .withOpacity(0.9),
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontSize: Get.width*0.035,),
                                                        ),
                                                      ),
                                                    ]),
                                                ]),),
                                          ],
                                        ),

                                        SizedBox(height: homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty?0:Get.width/60,),

                                        Align(
                                          alignment: Alignment.centerRight,
                                            child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:ConstHelper.whiteColor,
                                                        surfaceTintColor: ConstHelper.whiteColor,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Get.width*0.03))),
                                                        insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.025), // 95% width
                                                        titlePadding: EdgeInsets.only(top: 10,right: 10,bottom: 10),
                                                        title: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){
                                                                Navigator.pop(context);
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.all(3),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ConstHelper.greyColor.withOpacity(0.5)
                                                                  ),
                                                                  child: Icon(Icons.close,color: ConstHelper.blackColor,)),
                                                            ),
                                                          ],
                                                        ),
                                                        contentPadding: EdgeInsets.only(bottom: Get.height*0.01),
                                                        content:  Container(
                                                            width: Get.width*0.9,
                                                            height: Get.height * 0.85,
                                                          decoration: BoxDecoration(
                                                            color: ConstHelper.whiteColor,
                                                            //  border: Border.all(color: ConstHelper.darkBlueColor),
                                                              borderRadius: BorderRadius.all(Radius.circular(Get.width*0.03))

                                                          ),
                                                        child:   SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.04,vertical:  MediaQuery.of(context).size.height*0.01),
                                                                decoration: BoxDecoration(
                                                                  color: ConstHelper.whiteColor,
                                                                //  border: Border.all(color: ConstHelper.darkBlueColor),
                                                                  borderRadius:
                                                                  BorderRadius.circular(5),
                                                                ),
                                                                child: DataTable(
                                                                    columnSpacing: Get.width *0.01,
                                                                    horizontalMargin: 0,
                                                                    columns: [
                                                                      DataColumn(
                                                                        label: Expanded(
                                                                          child: Text(
                                                                            "BRAND",
                                                                            softWrap: true,
                                                                            maxLines: 2,
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: Get.width*0.04,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ),),),
                                                                      DataColumn(
                                                                        label: Expanded(
                                                                          child: Text(
                                                                            "QUANTITY",
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: Get.width*0.04,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ),),),
                                                                      DataColumn(
                                                                        label: Expanded(
                                                                          child: Text(
                                                                            "Min/Max (+/-)",
                                                                            softWrap: true,
                                                                            maxLines: 2,
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: const Color(0xff001417),
                                                                                fontSize: Get.width*0.04,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    rows: [

                                                                      for (int j = 0; j < (homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty?0:homeController.allRatesDataList[index].vendorProduct!.length); j++)
                                                                        DataRow(cells: [
                                                                          DataCell(
                                                                            Text(
                                                                              homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProduct ==
                                                                                  null ||
                                                                                  homeController
                                                                                      .allRatesDataList[
                                                                                  index]
                                                                                      .vendorProduct![
                                                                                  j]
                                                                                      .vendorProduct!
                                                                                      .trim()
                                                                                      .isEmpty
                                                                                  ? ConstHelper.naMsg
                                                                                  : homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProduct!,
                                                                              style: TextStyle(
                                                                                  color: ConstHelper.blackColor
                                                                                      .withOpacity(0.9),
                                                                                  fontWeight:
                                                                                  FontWeight.w500,
                                                                                  fontSize: Get.width*0.035),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Text(
                                                                              homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProductSize ==
                                                                                  null ||
                                                                                  homeController
                                                                                      .allRatesDataList[
                                                                                  index]
                                                                                      .vendorProduct![
                                                                                  j]
                                                                                      .vendorProductSize!
                                                                                      .trim()
                                                                                      .isEmpty
                                                                                  ? ConstHelper.naMsg
                                                                                  : homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProductSize!,
                                                                              style: TextStyle(
                                                                                  color:ConstHelper.blackColor
                                                                                      .withOpacity(0.9),
                                                                                  fontWeight:
                                                                                  FontWeight.w500,
                                                                                  fontSize: Get.width*0.035),
                                                                            ),
                                                                          ),
                                                                          DataCell(
                                                                            Text(
                                                                              homeController
                                                                                  .allRatesDataList[
                                                                              index]
                                                                                  .vendorProduct![
                                                                              j]
                                                                                  .vendorProductRate ==
                                                                                  null ||
                                                                                  homeController
                                                                                      .allRatesDataList[
                                                                                  index]
                                                                                      .vendorProduct![
                                                                                  j]
                                                                                      .vendorProductRate ==
                                                                                      0
                                                                                  ? ConstHelper.naMsg
                                                                                  : '₹ ${homeController.allRatesDataList[index].vendorProduct![j].vendorProductRate!}',
                                                                              style: TextStyle(
                                                                                  color:ConstHelper.blackColor
                                                                                      .withOpacity(0.9),
                                                                                  fontWeight:
                                                                                  FontWeight.w500,
                                                                                  fontSize: Get.width*0.035),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                      );
                                                    },
                                                  );
                                                },
                                                splashColor: Colors.transparent,
                                                borderRadius: BorderRadius.circular(10),
                                                child: Text("View More",style: TextStyle(color: ConstHelper.darkBlueColor,decoration:TextDecoration.underline,fontSize: Get.width*0.035,fontWeight: FontWeight.w600),),),),
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
void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw 'Could not launch $url';
  }
}