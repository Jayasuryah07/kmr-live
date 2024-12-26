import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ConstHelper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.edit_rounded,color: ConstHelper.darkBlueColor,),
                    hintText: "Firm Name",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                  ),
                ),
                SizedBox(height: Get.width/15,),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width/30,vertical: Get.width/30,),
                    prefixIcon: Icon(Icons.location_on_rounded,color: ConstHelper.darkBlueColor,),
                    hintText: "City",
                    hintStyle: TextStyle(color: ConstHelper.greyColor,),
                  ),
                ),
                SizedBox(height: Get.width/7,),
                GestureDetector(
                  onTap: () {
                    Get.back();
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
}
