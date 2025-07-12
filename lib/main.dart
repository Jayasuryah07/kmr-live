import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'Screens/HomeScreen/HomePage.dart';
import 'Screens/LoginScreen/LoginPage.dart';
import 'Screens/SplashScreen/SplashPage.dart';
import 'Screens/SplashScreen/splash_common_page.dart';
import 'Utils/ConstHelper.dart';
import 'Utils/SharedPrefHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Conditional Firebase initialization
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD6mKY_fVaKv38fiAx7Kry-RIkirDTgk3A',
        appId: '1:161668906055:android:424c69f727843dc3da8562',
        messagingSenderId: '161668906055',
        projectId: 'kmrgroup-a7e50',
        storageBucket: 'kmrgroup-a7e50.firebasestorage.app',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC0C6Q_4jP2P8ZkCcZjiWg62dMIANAOWN0',
        appId: '1:161668906055:ios:bd0ec85f89334c57da8562',
        messagingSenderId: "161668906055",
        projectId: "kmrgroup-a7e50",
        storageBucket: "kmrgroup-a7e50.firebasestorage.app",
        // Add from Firebase Console if available
        iosBundleId: "com.kmr.agsolutions",
      ),
    );
  }
  await FirebaseMessaging.instance.requestPermission();

  await SharedPrefHelper.sharedPrefHelper.initSharedPref();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: ConstHelper.darkBlueColor,
      // Background color of status bar
      statusBarIconBrightness: Brightness.light,
      // Color of icons (light = white icons)
      statusBarBrightness: Brightness.dark,
      // For iOS

      systemNavigationBarColor: ConstHelper.darkBlueColor,
      // Navigation bar background
      systemNavigationBarIconBrightness: Brightness.light,
      // Icons color in navigation bar
      systemNavigationBarDividerColor: ConstHelper.whiteColor,
    ));
    return GetMaterialApp(
      title: 'KMR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      navigatorKey: ConstHelper.navigatorKey,
      builder: EasyLoading.init(),
      routes: {
        '/' : (p0) => const SplashPage(),
        'login' : (p0) => const LoginPage(),
        'home' : (p0) => const HomePage(),
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}
