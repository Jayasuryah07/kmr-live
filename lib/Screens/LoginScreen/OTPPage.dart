import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'LoginPage.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtOTP1 = TextEditingController();
  TextEditingController txtOTP2 = TextEditingController();
  TextEditingController txtOTP3 = TextEditingController();
  TextEditingController txtOTP4 = TextEditingController();
  TextEditingController txtOTP5 = TextEditingController();
  TextEditingController txtOTP6 = TextEditingController();

  FocusNode otp1FocusNode = FocusNode();
  FocusNode otp2FocusNode = FocusNode();
  FocusNode otp3FocusNode = FocusNode();
  FocusNode otp4FocusNode = FocusNode();
  FocusNode otp5FocusNode = FocusNode();
  FocusNode otp6FocusNode = FocusNode();
  // OtpController controller = Get.put(OtpController());
  int backspaceCount = 0;
  //final telephony = Telephony.instance;
  RxBool checkTermsCondition = false.obs;

  //final controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    //listenToIncomingSMS(context);
    super.initState();
  }

 /* void listenToIncomingSMS(BuildContext context) {
    txtOTP1.clear();
    txtOTP2.clear();
    txtOTP3.clear();
    txtOTP4.clear();
    txtOTP5.clear();
    txtOTP6.clear();
    print("Listening to sms.");
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          // Handle message
          print("sms received : ${message.body}");
          // verify if we are reading the correct sms or not

          if (message.body!.contains("kmrgroup-a7e50.firebaseapp.com")) {
            String otpCode = message.body!.substring(0, 6);
            List<String> otpCharacters = otpCode.split('');
            print("OTP::::::$otpCode");
            setState(() {
              txtOTP1.text = otpCode.substring(0, 1).toString();
              txtOTP2.text = otpCode.substring(1, 2).toString();
              txtOTP3.text = otpCode.substring(2, 3).toString();
              txtOTP4.text = otpCode.substring(3, 4).toString();
              txtOTP5.text = otpCode.substring(4, 5).toString();
              txtOTP6.text = otpCode.substring(5, 6).toString();
            });
          }
        },
        listenInBackground: false);
  }*/


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/10,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width/7,),
                Image.asset(
                  'assets/image/kmrLive.png',
                  width: Get.width,
                  height: Get.width/4,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: Get.width/7,),
               /* Text(
                  'Verification',
                  style: TextStyle(
                    color: ConstHelper.orangeColor,
                    fontSize: Get.width*0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: Get.width/30,),
                Text(
                  'Enter your OTP',
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),*/
                SizedBox(height: Get.width/10,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: txtOTP1,
                          focusNode: otp1FocusNode,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              otp1FocusNode.unfocus();
                              otp2FocusNode.requestFocus();
                            }

                            checkAllOTPFill();
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtOTP2,
                          focusNode: otp2FocusNode,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              otp2FocusNode.unfocus();
                              otp3FocusNode.requestFocus();
                            } else {
                              otp2FocusNode.unfocus();
                              otp1FocusNode.requestFocus();
                            }

                            checkAllOTPFill();
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtOTP3,
                          focusNode: otp3FocusNode,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            print('adadas $value');
                            if (value.trim().isNotEmpty) {
                              otp3FocusNode.unfocus();
                              otp4FocusNode.requestFocus();
                            } else {
                              otp4FocusNode.unfocus();
                              otp2FocusNode.requestFocus();
                            }

                            checkAllOTPFill();
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtOTP4,
                          focusNode: otp4FocusNode,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              otp4FocusNode.unfocus();
                              otp5FocusNode.requestFocus();
                            } else {
                              otp4FocusNode.unfocus();
                              otp3FocusNode.requestFocus();
                            }

                            checkAllOTPFill();
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtOTP5,
                          focusNode: otp5FocusNode,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              otp5FocusNode.unfocus();
                              otp6FocusNode.requestFocus();
                            } else {
                              otp5FocusNode.unfocus();
                              otp4FocusNode.requestFocus();
                            }

                            checkAllOTPFill();
                          },
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtOTP6,
                          focusNode: otp6FocusNode,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              otp6FocusNode.unfocus();
                              // otp3FocusNode.requestFocus();
                            } else {
                              otp6FocusNode.unfocus();
                              otp5FocusNode.requestFocus();
                            }
                            checkAllOTPFill();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: TextField(
                //         textAlign: TextAlign.center,
                //         keyboardType: TextInputType.number,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //         textInputAction: TextInputAction.next,
                //         decoration: InputDecoration(
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.darkBlueColor,),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.cementColor,),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: Get.width/30,),
                //     Expanded(
                //       child: TextField(
                //         textAlign: TextAlign.center,
                //         keyboardType: TextInputType.number,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //         textInputAction: TextInputAction.next,
                //         decoration: InputDecoration(
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.darkBlueColor,),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.cementColor,),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: Get.width/30,),
                //     Expanded(
                //       child: TextField(
                //         textAlign: TextAlign.center,
                //         keyboardType: TextInputType.number,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //         textInputAction: TextInputAction.next,
                //         decoration: InputDecoration(
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.darkBlueColor,),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.cementColor,),
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: Get.width/30,),
                //     Expanded(
                //       child: TextField(
                //         textAlign: TextAlign.center,
                //         keyboardType: TextInputType.number,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly,
                //         ],
                //         decoration: InputDecoration(
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.darkBlueColor,),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(5),
                //             borderSide: BorderSide(color: ConstHelper.cementColor,),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: Get.width/20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OTP not received?",style: TextStyle(color: ConstHelper.blackColor.withOpacity(0.8),fontSize: Get.width*0.04,),),
                    GestureDetector(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 200,),);
                        EasyLoading.show(status: ConstHelper.pleaseWaitMsg,);
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91 ${homeController.mobileNo.value}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {
                              print(
                                  'adadadasd ${credential.verificationId}~~${credential.smsCode}');
                              print(
                                  'adadadasd ${credential.smsCode}~~${credential.token}');
                              print(
                                  'adadadasd ${credential.accessToken}~~${credential.providerId}');
                              print('adadadasd ${credential.signInMethod}');
                              EasyLoading.dismiss();
                            },
                            verificationFailed: (FirebaseAuthException e) async {
                              // EasyLoading.dismiss();
                              print('Error~~ : ${e.code}~${e.message}');
                              if (e.code == 'invalid-phone-number') {
                                EasyLoading.dismiss();
                                ConstHelper.errorDialog(
                                  text: ConstHelper
                                      .invalidPhoneNumberErrorMsg,
                                  seconds: 10,
                                );
                              } else if (e.code == 'too-many-requests') {
                                EasyLoading.dismiss();
                                ConstHelper.errorDialog(
                                  text: ConstHelper.manyRequestErrorMsg,
                                  seconds: 10,
                                );
                              } else if (e.code == 'unknown') {
                                EasyLoading.dismiss();
                                ConstHelper.errorDialog(
                                  text: ConstHelper.unknownErrorMsg,
                                  seconds: 10,
                                );
                              }
                              // print('Error~~ : ${e.credential ?? {}}~${e.email}');
                              // print('Error~~ : ${e.tenantId}~${e.plugin}');
                              // print('Error~~ : ${jsonEncode(e.stackTrace ??{})}~${e.phoneNumber}');
                              // print('Error~~ : ${jsonEncode(e)}');
                              log(e.toString());
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              print('Success : $verificationId $resendToken');
                              homeController.otpVerificationId.value = verificationId;
                              // Get.to(const OTPPage(), transition: Transition.fadeIn,);
                              EasyLoading.dismiss();
                              ConstHelper.successDialog(
                                text: ConstHelper.otpSentMsg,
                                seconds: 10,
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              print('TimeoutError : $verificationId');
                              EasyLoading.dismiss();
                            },
                            forceResendingToken: homeController.otpResendCode.value == 0 ? null : homeController.otpResendCode.value,
                          );
                        } catch(error) {
                          EasyLoading.dismiss();
                          ConstHelper.errorDialog(text: ConstHelper.somethingErrorMsg, seconds: 10,);
                        }
                      },
                      child: Text(" RESEND!",style: TextStyle(decoration:TextDecoration.underline,
                          color: ConstHelper.darkBlueColor,
                          fontSize: Get.width*0.045,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/7,),
                GestureDetector(
                  // onTap: () {
                  //   Get.off(const HomePage(),transition: Transition.fadeIn,);
                  // },
                  onTap: () async {
                    otp1FocusNode.unfocus();
                    otp2FocusNode.unfocus();
                    otp3FocusNode.unfocus();
                    otp4FocusNode.unfocus();
                    otp5FocusNode.unfocus();
                    otp6FocusNode.unfocus();
                    if (txtOTP1.text.trim().isEmpty) {
                      otp1FocusNode.requestFocus();
                    } else if (txtOTP2.text.trim().isEmpty) {
                      otp2FocusNode.requestFocus();
                    } else if (txtOTP3.text.trim().isEmpty) {
                      otp3FocusNode.requestFocus();
                    } else if (txtOTP4.text.trim().isEmpty) {
                      otp4FocusNode.requestFocus();
                    } else if (txtOTP4.text.trim().isEmpty) {
                      otp4FocusNode.requestFocus();
                    } else if (txtOTP5.text.trim().isEmpty) {
                      otp5FocusNode.requestFocus();
                    } else if (txtOTP6.text.trim().isEmpty) {
                      otp6FocusNode.requestFocus();
                    } else {
                      EasyLoading.show(
                        status: ConstHelper.pleaseWaitMsg,
                      );
                      await Future.delayed(
                        const Duration(
                          milliseconds: 100,
                        ),
                      );
                      try {
                     /*   await ApiHelper.apiHelper
                            .loginUser(
                          mobileNo: homeController.mobileNo.trim(),
                          password: homeController.password.trim(),
                          deviceId: homeController.firebaseFCMToken.trim(),

                          // mobileNo: '9972837003',
                          // password: '123456',
                        )
                            .then((userData) async {
                          if (userData['code'] == 200) {
                            UserDataModel userDataModel =
                            UserDataModel.fromJson(
                                userData['data'] ?? {});
                            SharedPrefHelper.sharedPreferences
                                .setString(
                              'userData',
                              jsonEncode(userDataModel),
                            );
                            SharedPrefHelper.sharedPreferences.setBool(
                              'login',
                              true,
                            );
                            await homeController.getUserData();
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
                                  ConstHelper.unauthorizedMsg,
                              seconds: 10,
                            );
                          }
                        });*/
                        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                        String otp =
                            '${txtOTP1.text}${txtOTP2.text}${txtOTP3.text}${txtOTP4.text}${txtOTP5.text}${txtOTP6.text}';
                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                          verificationId:
                          homeController.otpVerificationId.value,
                          smsCode: otp,
                        );


                        // Sign the user in (or link) with the credential

                        await firebaseAuth
                            .signInWithCredential(credential)
                            .then(
                              (value) async {
                            homeController.firebaseFCMToken.value =
                            await FirebaseHelper.firebaseHelper
                                .getFirebaseToken();

                            print( homeController.firebaseFCMToken.value);
                            await ApiHelper.apiHelper
                                .loginUser(
                              mobileNo: homeController.mobileNo.trim(),
                              password: "123456",
                              deviceId: homeController.firebaseFCMToken.trim(),

                              // mobileNo: '9972837003',
                              // password: '123456',
                            )
                                .then((userData) async {
                              if (userData['code'] == 200) {
                                UserDataModel userDataModel =
                                UserDataModel.fromJson(
                                    userData['data'] ?? {});
                                SharedPrefHelper.sharedPreferences
                                    .setString(
                                  'userData',
                                  jsonEncode(userDataModel),
                                );
                                SharedPrefHelper.sharedPreferences.setBool(
                                  'login',
                                  true,
                                );
                                await homeController.getUserData();
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
                                      ConstHelper.unauthorizedMsg,
                                  seconds: 10,
                                );
                              }
                            });
                          },
                        );
                      } on FirebaseAuthException catch (error) {
                        if (error.code == 'invalid-verification-code') {
                          EasyLoading.dismiss();
                          ConstHelper.errorDialog(
                            text: ConstHelper.invalidOTPErrorMsg,
                            seconds: 10,
                          );
                        } else {
                          EasyLoading.dismiss();
                          ConstHelper.errorDialog(
                            text: ConstHelper.somethingErrorMsg,
                            seconds: 10,
                          );
                        }
                      } catch (error) {
                        print('Error : $error');
                        EasyLoading.dismiss();
                        ConstHelper.errorDialog(
                          text: ConstHelper.somethingErrorMsg,
                          seconds: 10,
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
                    padding: EdgeInsets.symmetric(vertical: Get.width/30,),
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                        color: ConstHelper.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Get.width*0.045,
                      ),
                    ),
                  ),
                ),
               /* SizedBox(height: Get.width/10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do not have account",style: TextStyle(color: ConstHelper.greyColor,fontSize: 14,fontWeight: FontWeight.w500,),),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SignupPage(),transition: Transition.fadeIn,);
                      },
                      child: Text("   Sign up",style: TextStyle(color: ConstHelper.darkBlueColor,fontSize: 14,fontWeight: FontWeight.w600,),),
                    ),
                  ],
                ),*/
                SizedBox(height: Get.width/15,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkAllOTPFill() {
    if (txtOTP1.text.trim().isNotEmpty &&
        txtOTP2.text.trim().isNotEmpty &&
        txtOTP3.text.trim().isNotEmpty &&
        txtOTP4.text.trim().isNotEmpty &&
        txtOTP5.text.trim().isNotEmpty &&
        txtOTP6.text.trim().isNotEmpty) {
      otp1FocusNode.unfocus();
      otp2FocusNode.unfocus();
      otp3FocusNode.unfocus();
      otp4FocusNode.unfocus();
      otp5FocusNode.unfocus();
      otp6FocusNode.unfocus();
    }
  }

  InputDecoration otpInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: ConstHelper.darkBlueColor,
        // width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: ConstHelper.darkBlueColor,
        // width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: ConstHelper.darkBlueColor,
        // width: 1,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
        horizontal: Get.width / 30, vertical: Get.width / 60),
    counterText: '',
    // hintText: "OTP",
    // hintStyle: TextStyle(color: ConstHelper.greyFigmaColor,),
  );
}
