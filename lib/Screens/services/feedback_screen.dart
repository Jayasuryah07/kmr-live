import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kmr_flutter_application/Utils/ApiHelper.dart';

import '../../Controllers/feedback_controller.dart';
import '../../Utils/ConstHelper.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedBackController feedBackController = Get.put(FeedBackController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstHelper.darkBlueColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: Icon(
              Icons.arrow_back_outlined,
              color: ConstHelper.whiteColor,
            ),
          ),
        ),
        title: Text(
          "Feedback",
          style: TextStyle(
            fontSize: Get.width*0.05,
            fontWeight: FontWeight.w600,
            color: ConstHelper.whiteColor,
          ),
        ),
      ),
      body: Obx(
        () => feedBackController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(children: [
                    SizedBox(height: height * 0.05),
                    Image.asset(
                      'assets/image/feedback-loop.png',
                      height: Get.height * 0.15,
                    ),
                    SizedBox(height: height * 0.06),
                    TextFormField(
                      controller: feedBackController.subjectController.value,
                      onChanged: (value) {},
                      textInputAction: TextInputAction.newline,
                      maxLength: 50,
                      style: TextStyle(
                        fontSize: Get.width * 0.045,letterSpacing: 1,
                        color: ConstHelper.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.multiline,
                      cursorColor: ConstHelper.blackColor,
                      decoration: InputDecoration(
                        fillColor: ConstHelper.whiteColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        hintText: "Feedback Topic",
                        hintStyle: TextStyle(
                            fontSize: Get.width * 0.045,letterSpacing: 1,
                            color: ConstHelper.greyColor,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: const BorderSide(
                              color: Color(0xffDDDDDD),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: const BorderSide(
                              color: Color(0xffDDDDDD),
                            )),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: const BorderSide(
                              color: Color(0xffDDDDDD),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: const BorderSide(
                              color: Color(0xffDDDDDD),
                            )),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    SizedBox(
                      height: 130,
                      child: TextFormField(
                        controller:
                        feedBackController.descriptionController.value,
                        onChanged: (value) {},
                        textInputAction: TextInputAction.newline,
                        maxLines: 5,
                        maxLength: 250,
                        style: TextStyle(
                          fontSize: Get.width * 0.045,letterSpacing: 1,
                          color: ConstHelper.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.multiline,
                        cursorColor: ConstHelper.blackColor,
                        decoration: InputDecoration(
                          fillColor: ConstHelper.whiteColor,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          hintText: "Details of Your Feedback",
                          hintStyle: TextStyle(
                              fontSize: Get.width * 0.045,letterSpacing: 1,
                              color: ConstHelper.greyColor,
                              fontWeight: FontWeight.w400),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                color: Color(0xffDDDDDD),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                color: Color(0xffDDDDDD),
                              )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                color: Color(0xffDDDDDD),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                color: Color(0xffDDDDDD),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    GestureDetector(
                      onTap: () async {

                        if (feedBackController.subjectController.value.text
                            .trim()
                            .isEmpty) {
                          ConstHelper.errorDialog(
                            text: "Please Enter subject",
                            seconds: 10,
                          );
                        } else if (feedBackController
                            .descriptionController.value.text
                            .trim()
                            .isEmpty) {
                          ConstHelper.errorDialog(
                            text: 'Please Enter Description',
                            seconds: 10,
                          );
                        } else {
                          EasyLoading.show(
                            status: ConstHelper.pleaseWaitMsg,
                          );
                        var val =  await ApiHelper.apiHelper.postFeedBackApi(sub: feedBackController.subjectController.value.text, des:feedBackController.descriptionController.value.text);
                          EasyLoading.dismiss();
                          ConstHelper.successDialog(
                            text: val["msg"],
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
                        padding: EdgeInsets.symmetric(
                          vertical: Get.width / 30,
                        ),
                        child: Text(
                          'Submit Feedback',
                          style: TextStyle(
                            color: ConstHelper.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Get.width*0.045,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),
                  ]),
                ),
              ),
      ),
    );
  }
}
