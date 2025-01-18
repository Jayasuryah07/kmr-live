import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
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
  bool _flexibleUpdateAvailable = false;
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
    try {
      login = SharedPrefHelper.sharedPreferences.getBool('login') ?? false;
    } catch(error) {
      login = false;
    }

    if(login)
    {
      try {
        await homeController.getUserData();
        homeController.firebaseFCMToken.value =
        await FirebaseHelper.firebaseHelper
            .getFirebaseToken();
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
      homeController.check.value = false;
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
