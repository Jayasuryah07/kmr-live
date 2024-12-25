import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmr/Controllers/HomeController.dart';
import 'package:kmr/Utils/ConstHelper.dart';

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
    homeController.getRateData(
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
                  ? homeController.searchedRatesDataList.isEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await homeController.getRateData(
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
                                  top: Get.height / 2.8,
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
                            print("GGGGGGGGGGG ${homeController.selectCategoryData.value.categoryName!}");
                            await homeController.getRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                                subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView.builder(
                            itemCount:
                                homeController.searchedRatesDataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
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
                                            Container(
                                              height: Get.width / 10,
                                              width: Get.width / 10,
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
                                                      fontSize: 15,
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
                                                      fontSize: 13,
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
                                                            fontSize: 12,
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
                                                            fontSize: 12,
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
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ))),
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                          "QUANTITY",
                                                          style: TextStyle(
                                                              color: Color(0xff001417),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ))),
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                          "Min/Maz (+/-)",
                                                          style: TextStyle(
                                                              color: Color(0xff001417),
                                                              fontSize: 12,
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
                                                            fontSize: 12),
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
                                                            fontSize: 12),
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
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ]),
                                              ]),
                                        ),
                                        SizedBox(height: homeController.searchedRatesDataList[index].vendorProduct == null || homeController.searchedRatesDataList[index].vendorProduct!.isEmpty?0:Get.width/60,),
                                        homeController.searchedRatesDataList[index].vendorProduct == null || homeController.searchedRatesDataList[index].vendorProduct!.isEmpty?Text(""):Align(
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
                                                                                fontSize: 12,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ))),
                                                                  DataColumn(
                                                                      label: Expanded(
                                                                          child: Text(
                                                                            "QUANTITY",
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: 12,
                                                                                fontWeight:
                                                                                FontWeight.w500),
                                                                          ))),
                                                                  DataColumn(
                                                                      label: Expanded(
                                                                          child: Text(
                                                                            "Min/Maz (+/-)",
                                                                            style: TextStyle(
                                                                                color: Color(0xff001417),
                                                                                fontSize: 12,
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
                                                                              fontSize: 12),
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
                                                                              fontSize: 12),
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
                                                                              fontSize: 12),
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
                                                child: Text("View More",style: TextStyle(color: ConstHelper.greyColor,fontSize: 12,fontWeight: FontWeight.w600),)))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                  : homeController.allRatesDataList.isEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            print("GGGGGGGGGGG ${homeController.selectCategoryData.value.categoryName!}");
                            await homeController.getRateData(
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
                                  top: Get.height / 2.8,
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
                            print("PPPPPPPPPP");
                            await homeController.getRateData(
                                categoryValue: homeController.selectCategoryData.value.categoryName!,
                                subCategoryValue: homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].categorySubName!
                            );
                          },
                          backgroundColor: ConstHelper.whiteColor,
                          color: ConstHelper.darkBlueColor,
                          child: ListView.builder(
                            itemCount: homeController.allRatesDataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: Get.width / 10,
                                              width: Get.width / 10,
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
                                                      fontSize: 15,
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
                                                          .withOpacity(0.6),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: homeController
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
                                                                      .vendorCreatedDate!),
                                                          style: TextStyle(
                                                            fontSize: 12,
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
                                                                      .vendorCreatedTime!)),
                                                          style: TextStyle(
                                                            fontSize: 12,
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
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ))),
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                  "QUANTITY",
                                                  style: TextStyle(
                                                      color: Color(0xff001417),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ))),
                                                DataColumn(
                                                    label: Expanded(
                                                        child: Text(
                                                  "Min/Maz (+/-)",
                                                  style: TextStyle(
                                                      color: Color(0xff001417),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ))),
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
                                                            color: Color(
                                                                0xff5D646C),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
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
                                                            fontSize: 12),
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
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ]),
                                              ]),
                                        ),
                                        SizedBox(height: homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty?0:Get.width/60,),
                                        homeController.allRatesDataList[index].vendorProduct == null || homeController.allRatesDataList[index].vendorProduct!.isEmpty || homeController.allRatesDataList[index].vendorProduct!.length < 2 ? Text(""):Align(
                                          alignment: Alignment.centerRight,
                                            child: InkWell(
                                                onTap: () {
                                                  showDialog(context: context, builder: (context) {
                                                    return Dialog(
                                                      backgroundColor: ConstHelper.whiteColor,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
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
                                                                                  fontSize: 12,
                                                                                  fontWeight:
                                                                                  FontWeight.w500),
                                                                            ))),
                                                                    DataColumn(
                                                                        label: Expanded(
                                                                            child: Text(
                                                                              "QUANTITY",
                                                                              style: TextStyle(
                                                                                  color: Color(0xff001417),
                                                                                  fontSize: 12,
                                                                                  fontWeight:
                                                                                  FontWeight.w500),
                                                                            ))),
                                                                    DataColumn(
                                                                        label: Expanded(
                                                                            child: Text(
                                                                              "Min/Maz (+/-)",
                                                                              style: TextStyle(
                                                                                  color: Color(0xff001417),
                                                                                  fontSize: 12,
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
                                                                                fontSize: 12),
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
                                                                                fontSize: 12),
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
                                                                                fontSize: 12),
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },);
                                                },
                                                splashColor: Colors.transparent,
                                                borderRadius: BorderRadius.circular(10),
                                                child: Text("View More",style: TextStyle(color: ConstHelper.greyColor,fontSize: 12,fontWeight: FontWeight.w600),)))
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
