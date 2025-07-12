import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../Utils/ApiHelper.dart';
import '../../Utils/ConstHelper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController mobileCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController remarkCon = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstHelper.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/10,),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.width/7,),
                  Center(
                    child: Image.asset(
                      'assets/image/kmrLive.png',
                      // width: Get.width/1.2,
                      height: Get.width/6,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: Get.width/15,),
                  Center(
                    child: Text(
                      'New here? Register in seconds!',
                      style: TextStyle(
                        color: ConstHelper.orangeColor,
                        fontSize: Get.width*0.06,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width/10,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: nameCon,
                    keyboardType: TextInputType.name,
                    maxLength: 50,
                    style:TextStyle(
                      fontSize: Get.width*0.04,
                      fontWeight: FontWeight.bold,
                      color: ConstHelper.blackColor,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name cannot be empty.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                      prefixIcon: Icon(Icons.person,color: ConstHelper.darkBlueColor,),
                      hintText: "Your Name",
                      counterText: "",
                       hintStyle: TextStyle(
                                    fontSize: Get.width*0.035,
                                    fontWeight: FontWeight.normal,
                                    color: ConstHelper.greyColor,
                                  ),
                    ),
                  ),
                  SizedBox(height: Get.width/15,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: mobileCon,
                    style:TextStyle(
                      fontSize: Get.width*0.04,
                      fontWeight: FontWeight.bold,
                      color: ConstHelper.blackColor,
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Mobile no. cannot be empty.';
                      } else if (value!.trim().isNotEmpty && value.length != 10) {
                        return 'Enter valid Mobile no.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                      prefixIcon: Icon(Icons.call_rounded,color: ConstHelper.darkBlueColor,),
                      hintText: "Mobile",
                       hintStyle: TextStyle(
                                    fontSize: Get.width*0.035,
                                    fontWeight: FontWeight.normal,
                                    color: ConstHelper.greyColor,
                                  ),
                      counterText: '',
                    ),
                  ),
                  SizedBox(height: Get.width/15,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCon,
                    style:TextStyle(
                      fontSize: Get.width*0.04,
                      fontWeight: FontWeight.bold,
                      color: ConstHelper.blackColor,
                    ),
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email cannot be empty.';
                      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value.trim())) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                      prefixIcon: Icon(Icons.email_rounded,color: ConstHelper.darkBlueColor,),
                      hintText: "Email",
                       hintStyle: TextStyle(
                                    fontSize: Get.width*0.035,
                                    fontWeight: FontWeight.normal,
                                    color: ConstHelper.greyColor,
                                  ),
                    ),
                  ),
                  SizedBox(height: Get.width/15,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    maxLines: 1,
                    controller: remarkCon,
                    maxLength: 50,
                    style:TextStyle(
                      fontSize: Get.width*0.04,
                      fontWeight: FontWeight.bold,
                      color: ConstHelper.blackColor,
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'City cannot be empty.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                      prefixIcon: Icon(Icons.location_on,color: ConstHelper.darkBlueColor,),
                      hintText: "City",
                       hintStyle: TextStyle(
                                    fontSize: Get.width*0.035,
                                    fontWeight: FontWeight.normal,
                                    color: ConstHelper.greyColor,
                                  ),
                    ),
                  ),
                 /* SizedBox(height: Get.width/15,),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                      prefixIcon: Icon(Icons.location_on_rounded,color: ConstHelper.darkBlueColor,),
                      hintText: "City",
                       hintStyle: TextStyle(
                                    fontSize: Get.width*0.035,
                                    fontWeight: FontWeight.normal,
                                    color: ConstHelper.greyColor,
                                  ),
                    ),
                  ),*/
                  SizedBox(height: Get.width/7,),
                  GestureDetector(
                    onTap: () async {
                      await Future.delayed(
                          const Duration(milliseconds: 200));
                      if (!(await ConstHelper.checkInternet())) {
                        EasyLoading.dismiss();
                        Get.snackbar(
                          "No Internet",
                          'Please check your internet connection',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                     if (!formKey.currentState!.validate())  return;
                      EasyLoading.show(status: ConstHelper.pleaseWaitMsg);

                      try {
                      var response =
                      await ApiHelper.apiHelper.signUpUser(
                        mobileNo: mobileCon.value.text,
                        name: nameCon.value.text,
                        email:emailCon.value.text,
                        city: remarkCon.value.text,
                      );

                      if (response.isNotEmpty &&response['code'] == 200) {
                        EasyLoading.dismiss();
                        Get.snackbar(
                          'Profile Created',
                         response['msg'] ??
                              "Your profile is created successfully.",
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: ConstHelper.whiteColor,
                          backgroundColor: ConstHelper.darkBlueColor,
                        );
                        Get.back();
                      } else {
                        EasyLoading.dismiss();
                        Get.snackbar(
                          'Error!',
                          response['msg'] ??
                              ConstHelper.somethingErrorMsg,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: ConstHelper.whiteColor,
                          backgroundColor: ConstHelper.darkBlueColor,
                        );
                      }
                      } catch (error) {
                        EasyLoading.dismiss();
                        Get.snackbar(
                          'Error!',
                          ConstHelper.somethingErrorMsg,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: ConstHelper.whiteColor,
                          backgroundColor: ConstHelper.darkBlueColor,
                        );
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
                        'Register Now',
                        style: TextStyle(
                          color: ConstHelper.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Get.width*0.045,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width/10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                        text: "Existing user?  ",
                          style: TextStyle(
                            color: ConstHelper.blackColor.withOpacity(0.8),
                            fontSize: Get.width*0.04,
                            fontWeight: FontWeight.w500,),
                        children: [
                          TextSpan(
                            text: "Log in Here",
                            style:TextStyle(decoration:TextDecoration.underline,
                                color: ConstHelper.darkBlueColor,
                                fontSize: Get.width*0.045,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
                              },
                          ),

                        ]
                      ),),
                    ],
                  ),
                  SizedBox(height: Get.width/15,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool _validateForm() {
    print("Validation started");

    if (nameCon.value.text.trim().isEmpty) {
      _showError('Name is required');
      return false;
    } else if (!_isValidEmail(emailCon.value.text)) {
      _showError('Invalid email format');
      return false;
    } else if (!_isValidPhone(mobileCon.value.text)) {
      _showError('Invalid email format');
      return false;
    } else  if (remarkCon.value.text.trim().isEmpty) {
      _showError('remark is required');
      return false;
    }

    print("Validation successful");
    return true;
  }
  void _showError(String message) {
    EasyLoading.dismiss();
    ConstHelper.errorDialog(text: message, seconds: 10);
  }

  void _showSuccess(String message) {
    EasyLoading.dismiss();
    ConstHelper.successDialog(text: message, seconds: 10);
  }

  bool _isValidEmail(String email) {
    return ConstHelper.constHelper.validateEmail(email: email.trim());
  }

  bool _isValidPhone(String phone) {
    return phone.trim().length == 10;
  }
}
