import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/HomeController.dart';
import '../../Models/UserDataModel.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/FirebaseHelper.dart';
import '../../Utils/SharedPrefHelper.dart';
import '../HomeScreen/HomePage.dart';
import '../LoginScreen/LoginPage.dart';
import 'SplashPage.dart';

class SplashCommonPage extends StatefulWidget {
  const SplashCommonPage({super.key});

  @override
  State<SplashCommonPage> createState() => _SplashCommonPageState();
}

class _SplashCommonPageState extends State<SplashCommonPage> {

  HomeController homeController = Get.put(HomeController());
  Map<dynamic, dynamic> data = {};
  bool isSkip = false;
  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;
  @override
  void initState() {
    // TODO: implement initState

    Timer(const Duration(milliseconds: 500,), () async => await checkLogin(),);
    super.initState();
  }
  Future<void> checkForUpdate() async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        startFlexibleUpdate();
      }
    } catch (e) {
      print("Error checking for updates: $e");
    }
  }

  // Start a flexible update
  Future<void> startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
      print("Update installed successfully.");
    } catch (e) {
      print("Error during update: $e");
    }
  }
  Future<void> checkLogin() async {
    bool login = false;
    if (!(await ConstHelper.checkInternet())) {
      EasyLoading.dismiss();
      Get.snackbar(
        "No Internet",
        'Please check your internet connection',
        snackPosition: SnackPosition
            .BOTTOM, // Position: TOP or BOTTOM
      );
      Timer(const Duration(seconds: 1,), () async => Get.back(),);
      return;
    }
    try {
      login = SharedPrefHelper.sharedPreferences.getBool('login') ?? false;
    } catch(error) {
      login = false;
    }

    if(login)
    {
      try {
        await homeController.getUserData();
        var token;
        if (Platform.isIOS) {
          token = await FirebaseMessaging.instance
              .getAPNSToken();
          debugPrint('APNS Token: $token');
        } else {
          FirebaseMessaging messaging =
              FirebaseMessaging.instance;
          token = await messaging.getToken();
          debugPrint('APNS Token: $token');
        }
        homeController.firebaseFCMToken.value =  token;
        await ApiHelper.apiHelper
            .loginUser(

          mobileNo: homeController.userData.value.mobile ?? '',
          password: homeController.userData.value.cpassword ?? '',
          deviceId: homeController.firebaseFCMToken.trim(),
        ).then((userData) async {
          log(userData.toString());
          if(userData['code'] == 200)
          {
            UserDataModel userDataModel = UserDataModel.fromJson(userData['data'] ?? {});
            SharedPrefHelper.sharedPreferences.setString('userData', jsonEncode(userDataModel),);
            await homeController.getUserData();
            log(userData.toString());
            EasyLoading.dismiss();
            // homeController.bottomIndex.value = 0;
            if (homeController.userData.value.status !=
                null &&
                homeController.userData.value.status ==
                    "Active"){
              Get.offAll(
                const HomePage(),
              );
            }else if (homeController.userData.value.status !=
                null &&
                homeController.userData.value.status !=
                    "Active"){
              final SharedPreferences prefs =
              await SharedPreferences.getInstance();
              prefs.clear();
              Get.offAll(
                const LoginPage(),
              );
            }
          }
          else
          {
            final SharedPreferences prefs =
            await SharedPreferences.getInstance();
            prefs.clear();
            EasyLoading.dismiss();
            Get.offAll(
              const LoginPage(),
            );
          }
        },);
      } catch(error) {
        await homeController.getUserData();
        EasyLoading.dismiss();
        // homeController.bottomIndex.value = 0;
        if (homeController.userData.value.status !=
            null &&
            homeController.userData.value.status ==
                "Active"){
          Get.offAll(
            const HomePage(),
          );
        }else{
          Get.offAll(
            const LoginPage(),
          );
        }
      }
    }
    else
    {
      Get.offAll(const LoginPage(),transition: Transition.fadeIn,);
      EasyLoading.dismiss();
    }

    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/AGS_LOGO.png",
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    text: "AG ",
                    style: GoogleFonts.roboto(
                      fontSize: Get.height / 28,
                      color: const Color(0xFF076894),
                      fontWeight: FontWeight.w900,
                    ),
                    children: [
                      TextSpan(
                        text: "Solutions",
                        style: GoogleFonts.roboto(
                          fontSize: Get.height / 28,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF076894),
            child: Text(
              "WEBSITE | WEB APPLICATION\nMOBILE APPLICATION | DIGITAL MARKETING",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: Get.height / 50,
                color: const Color(0xFFffffff),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.15,
          ),
        ],
      ),
    ));
  }
}
