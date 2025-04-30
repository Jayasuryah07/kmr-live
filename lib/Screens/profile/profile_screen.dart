import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Controllers/profile_controller.dart';
import '../../Utils/ConstHelper.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController  controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
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
          "Profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ConstHelper.whiteColor,
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Container(
                  height: Get.height * 0.1,
                  width: Get.height * 0.1,
                  margin:  EdgeInsets.symmetric(
                      horizontal:  Get.width *0.04, vertical:  Get.height *0.02),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Get.height *0.02),
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                ),
              )
            : controller.useDataModel.value.data != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Image.asset("assets/image/profile.png",height: Get.height*0.15,),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: Get.height*0.02,horizontal: Get.width*0.04),
                          padding: EdgeInsets.symmetric(vertical: Get.height*0.02,horizontal: Get.width*0.04),
                          decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(Get.height*0.02),),
                              boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 4),
                              spreadRadius:  2,blurRadius: 4,
                            )
                          ]),
                          child: Column(
                            children: [
                              commonProfileTextWidget(
                                title: "Name",
                                subTitle:
                                controller.useDataModel.value.data?.name ?? "",
                                context: context,
                              ),
                              commonProfileTextWidget(
                                title: "Mobile",
                                subTitle:
                                controller.useDataModel.value.data?.mobile ?? "",
                                context: context,
                              ),
                              commonProfileTextWidget(
                                title: "Email",
                                subTitle:
                                controller.useDataModel.value.data?.email ?? "",
                                context: context,
                              ), commonProfileTextWidget(
                                title: "City",
                                subTitle:
                                controller.useDataModel.value.data?.city??"N/A",
                                context: context,
                              ),
                               commonProfileTextWidget(
                                title: "Validity Date",
                                subTitle:
                                DateFormat("dd-MM-yyyy").format(controller.useDataModel.value.data?.validityDate??DateTime.now()) ?? "",
                                context: context,
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "No Data Available",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                            color: ConstHelper.blackColor,
                            fontSize: Get.height / 45,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget commonProfileTextWidget(
      {String? title, String? subTitle, BuildContext? context}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "${title ?? ""} :",
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                  color: ConstHelper.greyColor,
                  fontSize: Get.height / 55,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.06,
            ),
            Expanded(
              flex: 8,
              child: Text(
                subTitle ?? "",
                style: GoogleFonts.roboto(
                  color: ConstHelper.darkBlueColor,
                  fontSize: Get.height / 52,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
      ],
    );
  }
}
