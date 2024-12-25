import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmr/Controllers/HomeController.dart';
import 'package:kmr/Models/VendorRateDataModel.dart';
import 'package:kmr/Screens/HomeScreen/BottomPage.dart';
import 'package:kmr/Utils/ApiHelper.dart';
import 'package:kmr/Utils/ConstHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    homeController.getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: ConstHelper.darkBlueColor,
          leading: Icon(
            Icons.menu,
            color: ConstHelper.whiteColor,
          ),
          title: Text(
            "Home",
            style: TextStyle(
                color: ConstHelper.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: ConstHelper.whiteColor,
                        size: 20,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.call,
                        color: ConstHelper.whiteColor,
                        size: 20,
                      ))
                ],
              ),
            )
          ],
        ),
        backgroundColor: ConstHelper.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/image/home.jpg",
              height: Get.width / 3,
              width: Get.width,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: Get.width / 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(
                "Categories",
                style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: Get.width / 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: homeController.allCategoryDataList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: Get.width / 100,
                    mainAxisExtent: Get.width / 2.5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (await ConstHelper.checkInternet()) {
                              EasyLoading.show(status: "Please Wait...");
                              homeController.selectCategoryData.value =
                                  homeController.allCategoryDataList[index];
                              await ApiHelper.apiHelper
                                  .getCategoryIdWiseSubCategoryDataList(
                                      categoryId: homeController
                                          .allCategoryDataList[index].id
                                          .toString())
                                  .then(
                                (allSubCategoryDataList) {
                                  homeController.allSubCategoryDataList.value =
                                      allSubCategoryDataList;
                                  homeController.selectedIndex.value = 0;
                                  Get.to(const BottomPage(),
                                      transition: Transition.fadeIn);
                                  EasyLoading.dismiss();
                                  print(
                                      "KKKKKKKKKKKKK ${homeController.allSubCategoryDataList.length}");
                                },
                              );
                            } else {
                              EasyLoading.showError(
                                  "Please check your network");
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ConstHelper.blackColor, width: 2),
                                shape: BoxShape.circle),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ConstHelper.whiteColor, width: 3),
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                radius: Get.width / 8,
                                backgroundColor: ConstHelper.whiteColor,
                                backgroundImage: NetworkImage(homeController
                                                .allCategoryDataList[index]
                                                .categoriesImages ==
                                            null ||
                                        homeController
                                            .allCategoryDataList[index]
                                            .categoriesImages!
                                            .isEmpty
                                    ? "https://kmrlive.in/api/storage/app/public/no_image.jpg"
                                    : "https://kmrlive.in/storage/app/public/categories_images/${homeController.allCategoryDataList[index].categoriesImages}"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.width / 30,
                        ),
                        Text(
                            "${homeController.allCategoryDataList[index].categoryName}")
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 20, left: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffEDF7FD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    color: ConstHelper.whiteColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        homeController.userData.value.validityDate ==
                                                    null ||
                                                homeController.userData.value
                                                        .validityDate!.year <=
                                                    0
                                            ? '0'
                                            : DateFormat('yyyy-MM-dd')
                                                        .parse(homeController
                                                            .userData
                                                            .value
                                                            .validityDate!
                                                            .toString())
                                                        .difference(DateFormat(
                                                                'yyyy-MM-dd')
                                                            .parse(DateTime.now()
                                                                .toString()))
                                                        .inDays <
                                                    0
                                                ? '0'
                                                : DateFormat('yyyy-MM-dd')
                                                    .parse(homeController.userData.value.validityDate!.toString())
                                                    .difference(DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()))
                                                    .inDays
                                                    .toString(),
                                        style: TextStyle(
                                            color: ConstHelper.blackColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Days Remaining",
                                    style: TextStyle(
                                        color: ConstHelper.blackColor,
                                        fontSize: 8),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: Get.width / 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Trial Period",
                                    style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "call us to activate.",
                                    style: TextStyle(
                                        color: ConstHelper.blackColor,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    var url = Uri.parse("tel: 8867171060");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      EasyLoading.showError(
                                        ConstHelper.somethingErrorMsg,
                                      );
                                    }
                                  } catch (error) {
                                    EasyLoading.showError(
                                      ConstHelper.somethingErrorMsg,
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ConstHelper.blackColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call_rounded,
                                          color: ConstHelper.greenColor,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: Get.width / 50,
                                        ),
                                        Text(
                                          "Call Us",
                                          style: TextStyle(
                                              color: ConstHelper.whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat('dd/MMM/yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    color: ConstHelper.blackColor,
                                    fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 50,
                  ),
                  Text(
                    "Validity Ends on  : ${homeController.userData.value.validityDate == null || homeController.userData.value.validityDate!.year <= 0 ? ConstHelper.naMsg : DateFormat('dd - MMMM - yyyy').format(homeController.userData.value.validityDate!)}",
                    style:
                        TextStyle(fontSize: 14, color: ConstHelper.greyColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
