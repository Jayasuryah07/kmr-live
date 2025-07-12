
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kmr_flutter_application/Screens/about_us/about_us_screen.dart';
import 'package:kmr_flutter_application/Screens/profile/profile_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/HomeController.dart';
import '../../Models/SubCategoryModel.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/SharedPrefHelper.dart';
import '../LoginScreen/LoginPage.dart';
import '../notification/notification_screen.dart';
import '../services/feedback_screen.dart';
import 'BottomPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  String version ="";
  // RxInt selectedIndex = 0.obs;
List drawerList = [
  {
   1:  "Home",
    2:Icons.home_filled
  }, {
   1:  "My Profile",
    2:Icons.person
  }, /*{
   1:  "Share app",
    2:Icons.send_rounded
  },*/{
    1:  "Feedback",
    2:Icons.feedback
  },{
   1:  "About us",
    2:CupertinoIcons.info_circle_fill
  },{
    1:  "Notification",
    2:Icons.notifications_rounded
  },{
   1:  "Logout",
    2:Icons.logout
  },
];
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

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = "Version ${packageInfo.version}";
    String buildNumber = packageInfo.buildNumber; // Build Number

    return 'Version: $version+$buildNumber';
  }

  @override
  void initState() {
    // TODO: implement initState
    homeController.getCategoryData();
    getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        key: homeController.drawerKey,
        drawer: Drawer(
          surfaceTintColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          width: Get.width/1.5,
          child: Column(
            children: [
              SizedBox(height: Get.height*0.04,),
              Center(
                child: Image.asset(
                  'assets/image/kmrLive.png',
                  // width: Get.width/1.2,
                  height: Get.width/6,
                  fit: BoxFit.fitHeight,
                ),
              ),              SizedBox(height: Get.height*0.04,),
              Divider(color:ConstHelper.darkBlueColor ,),
              SizedBox(height: Get.height*0.03,),

              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    homeController.drawerKey.currentState?.closeDrawer();
                    switch(index){
                      case 0:
                        Get.back();
                        break;
                      case 1:
                        Get.to(const ProfileScreen());
                        break;
                      /*case 2:
                        break;*/
                      case 2:
                        Get.to(const FeedbackScreen());
                        break;
                      case 3:
                        Get.to(const AboutUsScreen());
                        break; case 4:
                        Get.to(const NotificationScreen());
                        break;
                      case 5:
                      ConstHelper.constHelper.areYouSureWantAlertDialog(
                        title: 'Confirm Logout?',
                        description: 'You are about to log out. Do you wish to continue?',
                        onPressed: () {
                          Get.back();
                          SharedPrefHelper.sharedPreferences.setBool(
                            'login',
                            false,
                          );
                          Get.offAll(
                            const LoginPage(),
                          );
                        },
                      );
                      break;
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(width: Get.width*0.03,),
                      Icon(drawerList[index][2]),
                      SizedBox(width: Get.width*0.02,),
                      Text(
                        drawerList[index][1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ConstHelper.blackColor,
                            fontSize: Get.width * 0.045,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              }, separatorBuilder:(context, index) => SizedBox(height: Get.height*0.03,),itemCount: drawerList.length,

              ),
              SizedBox(height: Get.height * 0.02),
             /* Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => deleteDialog(context, Get.height, Get.width),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child:  Text(
                      "Delete Account",
                      style: TextStyle(color: ConstHelper.whiteColor, fontSize: Get.width * 0.04,
                        letterSpacing: 1,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.04),*/
              Spacer(),
              Text(
                "$version",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontSize: Get.width * 0.045,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: Get.height*0.03,),

            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: ConstHelper.lightBlueColor,
          leading: IconButton(
            onPressed: () {
              homeController.drawerKey.currentState
                  ?.openDrawer(); // Use openDrawer to open the left drawer
            },
            icon: Icon(
              Icons.menu,
              color: ConstHelper.whiteColor,
            ),
          ),
          titleSpacing: 0,
          title: Text(
            "Home",
            style: TextStyle(
                color: ConstHelper.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: Get.width * 0.05,letterSpacing: 1,),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(NotificationScreen());
              },
              icon: Icon(
                Icons.notifications_rounded,
                color: ConstHelper.whiteColor,
                size: Get.height*0.03,
              ),
            )
          ],
          /*actions: [
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
                      ),
                  )
                ],
              ),
            )
          ],*//*actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();
                        Get.offAll(LoginPage());
                      },
                      icon: Icon(
                        color: ConstHelper.whiteColor,

                        Icons.logout,
                      ),
                  ),

                ],
              ),
            )
          ],*/
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
                "Categories".toUpperCase(),
                style: TextStyle(
                    color: ConstHelper.darkBlueColor,
                    fontSize: Get.width*0.045,
                    letterSpacing: 1,
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
                              if(!(DateFormat('yyyy-MM-dd')
                                      .parse(homeController.userData.value.validityDate!.toString())
                                      .difference(DateTime.now())
                                      .inDays <=
                                      0)){
                                EasyLoading.show(status: "Please Wait...");
                                homeController.selectCategoryData.value =
                                homeController.allCategoryDataList[index];
                                await ApiHelper.apiHelper
                                    .getCategoryIdWiseSubCategoryDataList(
                                    categoryId: homeController
                                        .allCategoryDataList[index].categoryName
                                        .toString(), index: 0)

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
                                    homeController.selectedIndex.value = 0;
                                    Get.to(const BottomPage(),
                                        transition: Transition.fadeIn);
                                    EasyLoading.dismiss();
                                    print(
                                        "KKKKKKKKKKKKK ${homeController.allSubCategoryDataList.length}");
                                  },
                                );
                              }

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
                                child:Container(
                                  width: Get.width / 4, // Diameter of the circle
                                  height: Get.width / 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ConstHelper.whiteColor, // Background color of the circle
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        homeController.allCategoryDataList[index].categoriesImages == null ||
                                            homeController.allCategoryDataList[index].categoriesImages!.isEmpty
                                            ? ConstHelper.noImageFoundPath
                                            : "${ConstHelper.categoryImagePath}${homeController.allCategoryDataList[index].categoriesImages}",
                                      ),
                                      fit: BoxFit.cover, // Scales the image to cover the circle
                                      colorFilter: (DateFormat('yyyy-MM-dd')
                                          .parse(homeController.userData.value.validityDate!.toString())
                                          .difference(DateTime.now())
                                          .inDays <=
                                          0)
                                          ? const ColorFilter.mode(
                                        Colors.grey, // Grayscale color
                                        BlendMode.saturation, // Apply desaturation effect
                                      )
                                          : null, // No filter for the original image
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.width / 30,
                        ),
                        Text(
                            "${homeController.allCategoryDataList[index].categoryName}", style: TextStyle(
                                color: ConstHelper.darkBlueColor,
                                fontSize: Get.width*0.04,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600),)
                      ],
                    ),
                  );
                },
              ),
            ),
         if( homeController.userData.value.validityDate != null &&
      homeController.userData.value.validityDate!.year > 0 &&
          DateFormat('yyyy-MM-dd')
          .parse(homeController.userData.value.validityDate!.toString())
          .difference(DateTime.now())
          .inDays <=
          10) Padding(
              padding:  EdgeInsets.only(right: 10, bottom: Get.height *0.01, left: 10),
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
                                         fontSize: Get.width*0.06,
                                         fontWeight: FontWeight.w600),
                                   ),
                                 ),
                               ),
                               Text(
                                 "Days \nRemaining",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                   color: ConstHelper.blackColor,
                                   fontSize: Get.width*0.03,),
                               )
                             ],
                           ),
                           SizedBox(
                             width: Get.width / 30,
                           ),
                          Expanded(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (homeController.userData.value.trail != null &&
                                      homeController.userData.value.trail!.trim().toLowerCase() == "no")
                                      ? "Plan Getting Expire":"Trial Period",
                                  style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontSize: Get.width*0.045,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600),
                                ),Row(
                                  children: [
                                    Expanded(child: Text(
                                      "Contact us to reactivate",
                                      style: TextStyle(
                                        color: ConstHelper.blackColor,
                                        fontSize: Get.width*0.035,),
                                    ), ),

                                  ],),


                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                _launchURL("tel: 8867171060");
                                /*var url = Uri.parse("tel: 8867171060");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      EasyLoading.showError(
                                        ConstHelper.somethingErrorMsg,
                                      );
                                    }*/
                              } catch (error) {
                                EasyLoading.showError(
                                  ConstHelper.somethingErrorMsg,
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Get.width*0.02),
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
                                        fontSize: Get.width * 0.045,
                                        letterSpacing: 1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /* Column(
                             children: [

                               *//* Text(
                                DateFormat('dd/MMM/yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    color: ConstHelper.blackColor,
                                    fontSize: Get.width*0.03),
                              )*//*
                             ],
                           )*/


                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height *0.01,
                  ),
                  Text (
                    "Valid Until: ${homeController.userData.value.validityDate == null || homeController.userData.value.validityDate!.year <= 0 ? ConstHelper.naMsg : DateFormat('dd - MMMM - yyyy').format(homeController.userData.value.validityDate!)}",
                    style:
                        TextStyle( fontSize: Get.width*0.035, color: ConstHelper.blackColor.withOpacity(0.8)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
deleteDialog(context, double height, double width) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: ConstHelper.whiteColor,
      surfaceTintColor: ConstHelper.whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(CupertinoIcons.clear_circled_solid))
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Are you sure you want to delete your account? This will permanently erase your account.",
                style: TextStyle(
                  fontSize: Get.width * 0.04,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: ConstHelper.blackColor,
                  height: 1.5
                ),
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var value = await ApiHelper.apiHelper
                            .postDeleteProfileApi()
                            .then((value) async {
                          try {
                            if (value.isNotEmpty) {
                              if (value['code'] == 200) {
                                final responseData = value.body;
                                if (responseData['code'] == 200) {
                                  SharedPrefHelper.sharedPreferences.setBool(
                                    'login',
                                    false,
                                  );
                                  Get.offAll(
                                    const LoginPage(),
                                  );
                                  ConstHelper.successDialog(
                                    text: value['msg'] ??
                                        "User Deleted Successfully",
                                    seconds: 10,
                                  );
                                } else {
                                  ConstHelper.errorDialog(
                                    text: value['msg'] ??
                                        "Something went wrong",
                                    seconds: 10,
                                  );
                                }
                              } else {
                                ConstHelper.errorDialog(
                                  text: value['msg'] ??
                                      "Something went wrong",
                                  seconds: 10,
                                );
                              }
                            }
                          } on TimeoutException catch (e) {
                            ConstHelper.errorDialog(
                              text: e.message.toString(),
                              seconds: 10,
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red),
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
            ],
          ),
        ),
      ),
    ),
  );
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw 'Could not launch $url';
  }
}