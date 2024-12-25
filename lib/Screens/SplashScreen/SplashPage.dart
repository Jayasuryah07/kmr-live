import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmr/Controllers/HomeController.dart';
import 'package:kmr/Models/UserDataModel.dart';
import 'package:kmr/Screens/HomeScreen/HomePage.dart';
import 'package:kmr/Screens/LoginScreen/LoginPage.dart';
import 'package:kmr/Utils/ApiHelper.dart';
import 'package:kmr/Utils/ConstHelper.dart';
import 'package:kmr/Utils/FirebaseHelper.dart';
import 'package:kmr/Utils/SharedPrefHelper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 1,), () async => await checkLogin(),);
    super.initState();
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
          if(userData['code'] == 200)
          {
            UserDataModel userDataModel = UserDataModel.fromJson(userData['data'] ?? {});
            SharedPrefHelper.sharedPreferences.setString('userData', jsonEncode(userDataModel),);
            await homeController.getUserData();
            EasyLoading.dismiss();
            // homeController.bottomIndex.value = 0;
            Get.offAll(
              const HomePage(),
            );
          }
          else
          {
            await homeController.getUserData();
            EasyLoading.dismiss();
            // homeController.bottomIndex.value = 0;
            Get.offAll(
              const HomePage(),
            );
          }
        });
      } catch(error) {
        await homeController.getUserData();
        EasyLoading.dismiss();
        // homeController.bottomIndex.value = 0;
        Get.offAll(
          const HomePage(),
        );
      }
    }
    else
    {
      homeController.check.value = false;
      Get.offAll(const LoginPage(),transition: Transition.fadeIn,);
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Center(
          child: FlutterLogo(
            size: Get.width/2,
          ),
        ),
      ),
    );
  }
}
