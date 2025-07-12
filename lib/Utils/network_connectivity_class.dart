import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/HomeController.dart';
import '../Models/UserDataModel.dart';
import '../Screens/HomeScreen/HomePage.dart';
import '../Screens/LoginScreen/LoginPage.dart';
import 'ApiHelper.dart';
import 'SharedPrefHelper.dart';


class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool isChecking = false;
  HomeController homeController = Get.put(HomeController());

  /// Timer for 5 seconds to check connection
  @override
  void initState() {
    super.initState();
    /*Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) checkConnection();
    });*/
  }

  /// check network connection
  Future<void> checkConnection() async {
    setState(() => isChecking = true);

    if (await NetworkConnectivity.checkInternet()) {
      var login;
      print("Internet connection found");
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
          homeController.firebaseFCMToken.value = token;
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
    } else {
      print("Internet connection ::::::::not:::::::::: found");
      setState(() => isChecking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/img_no_internet.png',
                  width: Get.width * 0.05,
                  height: Get.width * 0.05,
                  //  repeat: true,
                ),
                const SizedBox(height: 24),
                const Text(
                  "You're offline",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please check your internet connection to explore Asvt.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: isChecking ? null : checkConnection,
                  icon: const Icon(Icons.refresh),
                  label: isChecking
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text("Retry Connection"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                /* OutlinedButton.icon(
                  onPressed: () {
                  //  AppSettings.openAppSettings();
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text("Open Internet Settings"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/// Internet Connection Checking
class NetworkConnectivity {
  static Future<bool> checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.first == ConnectivityResult.none) return false;

    try {
      final result =
      await http.get(Uri.parse('https://www.google.com')).timeout(
        const Duration(seconds: 5),
      );
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}