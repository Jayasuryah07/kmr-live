import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
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

import 'package:webview_flutter/webview_flutter.dart';

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
  final controller = WebViewController();
  RxBool check = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ConstHelper.whiteColor,
        body: Column(
          children: [
            Expanded(
              child: Padding(
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
                          height: Get.height *0.05,
                        ),
                        Image.asset(
                          'assets/image/kmrLive.png',
                          width: Get.width,
                          height: Get.width / 4.5,
                          fit: BoxFit.fitWidth,
                        ),


                        SizedBox(
                          height: Get.height *0.05,
                        ),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            color: ConstHelper.orangeColor,
                            fontSize: Get.width*0.065,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: Get.width / 30,
                        ),
                        Text(
                          'Log in to your account',
                          style: TextStyle(
                            color: ConstHelper.blackColor,
                            fontSize: Get.width*0.07,
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
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              maxLength: 10,
                              style:TextStyle(
                                fontSize: Get.width*0.045,
                                fontWeight: FontWeight.bold,
                                color: ConstHelper.blackColor,
                                letterSpacing: 1
                              ),
                              onChanged: (value) {
                                if(!(value!.trim().isNotEmpty && value.length != 10)){
                                  usernameFocusNode.unfocus();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                  // border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: Get.width / 30,
                                      vertical: Get.width / 60),
                                  hintText: "Enter User Id here...",
                                  hintStyle: TextStyle(
                                    fontSize: Get.width*0.035,
                                    fontWeight: FontWeight.normal,
                                    color: ConstHelper.greyColor,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: ConstHelper.darkBlueColor,
                                  )),
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'User Id cannot be empty.';
                                } else if (value!.trim().isNotEmpty && value.length != 10) {
                                  return 'Enter valid user id.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height *0.02,
                        ),
                       Obx(() =>  Row(children: [
                         Checkbox(
                           tristate: true,
                           value: check.value,
                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                           //focusColor: ConstHelper.darkBlueColor,
                          // fillColor: MaterialStatePropertyAll(ConstHelper.whiteColor),
                           activeColor:check.value
                               ? ConstHelper.darkBlueColor
                               : ConstHelper.whiteColor,
                           visualDensity: VisualDensity.compact,
                           onChanged: (value) async {
                            check.value =
                             !check.value;
                           },),
                         SizedBox(
                           width: Get.width / 30,
                         ),
                         GestureDetector(
                           onTap: () async {
                             check.value =
                             !check.value;
                           },
                           child: Text(
                             "I agree to the ",
                             style: TextStyle(
                               color: ConstHelper.blackColor.withOpacity(0.8),
                               fontSize: Get.width*0.04,
                             ),
                           ),
                         ),
                         GestureDetector(
                           onTap: () async {
                             if (!(await ConstHelper.checkInternet())) {
                             Get.snackbar(
                             "No Internet",
                             'Please check your internet connection',
                             snackPosition: SnackPosition
                                 .BOTTOM, // Position: TOP or BOTTOM
                             );
                             return;
                             }
                             controller
                               ..setJavaScriptMode(JavaScriptMode.unrestricted)
                               ..loadRequest(Uri.parse("https://kmrlive.in/privacypolicy"));
                             showDialog(
                               barrierDismissible: false,
                               context: context,
                               builder: (context) {
                                 return AlertDialog(
                                   backgroundColor:ConstHelper.whiteColor,
                                   surfaceTintColor: ConstHelper.darkBlueColor,
                                   insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.025), // 95% width
                                   titlePadding: EdgeInsets.only(top: 10,right: 10,bottom: 10),
                                   title: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       GestureDetector(
                                         onTap: (){
                                           Navigator.pop(context);
                                         },
                                         child: Container(
                                             padding: EdgeInsets.all(3),
                                             decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: ConstHelper.greyColor.withOpacity(0.5)
                                             ),
                                             child: Icon(Icons.close,color: ConstHelper.blackColor,)),
                                       ),
                                     ],
                                   ),
                                   contentPadding: EdgeInsets.all(0),
                                   content: Container(
                                     width: Get.width*0.9, // Adjust the width here
                                     height: Get.height * 0.9, // Optional: control height
                                     child: WebViewWidget(controller: controller),
                                   ),
                                 );
                               },
                             );
                           },
                           child: Text(
                             "Terms & Conditions",
                             style: TextStyle(
                                 decoration: TextDecoration.underline,
                                 color: ConstHelper.darkBlueColor,
                                 fontSize: Get.width*0.04,
                                 fontWeight: FontWeight.bold
                             ),
                           ),
                         ),
                       ],),),

                     /*   Obx(
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
                              GestureDetector(
                                onTap: () => homeController.check.value =
                                !homeController.check.value,

                                child: Text(
                                  "I agree to the ",
                                  style: TextStyle(
                                    color: ConstHelper.greyColor,
                                    fontSize: Get.width*0.04,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller
                                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                    ..loadRequest(Uri.parse("https://kmrlive.in/privacypolicy"));
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor:ConstHelper.whiteColor,
                                        surfaceTintColor: ConstHelper.darkBlueColor,
                                        insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.025), // 95% width
                                        titlePadding: EdgeInsets.only(top: 10,right: 10,bottom: 10),
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ConstHelper.greyColor.withOpacity(0.5)
                                                  ),
                                                  child: Icon(Icons.close,color: ConstHelper.blackColor,)),
                                            ),
                                          ],
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                        content: Container(
                                          width: Get.width*0.9, // Adjust the width here
                                          height: Get.height * 0.9, // Optional: control height
                                          child: WebViewWidget(controller: controller),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: ConstHelper.darkBlueColor,
                                    fontSize: Get.width*0.045,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        SizedBox(
                          height: Get.width / 7,
                        ),
                        GestureDetector(
                          onTap: () async {
                            homeController.start.value = 0;
                            // Get.off(const OTPPage(),transition: Transition.fadeIn,);

                            usernameFocusNode.unfocus();

                            if (txtUsername.text.trim().isEmpty) {
                              usernameFocusNode.requestFocus();
                            }
                            if (formKey.currentState!.validate()) {
                              if (check.value) {
                                if (!(await ConstHelper.checkInternet())) {
                                  Get.snackbar(
                                    "No Internet",
                                    'Please check your internet connection',
                                    snackPosition: SnackPosition
                                        .BOTTOM, // Position: TOP or BOTTOM
                                  );
                                  return;
                                } else {
                                  EasyLoading.show(
                                    status: ConstHelper.pleaseWaitMsg,
                                  );
                                  try {
                                    await ApiHelper.apiHelper
                                        .checkMobileNumber(
                                      mobileNo: txtUsername.text,
                                    )
                                        .then(
                                      (value) async {
                                        if (value.isNotEmpty) {
                                          if (value['code'] == 200) {
                                            homeController.mobileNo.value =
                                                txtUsername.text;
                                            homeController.password.value =
                                                value['data'] ?? '';
                                             var token;
                                             if (Platform.isIOS) {
                                               token = await FirebaseMessaging.instance
                                                   .getAPNSToken();
                                               debugPrint('APNS Token: $token');
                                             } else {
                                               try {
                                                 token = await FirebaseMessaging.instance.getToken();
                                                 print("FCM Token: $token");
                                               } catch (e) {
                                                 print("🔥 Error getting FCM token: $e");
                                               }
                                             }
                                            homeController
                                                .firebaseFCMToken.value = token;
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

                                                    switch (e.code) {
                                                      case 'invalid-phone-number':
                                                        EasyLoading.dismiss();
                                                        Get.snackbar(
                                                          "Verify Phone Number",
                                                          ConstHelper
                                                              .invalidPhoneNumberErrorMsg,
                                                          snackPosition: SnackPosition
                                                              .BOTTOM, // Position: TOP or BOTTOM
                                                        );

                                                        break;
                                                      case 'too-many-requests':
                                                        EasyLoading.dismiss();
                                                        Get.snackbar(
                                                          "Error!",
                                                          ConstHelper
                                                              .manyRequestErrorMsg,
                                                          snackPosition: SnackPosition
                                                              .BOTTOM, // Position: TOP or BOTTOM
                                                        );
                                                        break;
                                                      default:
                                                        EasyLoading.dismiss();
                                                        Get.snackbar(
                                                          "Error!",
                                                          e.message ?? "Something went wrong",
                                                          snackPosition: SnackPosition
                                                              .BOTTOM, // Position: TOP or BOTTOM
                                                        );
                                                    }
                                                // EasyLoading.dismiss();
                                                print(
                                                    'Error~~ : ${e.code}~${e.message}');
                                                if (e.code ==
                                                    'invalid-phone-number') {
                                                  EasyLoading.dismiss();
                                                  Get.snackbar(
                                                    "Verify Phone Number",
                                                    ConstHelper
                                                        .invalidPhoneNumberErrorMsg,
                                                    snackPosition: SnackPosition
                                                        .BOTTOM, // Position: TOP or BOTTOM
                                                  );
                                                } else if (e.code ==
                                                    'too-many-requests') {
                                                  EasyLoading.dismiss();
                                                  Get.snackbar(
                                                    "Error!",
                                                    ConstHelper
                                                        .manyRequestErrorMsg,
                                                    snackPosition: SnackPosition
                                                        .BOTTOM, // Position: TOP or BOTTOM
                                                  );
                                                } else if (e.code == 'unknown') {
                                                 EasyLoading.dismiss();
                                                 Get.snackbar(
                                                   "Error!",
                                                   ConstHelper.unknownErrorMsg,
                                                   snackPosition: SnackPosition
                                                       .BOTTOM, // Position: TOP or BOTTOM
                                                 );
                                                 /* homeController.mobileNo.value =
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
                                                  });*/
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
                                                Get.snackbar(
                                                  'Otp sent',
                                                  value['msg'] ?? 'Otp sent successfully.',
                                                  snackPosition: SnackPosition.BOTTOM,
                                                  colorText: ConstHelper.whiteColor,
                                                  backgroundColor: ConstHelper.darkBlueColor,
                                                );
                                                homeController.start.value = 30;
                                                homeController.startTimer();
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
                                            Get.snackbar(
                                              'Error!',
                                              value['msg'] ??
                                                  ConstHelper.unauthorizedMsg,
                                              snackPosition: SnackPosition.BOTTOM,
                                              colorText: ConstHelper.whiteColor,
                                              backgroundColor: ConstHelper.darkBlueColor,
                                            );
                                          }
                                        } else {
                                          EasyLoading.dismiss();
                                          Get.snackbar(
                                            "Error!",
                                            ConstHelper.unauthorizedMsg,
                                            snackPosition: SnackPosition
                                                .BOTTOM, // Position: TOP or BOTTOM
                                          );

                                        }
                                      },
                                    );
                                  } catch (error) {
                                    EasyLoading.dismiss();
                                    Get.snackbar(
                                      "Error!",
                                      ConstHelper.somethingErrorMsg,
                                      snackPosition: SnackPosition
                                          .BOTTOM, // Position: TOP or BOTTOM
                                    );
                                  }
                                }
                              } else {
                                EasyLoading.dismiss();
                                Get.snackbar(
                                  'Terms & Privacy Policy',
                                  'Please review and accept the Terms of Use and Privacy Policy.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: ConstHelper.whiteColor,
                                  backgroundColor: ConstHelper.darkBlueColor,
                                );
                              }
                            }
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
                              'Send OTP',
                              style: TextStyle(
                                color: ConstHelper.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Get.width*0.045,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.width / 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do not have account?",
                              style: TextStyle(
                                color: ConstHelper.blackColor.withOpacity(0.8),
                                fontSize: Get.width*0.04,
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
                                " Sign up",
                                style: TextStyle(
                                  decoration:TextDecoration.underline,
                                  color: ConstHelper.darkBlueColor,
                                  fontSize: Get.width*0.045,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height *0.08,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/image/bg_image.png',
              height: Get.height *0.24,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
