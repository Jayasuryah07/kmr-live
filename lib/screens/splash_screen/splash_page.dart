import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/home_controller.dart';
import '../../Models/user_data_model.dart';
import '../../Utils/api_helper.dart';
import '../../Utils/const_helper.dart';
import '../../Utils/shared_pref_helper.dart';
import '../../Utils/network_connectivity_class.dart';
import '../home_screen/home_page.dart';
import '../login_screen/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  HomeController homeController = Get.put(HomeController());
  Map<dynamic, dynamic> data = {};
  bool isSkip = false;
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    // TODO: implement initState

    Timer(const Duration(seconds: 1,), () async => await checkLogin(),);
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
      debugPrint("Error checking for updates: $e");
    }
  }

  // Start a flexible update
  Future<void> startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
      debugPrint("Update installed successfully.");
    } catch (e) {
      debugPrint("Error during update: $e");
    }
  }
  Future<void> checkLogin() async {
    bool login = false;
    if (!(await ConstHelper.checkInternet())) {
      //  networkDialog(context);
      Get.to(const NoInternetScreen());
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
        String? token;
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
        homeController.firebaseFCMToken.value = token!;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Center(
          child: Image.asset(
            "assets/image/kmr_logo.jpg",
            width: Get.width/2,
          ),
        ),
      ),
    );
  }
}
