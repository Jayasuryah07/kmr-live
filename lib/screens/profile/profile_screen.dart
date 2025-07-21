import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Controllers/profile_controller.dart';
import '../../Utils/api_helper.dart';
import '../../Utils/const_helper.dart';
import '../../Utils/shared_pref_helper.dart';
import '../login_screen/login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController  controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:   Scaffold(
      appBar: AppBar(
        backgroundColor: ConstHelper.lightBlueColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: Icon(
              Icons.arrow_back_outlined,
              color: ConstHelper.whiteColor,
            ),
          ),
        ),
        titleSpacing: 0,
        title: Text(
          "Account Profile",
          style: TextStyle(
            fontSize: Get.width * 0.05,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: ConstHelper.whiteColor,
          ),
        ),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? Center(
          child: Container(
            height: Get.height * 0.1,
            width: Get.height * 0.1,
            margin:  EdgeInsets.symmetric(
                horizontal:  Get.width *0.04, vertical:  Get.height *0.02),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(Get.height *0.02),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
        )
            : controller.useDataModel.value.data != null
            ? SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              Image.asset("assets/image/profile.png",height: Get.height*0.15,),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: Get.height*0.02,horizontal: Get.width*0.04),
                padding: EdgeInsets.symmetric(vertical: Get.height*0.02,horizontal: Get.width*0.04),
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(Get.height*0.02),),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(128),
                        offset: const Offset(0, 4),
                        spreadRadius:  2,blurRadius: 4,
                      )
                    ]),
                child: Column(
                  children: [
                    commonProfileTextWidget(
                      title: "Name",
                      subTitle:
                      controller.useDataModel.value.data?.name ?? "",
                      context: context,
                    ),
                    commonProfileTextWidget(
                      title: "Mobile",
                      subTitle:
                      controller.useDataModel.value.data?.mobile ?? "",
                      context: context,
                    ),
                    commonProfileTextWidget(
                      title: "Email",
                      subTitle:
                      controller.useDataModel.value.data?.email ?? "",
                      context: context,
                    ), commonProfileTextWidget(
                      title: "City",
                      subTitle:
                      controller.useDataModel.value.data?.city??"N/A",
                      context: context,
                    ),
                    commonProfileTextWidget(
                      title: "Account Expiration",
                      subTitle:
                      DateFormat("dd-MM-yyyy").format(controller.useDataModel.value.data?.validityDate??DateTime.now()),
                      context: context,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () =>deleteDialog(context, Get.height, Get.width),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child:  Padding(
                            padding:  EdgeInsets.symmetric(vertical: Get.height*0.015),
                            child: Text("Delete Account" ,style: GoogleFonts.ptSans(
                              color: ConstHelper.whiteColor,
                              fontSize: Get.width *0.045,
                              letterSpacing:1,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.04),
                  ],
                ),
              ),
            ],
          ),
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "No Data Available",
                textAlign: TextAlign.center,
                style: GoogleFonts.ptSans(
                  color: ConstHelper.blackColor,
                  fontSize: Get.height / 45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
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
                    SizedBox(width: width * 0.04),

                    Expanded(
                      child:
                      Text(
                        "Account Delete?".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: ConstHelper.blackColor,
                          fontSize: Get.height / 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),),

                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(CupertinoIcons.clear_circled_solid))
                  ],
                ),

                SizedBox(height: height * 0.02),
                Text(
                  "Are you sure you want to delete your account? This will permanently erase your account.",
                  style: TextStyle(
                      fontSize: Get.width * 0.045,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      color: ConstHelper.blackColor.withAlpha(230),
                      height: 1.5
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await ApiHelper.apiHelper
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
                        child:  Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: Get.width * 0.04,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: ConstHelper.whiteColor,
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
                        child:  Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: Get.width * 0.04,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: ConstHelper.blackColor,
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

  Widget commonProfileTextWidget(
      {String? title, String? subTitle, BuildContext? context}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "${title ?? ""} :",
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                  color: ConstHelper.blackColor.withAlpha(204),
                  fontSize: Get.height / 55,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.06,
            ),
            Expanded(
              flex: 8,
              child: Text(
                subTitle ?? "",
                style: GoogleFonts.roboto(
                  color: ConstHelper.darkBlueColor,
                  fontSize: Get.height / 52,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
      ],
    );
  }
}
