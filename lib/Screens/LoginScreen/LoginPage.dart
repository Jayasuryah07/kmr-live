import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../Controllers/HomeController.dart';
import '../../Models/UserDataModel.dart';
import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';
import '../../Utils/FirebaseHelper.dart';
import '../../Utils/SharedPrefHelper.dart';
import '../HomeScreen/HomePage.dart';
import '../SignupScreen/SignupPage.dart';
import 'OTPPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtUsername = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width / 10,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.width / 15,
                  ),
                  Image.asset(
                    'assets/image/kmrLive.png',
                    width: Get.width,
                    height: Get.width / 4,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: Get.width / 15,
                  ),
                  Image.asset(
                    'assets/image/loginLogo.png',
                    width: Get.width,
                    height: Get.width / 2,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: Get.width / 90,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: ConstHelper.orangeColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 30,
                  ),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      color: ConstHelper.blackColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 10,
                  ),
                  Center(
                    child: SizedBox(
                      // width: Get.width/1.5,
                      child: TextFormField(
                        controller: txtUsername,
                        focusNode: usernameFocusNode,
                        decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: Get.width / 30,
                                vertical: Get.width / 60),
                            hintText: "User Name",
                            hintStyle: TextStyle(
                              color: ConstHelper.greyColor,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: ConstHelper.darkBlueColor,
                            )),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter the username';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 20,
                  ),
                  GestureDetector(
                    onTap: () => homeController.check.value =
                        !homeController.check.value,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: homeController.check.value
                                    ? ConstHelper.darkBlueColor
                                    : ConstHelper.greyColor,
                                width: 1,
                              ),
                              color: homeController.check.value
                                  ? ConstHelper.darkBlueColor
                                  : ConstHelper.whiteColor,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: ConstHelper.whiteColor,
                              size: Get.width / 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 30,
                          ),
                          Text(
                            "Terms of use and Privacy Policy",
                            style: TextStyle(
                              color: ConstHelper.greyColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 7,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Get.off(const OTPPage(),transition: Transition.fadeIn,);

                      usernameFocusNode.unfocus();

                      if (txtUsername.text.trim().isEmpty) {
                        usernameFocusNode.requestFocus();
                      }
                      if (formKey.currentState!.validate()) {
                        if (homeController.check.value) {
                          EasyLoading.show(
                            status: ConstHelper.pleaseWaitMsg,
                          );
                          await Future.delayed(
                            const Duration(
                              milliseconds: 100,
                            ),
                          );
                          if (!(await ConstHelper.checkInternet())) {
                            EasyLoading.dismiss();
                            ConstHelper.errorDialog(
                              text: ConstHelper.internetMsg,
                              seconds: 10,
                            );
                          } else {
                            try {
                              await ApiHelper.apiHelper
                                  .checkMobileNumber(
                                mobileNo: txtUsername.text,
                              )
                                  .then(
                                (value) async {
                                  if (value.isNotEmpty) {
                                    if (value['code'] == 200) {
                                      EasyLoading.dismiss();
                                      await FirebaseAuth.instance
                                          .verifyPhoneNumber(
                                        phoneNumber: '+91 ${txtUsername.text}',
                                        verificationCompleted:
                                            (PhoneAuthCredential credential) {
                                          print(
                                              'adadadasd ${credential.verificationId}~~${credential.smsCode}');
                                          print(
                                              'adadadasd ${credential.smsCode}~~${credential.token}');
                                          print(
                                              'adadadasd ${credential.accessToken}~~${credential.providerId}');
                                          print(
                                              'adadadasd ${credential.signInMethod}');
                                          EasyLoading.dismiss();
                                        },
                                        verificationFailed:
                                            (FirebaseAuthException e) async {
                                          // EasyLoading.dismiss();
                                          print(
                                              'Error~~ : ${e.code}~${e.message}');
                                          if (e.code ==
                                              'invalid-phone-number') {
                                            EasyLoading.dismiss();
                                            ConstHelper.errorDialog(
                                              text: ConstHelper
                                                  .invalidPhoneNumberErrorMsg,
                                              seconds: 10,
                                            );
                                          } else if (e.code ==
                                              'too-many-requests') {
                                            EasyLoading.dismiss();
                                            ConstHelper.errorDialog(
                                              text: ConstHelper
                                                  .manyRequestErrorMsg,
                                              seconds: 10,
                                            );
                                          } else if (e.code == 'unknown') {
                                            // EasyLoading.dismiss();
                                            // ConstHelper.errorDialog(
                                            //   text: ConstHelper.unknownErrorMsg,
                                            //   seconds: 10,
                                            // );
                                            homeController.mobileNo.value =
                                                txtUsername.text;
                                            homeController.password.value =
                                                value['data'] ?? '';
                                            homeController
                                                    .firebaseFCMToken.value =
                                                await FirebaseHelper
                                                    .firebaseHelper
                                                    .getFirebaseToken();
                                            await ApiHelper.apiHelper
                                                .loginUser(
                                              mobileNo: homeController.mobileNo
                                                  .trim(),
                                              password: homeController.password
                                                  .trim(),
                                              deviceId: homeController
                                                  .firebaseFCMToken
                                                  .trim(),

                                              // mobileNo: '9972837003',
                                              // password: '123456',
                                            )
                                                .then((userData) async {
                                              if (userData['code'] == 200) {
                                                UserDataModel userDataModel =
                                                    UserDataModel.fromJson(
                                                        userData['data'] ?? {});
                                                SharedPrefHelper
                                                    .sharedPreferences
                                                    .setString(
                                                  'userData',
                                                  jsonEncode(userDataModel),
                                                );
                                                SharedPrefHelper
                                                    .sharedPreferences
                                                    .setBool(
                                                  'login',
                                                  true,
                                                );
                                                await homeController
                                                    .getUserData();
                                                EasyLoading.dismiss();
                                                // homeController.bottomIndex.value = 0;
                                                Get.offAll(
                                                  const HomePage(),
                                                );
                                                // ConstHelper.successDialog(
                                                //   text: 'Success',
                                                //   seconds: 10,
                                                // );
                                              } else {
                                                EasyLoading.dismiss();
                                                ConstHelper.errorDialog(
                                                  text: userData['msg'] ??
                                                      ConstHelper
                                                          .unauthorizedMsg,
                                                  seconds: 10,
                                                );
                                              }
                                            });
                                          }
                                          // print('Error~~ : ${e.credential ?? {}}~${e.email}');
                                          // print('Error~~ : ${e.tenantId}~${e.plugin}');
                                          // print('Error~~ : ${jsonEncode(e.stackTrace ??{})}~${e.phoneNumber}');
                                          // print('Error~~ : ${jsonEncode(e)}');
                                          log(e.toString());
                                        },
                                        codeSent: (String verificationId,
                                            int? resendToken) {
                                          print(
                                              'Success : $verificationId $resendToken');
                                          homeController.mobileNo.value =
                                              txtUsername.text;
                                          homeController.password.value =
                                              value['data'] ?? '';
                                          homeController.otpResendCode.value =
                                              resendToken ?? 0;
                                          homeController.otpVerificationId
                                              .value = verificationId;
                                          Get.to(
                                            const OTPPage(),
                                            transition: Transition.fadeIn,
                                          );
                                          EasyLoading.dismiss();
                                        },
                                        codeAutoRetrievalTimeout:
                                            (String verificationId) {
                                          print(
                                              'TimeoutError : $verificationId');
                                          EasyLoading.dismiss();
                                        },
                                      );
                                    } else {
                                      EasyLoading.dismiss();
                                      ConstHelper.errorDialog(
                                        text: value['msg'] ??
                                            ConstHelper.unauthorizedMsg,
                                        seconds: 10,
                                      );
                                    }
                                  } else {
                                    EasyLoading.dismiss();
                                    ConstHelper.errorDialog(
                                      text: ConstHelper.unauthorizedMsg,
                                      seconds: 10,
                                    );
                                  }
                                },
                              );
                            } catch (error) {
                              EasyLoading.dismiss();
                              ConstHelper.errorDialog(
                                text: ConstHelper.somethingErrorMsg,
                                seconds: 10,
                              );
                            }
                          }
                        } else {
                          EasyLoading.dismiss();
                          ConstHelper.errorDialog(
                              text:
                                  'Please click terms of use and Privacy Policy',
                              seconds: 10);
                        }
                      }
                      EasyLoading.dismiss();
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ConstHelper.darkBlueColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: Get.width / 30,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ConstHelper.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.width / 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have account",
                        style: TextStyle(
                          color: ConstHelper.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const SignupPage(),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: Text(
                          "   Sign up",
                          style: TextStyle(
                            color: ConstHelper.darkBlueColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.width / 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
