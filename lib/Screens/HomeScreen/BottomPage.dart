import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Models/SubCategoryModel.dart';
import '../../Models/VendorRateDataModel.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage>with TickerProviderStateMixin {
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
    if (homeController.allSubCategoryDataList.isNotEmpty) {
      homeController.tabController = TabController(
        length: homeController.allSubCategoryDataList.length,
        vsync: this,
      );
      homeController.selectedTabIndex.value = 0; // Default to the first tab
    } else {
      // Fallback for empty list (this shouldn't trigger if you have one item)
      homeController.selectedTabIndex.value = -1;
    }homeController.selectedTabIndex.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print( homeController.selectedIndex.value);
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: homeController.selectedIndex.value == 0 ||
                  homeController.selectedIndex.value == 1
              ? AppBar(
                  backgroundColor: ConstHelper.lightBlueColor,
                  // leading: IconButton(
                  //   onPressed: () {},
                  //   icon: SvgPicture.asset(
                  //     'assets/image/menuSVG.svg',
                  //     height: Get.width / 18,
                  //     width: Get.width / 18,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  leading: InkWell(
                    onTap: () {
                      if (homeController.searchClick.value) {
                        homeController.txtSearch.clear();
                        homeController.searchFocusNode.unfocus();
                        homeController.searchClick.value = false;
                        homeController.searchStart.value = false;
                      } else {
                        Get.back();
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: ConstHelper.whiteColor,
                    ),
                  ),
            titleSpacing: 0,

            title: Obx(
                    () => homeController.searchClick.value
                        ? Padding(
                           padding: EdgeInsets.only(right:Get.width*0.04 ),
                           // padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              controller: homeController.txtSearch,
                              focusNode: homeController.searchFocusNode,
                              textInputAction: TextInputAction.done,

                              cursorColor: ConstHelper.whiteColor,
                              decoration: InputDecoration(
                                isDense:true,
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
                                suffixIcon:  InkWell(
                                  onTap: () {
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
                                  child: Icon(
                                      Icons.close_rounded,
                                      color: ConstHelper.whiteColor,
                                      size: Get.width / 15,
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
                                  horizontal: Get.width *0.045,
                                ),
                                hintText: 'Search....',
                                hintStyle: TextStyle(
                                  color: ConstHelper.whiteColor.withOpacity(0.7),
                                ),
                              ),

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
                                    homeController.filterLiveData(value.toString().toLowerCase().trim());
                              /*      homeController.searchedLiveDataList.value =
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
                                    ).toList();*/
                                  } else if (homeController
                                          .selectedIndex.value ==
                                      1) {
                                    homeController.filterRatesData(searchValue.trim().toLowerCase());
                                  /*  homeController.searchedRatesDataList.value =
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
                                    ).toList();*/
                                  }
                                }
                              },
                            ),
                          )
                        : Text(
                      homeController.selectCategoryData.value.categoryName?? 'KMR LIVE',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width * 0.05,
                             letterSpacing: 1,
                            ),
                          ),
                  ),
                  actions: [
                    if(!homeController.searchClick.value)

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

                  ],
                  bottom: PreferredSize(
                    preferredSize: homeController.allSubCategoryDataList.isEmpty ?Size.fromHeight(0): Size.fromHeight(Get.width / 8),
                    child: homeController.allSubCategoryDataList.isEmpty ?SizedBox():DefaultTabController(
                      length: homeController.allSubCategoryDataList.length,
                      child:SizedBox(
                        height: Get.height*0.07,
                        width: Get.width,
                        child: Column(
                        children: [
                           const Divider(),
                          Expanded(child:TabBar(
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            unselectedLabelColor: Colors.grey.shade400,
                            controller: homeController.tabController,
                            tabs: [
                              for (int i = 0;
                              i < homeController.allSubCategoryDataList.length;
                              i++)
                                Tab(
                                  text:
                                  "${homeController.allSubCategoryDataList[i].vendorProductCategorySub}",
                                ),
                            ],
                            onTap: (value) {
                              homeController.selectedTabIndex.value = value;
                              print("vvvvvvvv $value");
                              var val;
                              if(homeController.allSubCategoryDataList.isNotEmpty){
                                if(homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub! == "All"){
                                  val ="";
                                }else{
                                  val = homeController.allSubCategoryDataList[homeController.selectedTabIndex.value].vendorProductCategorySub!;
                                }
                              }
                              if (homeController.selectedIndex.value == 0) {
                                homeController.getLiveData(
                                    categoryValue: homeController
                                        .selectCategoryData.value.categoryName!,
                                    subCategoryValue:val
                                );
                              } else if (homeController.selectedIndex.value == 1) {
                                homeController.getRateData(
                                    categoryValue: homeController
                                        .selectCategoryData.value.categoryName!,
                                    subCategoryValue:val
                                );
                              }
                            },
                          ),),
                          SizedBox(height: Get.height*0.01,),
                        ],),
                      ),

                    ),
                  ),
                )
              : AppBar(
               backgroundColor: ConstHelper.lightBlueColor,
                  leading: InkWell(
                    onTap: () {
                      if (homeController.searchClick.value) {
                        homeController.txtSearch.clear();
                        homeController.searchFocusNode.unfocus();
                        homeController.searchClick.value = false;
                        homeController.searchStart.value = false;
                      } else {
                        Get.back();
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: ConstHelper.whiteColor,
                    ),
                  ),
                 // leadingWidth: Get,
                 titleSpacing: 0,
                  title:
              Obx(
                    () => homeController.searchClick.value
                        ? Padding(padding: EdgeInsets.only(right:Get.width*0.04 ),child:TextField(
                      controller: homeController.txtSearch,
                      focusNode: homeController.searchFocusNode,
                      textInputAction: TextInputAction.done,
                      cursorColor: ConstHelper.whiteColor,
                      decoration: InputDecoration(
                        isDense: true,
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
                        suffixIcon:  InkWell(
                          onTap: () {
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
                          child: Icon(
                            Icons.close_rounded,
                            color: ConstHelper.whiteColor,
                            size: Get.width / 15,
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
                      ),
                      style: TextStyle(
                        color: ConstHelper.whiteColor,
                      ),
                      onChanged: (value) {
                        homeController.searchStart.value =
                            value.trim().isNotEmpty;
                        if (value.trim().isNotEmpty) {
                          String searchValue = value.trim().toLowerCase();
                          if (homeController.selectedIndex.value == 2) {
                            /*  homeController
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
                                  ).toList();*/
                            homeController.filterSpotData(searchValue);
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
                    ) )

                        : Text(
                      homeController.selectCategoryData.value.categoryName?? 'KMR LIVE',
                            style: TextStyle(
                              color: ConstHelper.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width * 0.05,
                             letterSpacing: 1,
                            ),
                          ),
                  ),
                  actions: [
                    if(!homeController.searchClick.value)
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
          body:Column(children: [
            Visibility(
                visible: homeController.selectedIndex.value != 1,
                child: Column(
              children: [
                CarouselSlider(
                  items: [
                    1,
                    2,
                    3,
                  ].map((i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
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
                   // autoPlay: imageUrls.length > 1,
                   // enableInfiniteScroll: imageUrls.length > 1,
                   // enlargeCenterPage: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
              ],
            ),),

            Expanded(child:  homeController.screens[homeController.selectedIndex.value])

          ],),
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
            onDestinationSelected: (value) async {
              if (!(await ConstHelper.checkInternet())) {
                Get.snackbar(
                  "No Internet",
                  'Please check your internet connection',
                  snackPosition: SnackPosition
                      .BOTTOM, // Position: TOP or BOTTOM
                );
                return;
              }
              if(value != 3){
                await ApiHelper.apiHelper
                    .getCategoryIdWiseSubCategoryDataList(
                  categoryId: homeController.selectCategoryData.value.categoryName!,
                  index: value,
                )
                    .then(
                      (allSubCategoryDataList) {
                        homeController.allSubCategoryDataList.clear();
                        if(allSubCategoryDataList.isNotEmpty){
                          if(allSubCategoryDataList.length == 1){
                            homeController.allSubCategoryDataList.value =allSubCategoryDataList;
                          }else{
                            homeController.allSubCategoryDataList.add(SubCategoryDataModel(vendorProductCategorySub: "All",categoriesSubImages: ""));
                            homeController.allSubCategoryDataList.addAll(allSubCategoryDataList);
                          }
                        }
                    // Create a new TabController if there are subcategories
                    if (homeController.allSubCategoryDataList.isNotEmpty) {
                      homeController.tabController = TabController(
                        length: homeController.allSubCategoryDataList.length,
                        vsync: this,
                      );
                      homeController.tabController?.addListener(() { });

                      // Reset the tab index only after the TabController is initialized
                      homeController.tabController?.index = 0;
                    }
                  },
                );
              }

              // Update other state values
              homeController.selectedTabIndex.value = 0;
              homeController.txtSearch.clear();
              homeController.searchFocusNode.unfocus();
              homeController.searchStart.value = false;
              homeController.searchClick.value = false;
              homeController.selectedIndex.value = value;

              print("Selected Tab Index: ${homeController.selectedTabIndex.value}");
              print("Selected Index: ${homeController.selectedIndex.value}");
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

