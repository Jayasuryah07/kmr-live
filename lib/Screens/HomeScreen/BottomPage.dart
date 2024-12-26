import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Models/VendorRateDataModel.dart';
import '../../Utils/ConstHelper.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  HomeController homeController = Get.put(HomeController());

  // RxInt selectedIndex = 0.obs;

  InputDecoration searchInputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: ConstHelper.whiteColor.withOpacity(0.3),
        width: 1.5,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: ConstHelper.whiteColor.withOpacity(0.3),
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: ConstHelper.whiteColor.withOpacity(0.3),
        width: 1.5,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: Get.width / 30,
    ),
    hintText: 'Search....',
    hintStyle: TextStyle(
      color: ConstHelper.whiteColor.withOpacity(0.7),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    homeController.selectedTabIndex.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: homeController.selectedIndex.value == 0 ||
                  homeController.selectedIndex.value == 1
              ? AppBar(
                  backgroundColor: ConstHelper.darkBlueColor,
                  // leading: IconButton(
                  //   onPressed: () {},
                  //   icon: SvgPicture.asset(
                  //     'assets/image/menuSVG.svg',
                  //     height: Get.width / 18,
                  //     width: Get.width / 18,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  leading: IconButton(
                    onPressed: () {
                      if (homeController.searchClick.value) {
                        homeController.txtSearch.clear();
                        homeController.searchFocusNode.unfocus();
                        homeController.searchClick.value = false;
                        homeController.searchStart.value = false;
                      } else {
                        Get.back();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: ConstHelper.whiteColor,
                    ),
                  ),
                  title: Obx(
                    () => homeController.searchClick.value
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              controller: homeController.txtSearch,
                              focusNode: homeController.searchFocusNode,
                              textInputAction: TextInputAction.search,
                              cursorColor: ConstHelper.whiteColor,
                              decoration: searchInputDecoration,
                              style: TextStyle(
                                color: ConstHelper.whiteColor,
                              ),
                              onChanged: (value) {
                                homeController.searchStart.value =
                                    value.trim().isNotEmpty;
                                if (value.trim().isNotEmpty) {
                                  String searchValue =
                                      value.trim().toLowerCase();
                                  if (homeController.selectedIndex.value == 0) {
                                    homeController.searchedLiveDataList.value =
                                        homeController.allLiveDataList.where(
                                      (p0) {
                                        String date = p0.vendorProductCreatedDate ==
                                                    null ||
                                                p0.vendorProductCreatedDate!
                                                        .year <=
                                                    0
                                            ? ''
                                            : DateFormat('dd/MMM/yyyy').format(
                                                p0.vendorProductCreatedDate!);
                                        String time = p0.vendorProductCreatedTime ==
                                                    null ||
                                                p0.vendorProductCreatedTime!
                                                    .trim()
                                                    .isEmpty
                                            ? ''
                                            : DateFormat('hh:mm a').format(
                                                DateFormat("HH:mm:ss").parse(p0
                                                    .vendorProductCreatedTime!));
                                        return p0.vendorProduct
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            p0.vendorProductSize
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            p0.vendorProductRate
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            date
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            time
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue);
                                      },
                                    ).toList();
                                  } else if (homeController
                                          .selectedIndex.value ==
                                      1) {
                                    homeController.searchedRatesDataList.value =
                                        homeController.allRatesDataList.where(
                                      (p0) {
                                        String date = p0.vendorCreatedDate ==
                                                    null ||
                                                p0.vendorCreatedDate!.year <= 0
                                            ? ''
                                            : DateFormat('dd/MMM/yyyy')
                                                .format(p0.vendorCreatedDate!);
                                        String time = p0.vendorCreatedTime ==
                                                    null ||
                                                p0.vendorCreatedTime!
                                                    .trim()
                                                    .isEmpty
                                            ? ''
                                            : DateFormat('hh:mm a').format(
                                                DateFormat("HH:mm:ss").parse(
                                                    p0.vendorCreatedTime!));
                                        List<VendorProduct> vendorProduct =
                                            p0.vendorProduct ?? [];
                                        return p0.vendorProduct
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            p0.vendorName
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            p0.vendorCity
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            date
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            time
                                                .toString()
                                                .trim()
                                                .toLowerCase()
                                                .contains(searchValue) ||
                                            vendorProduct
                                                .where(
                                                  (element) =>
                                                      element.vendorProduct
                                                          .toString()
                                                          .trim()
                                                          .toLowerCase()
                                                          .contains(
                                                              searchValue) ||
                                                      element.vendorProductSize
                                                          .toString()
                                                          .trim()
                                                          .toLowerCase()
                                                          .contains(
                                                              searchValue) ||
                                                      element.vendorProductRate
                                                          .toString()
                                                          .trim()
                                                          .toLowerCase()
                                                          .contains(
                                                              searchValue),
                                                )
                                                .toList()
                                                .isNotEmpty;
                                      },
                                    ).toList();
                                  }
                                }
                              },
                            ),
                          )
                        : Text(
                            'KMR LIVE',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                  ),
                  actions: [
                    // SvgPicture.asset(
                    //   'assets/image/heartSVG.svg',
                    //   height: Get.width / 22,
                    //   width: Get.width / 22,
                    //   fit: BoxFit.cover,
                    // ),
                    // SizedBox(
                    //   width: Get.width / 30,
                    // ),
                    // SvgPicture.asset(
                    //   'assets/image/phoneSVG.svg',
                    //   height: Get.width / 22,
                    //   width: Get.width / 22,
                    //   fit: BoxFit.cover,
                    // ),
                    // SizedBox(
                    //   width: Get.width / 30,
                    // ),
                    IconButton(
                      onPressed: () {
                        if (homeController.searchClick.value) {
                          homeController.txtSearch.clear();
                          homeController.searchFocusNode.unfocus();
                          homeController.searchStart.value = false;
                        } else {
                          homeController.searchFocusNode.requestFocus();
                        }

                        homeController.searchClick.value =
                            !homeController.searchClick.value;
                      },
                      icon: Obx(
                        () => Icon(
                          homeController.searchClick.value
                              ? Icons.close_rounded
                              : Icons.search_rounded,
                          color: ConstHelper.whiteColor,
                          size: Get.width / 15,
                        ),
                      ),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(Get.width / 8),
                    child: DefaultTabController(
                      length: homeController.allSubCategoryDataList.length,
                      child: TabBar(
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        unselectedLabelColor: Colors.grey.shade400,
                        tabs: [
                          for (int i = 0;
                              i < homeController.allSubCategoryDataList.length;
                              i++)
                            Tab(
                              text:
                                  "${homeController.allSubCategoryDataList[i].categorySubName}",
                            ),
                        ],
                        onTap: (value) {
                          homeController.selectedTabIndex.value = value;
                          print("vvvvvvvv $value");
                          if (homeController.selectedIndex.value == 0) {
                            homeController.getLiveData(
                                categoryValue: homeController
                                    .selectCategoryData.value.categoryName!,
                                subCategoryValue: homeController
                                    .allSubCategoryDataList[
                                        homeController.selectedTabIndex.value]
                                    .categorySubName!);
                          } else if (homeController.selectedIndex.value == 1) {
                            homeController.getRateData(
                                categoryValue: homeController
                                    .selectCategoryData.value.categoryName!,
                                subCategoryValue: homeController
                                    .allSubCategoryDataList[
                                        homeController.selectedTabIndex.value]
                                    .categorySubName!);
                          }
                        },
                      ),
                    ),
                  ),
                )
              : AppBar(
                  backgroundColor: ConstHelper.darkBlueColor,
                  leading: IconButton(
                    onPressed: () {
                      if (homeController.searchClick.value) {
                        homeController.txtSearch.clear();
                        homeController.searchFocusNode.unfocus();
                        homeController.searchClick.value = false;
                        homeController.searchStart.value = false;
                      } else {
                        Get.back();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: ConstHelper.whiteColor,
                    ),
                  ),
                  title: Obx(
                    () => homeController.searchClick.value
                        ? TextField(
                            controller: homeController.txtSearch,
                            focusNode: homeController.searchFocusNode,
                            textInputAction: TextInputAction.search,
                            cursorColor: ConstHelper.whiteColor,
                            decoration: searchInputDecoration,
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                            ),
                            onChanged: (value) {
                              homeController.searchStart.value =
                                  value.trim().isNotEmpty;
                              if (value.trim().isNotEmpty) {
                                String searchValue = value.trim().toLowerCase();
                                if (homeController.selectedIndex.value == 2) {
                                  homeController
                                          .searchedSpotRateDataList.value =
                                      homeController.allSpotRateDataList.where(
                                    (p0) {
                                      String date = p0.vendorSpotCreatedDate ==
                                                  null ||
                                              p0.vendorSpotCreatedDate!.year <=
                                                  0
                                          ? ''
                                          : DateFormat('dd/MMM/yyyy').format(
                                              p0.vendorSpotCreatedDate!);
                                      String time = p0.vendorSpotCreatedTime ==
                                                  null ||
                                              p0.vendorSpotCreatedTime!
                                                  .trim()
                                                  .isEmpty
                                          ? ''
                                          : DateFormat('hh:mm a').format(
                                              DateFormat("HH:mm:ss").parse(
                                                  p0.vendorSpotCreatedTime!));
                                      return p0.vendorSpotHeading
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue) ||
                                          p0.vendorSpotDetails
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue) ||
                                          date
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue) ||
                                          time
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue);
                                    },
                                  ).toList();
                                } else if (homeController.selectedIndex.value ==
                                    3) {
                                  homeController.searchedNewsDataList.value =
                                      homeController.allNewsDataList.where(
                                    (p0) {
                                      String date =
                                          p0.newsCreatedDate == null ||
                                                  p0.newsCreatedDate!.year <= 0
                                              ? ''
                                              : DateFormat('dd/MMM/yyyy')
                                                  .format(p0.newsCreatedDate!);
                                      return p0.newsHeadlines
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue) ||
                                          p0.newsContent
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue) ||
                                          date
                                              .toString()
                                              .trim()
                                              .toLowerCase()
                                              .contains(searchValue);
                                    },
                                  ).toList();
                                }
                              }
                            },
                          )
                        : Text(
                            'KMR LIVE',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (homeController.searchClick.value) {
                          homeController.txtSearch.clear();
                          homeController.searchFocusNode.unfocus();
                          homeController.searchStart.value = false;
                        } else {
                          homeController.searchFocusNode.requestFocus();
                        }

                        homeController.searchClick.value =
                            !homeController.searchClick.value;
                      },
                      icon: Obx(
                        () => Icon(
                          homeController.searchClick.value
                              ? Icons.close_rounded
                              : Icons.search_rounded,
                          color: ConstHelper.whiteColor,
                          size: Get.width / 15,
                        ),
                      ),
                    ),
                  ],
                  // bottom: PreferredSize(
                  //     preferredSize: Size.fromHeight(Get.width / 10),
                  //     child: DefaultTabController(
                  //       length: 1,
                  //       child: TabBar(
                  //           labelColor: Colors.white,
                  //           indicatorColor: Colors.white,
                  //           isScrollable: true,
                  //           tabAlignment: TabAlignment.center,
                  //           unselectedLabelColor: Colors.grey.shade400,
                  //           tabs: [
                  //             Tab(
                  //               text: "Edible Oil",
                  //             ),
                  //           ]),
                  //     )),
                ),
          backgroundColor: ConstHelper.whiteColor,
          body: homeController.screens[homeController.selectedIndex.value],
          bottomNavigationBar: NavigationBar(
            backgroundColor: ConstHelper.whiteColor,
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.front_hand_outlined), label: "Live"),
              NavigationDestination(
                  icon: Icon(Icons.discount_outlined), label: "Rates"),
              NavigationDestination(
                  icon: Icon(Icons.splitscreen_outlined), label: "Spot"),
              NavigationDestination(icon: Icon(Icons.newspaper), label: "News"),
            ],
            selectedIndex: homeController.selectedIndex.value,
            onDestinationSelected: (value) {
              homeController.selectedTabIndex.value = value;
              print(value);
              homeController.txtSearch.clear();
              homeController.searchFocusNode.unfocus();
              homeController.searchStart.value = false;
              homeController.searchClick.value = false;
              homeController.selectedIndex.value = value;
              print("RRRRRRRRRRR ${homeController.selectedIndex.value}");
            },
            height: Get.width / 6,
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   backgroundColor: Colors.white,
          // items: [
          //   BottomNavigationBarItem(icon: Icon(Icons.front_hand_outlined),label: "Live"),
          //   BottomNavigationBarItem(icon: Icon(Icons.discount_outlined),label: "Rates"),
          //   BottomNavigationBarItem(icon: Icon(Icons.discount_outlined),label: "Spot"),
          //   BottomNavigationBarItem(icon: Icon(Icons.discount_outlined),label: "News"),
          // ]),
        ),
      ),
    );
  }
}
