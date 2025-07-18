import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';

import '../Screens/LoginScreen/LoginPage.dart';
import 'ApiHelper.dart';
import 'SharedPrefHelper.dart';

class ConstHelper {
  ConstHelper._();

  static ConstHelper constHelper = ConstHelper._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static TextStyle appBarTextStyle = TextStyle(
    color: ConstHelper.whiteColor,
    fontSize: Get.width * 0.045,letterSpacing: 1,
    fontWeight: FontWeight.bold,
  );
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color greyColor = Colors.grey;
  static Color greenColor = Colors.green;
  static Color redColor = Colors.red;
  //ec5300
  static Color lightRedColor = const Color(0xFFFF654D);
 // static Color redColor = const Color(0xFFFF004D);
  static Color orangeColor = const Color(0xFFFB7705);
  static Color cementColor = const Color(0xFFA7AEB5);
  static Color darkBlueColor = const Color(0xFF176289);
  static Color lightBlueColor = const Color(0xFF2C7EA5);
  static Color lightGreenColor = const Color(0xffBBEA70);

  static String pleaseWaitMsg = "Please wait...";
  static String internetMsg = "Please check your internet";
  static String somethingErrorMsg = "Oops! An error occurred. Try again!";
  static String nameNotAvailableMsg = "Name not available";
  static String fatherNameNotAvailableMsg = "Father name not available";
  static String emailNotAvailableMsg = "Email not available";
  static String naMsg = "N/A";
  static String yesMsg = "Yes";
  static String noMsg = "No";
  static String invalidPhoneNumberErrorMsg =
      "Sorry, Your phone number is invalid\nPlease enter the valid phone number...";
  static String invalidOTPErrorMsg =
      "Oops! That OTP is incorrect. Retry!";
  static String manyRequestErrorMsg =
      "Request limit exceeded. Please wait and try again";
  static String unknownErrorMsg =
      "Sorry, Internal error has occurred\nPlease try again later...";
  static String unauthorizedMsg = "Unauthorized...";
  static String otpSentMsg = "OTP sent your mobile number...";
  static String dataNotAvailableMsg = "Sorry, Data Not Available";
  // static String userImagesPath = "https://ppmilan.in/public/app_images/user_images/";
  static String imageBaseUrlPath = "https://kmrlive.in/public/assets/images/";
  static String noImageFoundPath = "${imageBaseUrlPath}no_image.jpg";
  static String categoryImagePath = "${imageBaseUrlPath}categories_images/";
  static String developerImagePath = "${imageBaseUrlPath}developer_images/";
  static String newsImagePath = "${imageBaseUrlPath}News/";
  static String spotImagePath = "${imageBaseUrlPath}Spot/";
  static String sliderImagePath = "${imageBaseUrlPath}slider_images/";
  static String subCategoryImagePath = "${imageBaseUrlPath}sub_categories_images/";
  static String notificationImagePath = "${imageBaseUrlPath}notification_images/";


  /// Internet Connection Checking

  static Future<bool> checkInternet() async {
    try {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
    } catch (error) {
      return false;
    }
  }

  static Future<DateTime> getCurrentDateTime() async {
    try {
      bool internetAvailable = await checkInternet();
      return internetAvailable ? await NTP.now() : DateTime.now();
    } catch(error) {
      return DateTime.now();
    }
  }

  static FilteringTextInputFormatter spaceNotAllowFilter = FilteringTextInputFormatter.deny(RegExp(r'\s'));
  static ImageFilter filter = ImageFilter.blur(sigmaX: 3,sigmaY: 3);


  static void errorDialog({required String text, required int seconds,}) {
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      desc: text,
      btnOkOnPress: () {},
      autoHide: Duration(seconds: seconds,),
      btnOkText: 'Close',
      btnOkIcon: Icons.cancel,
      btnOkColor: redColor,
      // customHeader: Container(
      //   width: Get.width/6,
      //   height: Get.width/6,
      //   decoration: const BoxDecoration(
      //     color: Colors.red,
      //     shape: BoxShape.circle,
      //   ),
      //   alignment: Alignment.center,
      //   child: Icon(Icons.cancel,color: whiteColor,),
      // )
    ).show();
  }

  static void successDialog({required String text, required int seconds,}) {
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      dialogType: DialogType.success,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      desc: text,
      autoHide: Duration(seconds: seconds,),
      btnOkOnPress: () {},
      btnOkText: 'Close',
      btnOkIcon: Icons.check_circle,
      btnOkColor: greenColor,
    ).show();
  }


  bool validateEmail({required String email}) {
    final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<String> pickImage({required ImageSource source}) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? xFile = await picker.pickImage(source: source);
      return xFile == null ? "" : xFile.path;
    } catch(error) {
      //////print("ERROR : $error");
      return "";
    }
  }
  void areYouSureWantAlertDialog({
    required String title,
    required String description,
    required void Function() onPressed,
  }) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: filter,
          child: AlertDialog(
            backgroundColor: ConstHelper.whiteColor,
            surfaceTintColor: ConstHelper.whiteColor,
            titlePadding: EdgeInsets.symmetric(horizontal: 10,vertical: Get.height*0.01),
            insetPadding: EdgeInsets.symmetric(horizontal: 10,vertical: Get.height*0.01), // Reduce default constraints
        title:Container(
        width: Get.width * 0.8,
         child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ConstHelper.darkBlueColor,
                            fontSize: Get.width * 0.05,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: ConstHelper.blackColor,
                      fontSize: Get.width * 0.04,
                      letterSpacing: 1
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: ConstHelper.darkBlueColor,
                              letterSpacing: 1
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:  ConstHelper.darkBlueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: whiteColor,
                              letterSpacing: 1
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
          ),
        );
      },
    );
  }
}


/*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Delete My Account ?? ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ConstHelper.greyColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var value = await ApiHelper.apiHelper
                          .postDeleteProfileApi()
                          .then((value) async {
                        try {
                          if (value.isNotEmpty) {
                            if (value['code'] == 200) {
                              final responseData = json.decode(value.body);
                              print(responseData);
                              if (responseData['code'] == 200) {
                                SharedPrefHelper.sharedPreferences.setBool(
                                  'login',
                                  false,
                                );
                                Get.offAll(
                                  const LoginPage(),
                                );
                                ConstHelper.successDialog(
                                  text: jsonDecode(value)['msg'] ??
                                      "User Deleted Successfully",
                                  seconds: 10,
                                );
                              } else {
                                ConstHelper.errorDialog(
                                  text: jsonDecode(value)['msg'] ??
                                      "Something went wrong",
                                  seconds: 10,
                                );
                              }
                            } else {
                              ConstHelper.errorDialog(
                                text: jsonDecode(value)['msg'] ??
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
                    child: Text(
                      "Click Here",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ConstHelper.greyColor,
                      ),
                    ),
                  ),
                ],
              ),*/