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
                    'Sign Up',
                    style: TextStyle(
                      color: ConstHelper.orangeColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: Get.width/10,),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: nameCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.person,color: ConstHelper.darkBlueColor,),
                    hintText: "Your Name",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                  ),
                ),
                SizedBox(height: Get.width/15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: mobileCon,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.call_rounded,color: ConstHelper.darkBlueColor,),
                    hintText: "Mobile",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                    counterText: '',
                  ),
                ),
                SizedBox(height: Get.width/15,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.email_rounded,color: ConstHelper.darkBlueColor,),
                    hintText: "Email",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                  ),
                ),
                SizedBox(height: Get.width/15,),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  maxLines: 1,
                  controller: remarkCon,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.location_on,color: ConstHelper.darkBlueColor,),
                    hintText: "City",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                  ),
                ),
               /* SizedBox(height: Get.width/15,),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.location_on_rounded,color: ConstHelper.darkBlueColor,),
                    hintText: "City",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                  ),
                ),*/
                SizedBox(height: Get.width/7,),
                GestureDetector(
                  onTap: () async {
                    EasyLoading.show(status: ConstHelper.pleaseWaitMsg);
                    await Future.delayed(
                        const Duration(milliseconds: 200));
                    if (!await ConstHelper.checkInternet()) {
                    _showError(ConstHelper.internetMsg);
                    return;
                    }
                    if (!_validateForm()) return;

                    try {
                    final response =
                    await ApiHelper.apiHelper.signUpUser(
                      mobileNo: mobileCon.value.text,
                      name: nameCon.value.text,
                      email:emailCon.value.text,
                      city: remarkCon.value.text,
                    );

                    if (response.isNotEmpty &&response['code'] == 200) {
                      EasyLoading.dismiss();
                    ConstHelper.successDialog(
                      text: response['msg'] ??
                          "Your profile is created successfully.",
                      seconds: 10,
                    );
                      Get.back();
                    } else {
                      EasyLoading.dismiss();

                      ConstHelper.errorDialog(
                        text: response['msg'] ??
                            ConstHelper.somethingErrorMsg,
                        seconds: 10,
                      );
                    }
                    } catch (error) {
                      EasyLoading.dismiss();
                      ConstHelper.errorDialog(
                        text:
                            ConstHelper.somethingErrorMsg,
                        seconds: 10,
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
                      'Submit',
                      style: TextStyle(
                        color: ConstHelper.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.width/10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Register",style: TextStyle(color: ConstHelper.greyColor,fontSize: 14,fontWeight: FontWeight.w500,),),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text("   Login Here",style: TextStyle(color: ConstHelper.darkBlueColor,fontSize: 14,fontWeight: FontWeight.w600,),),
                    ),
                  ],
                ),
                SizedBox(height: Get.width/15,),
              ],
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
