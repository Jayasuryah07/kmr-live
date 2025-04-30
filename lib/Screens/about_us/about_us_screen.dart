
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmr_flutter_application/Controllers/about_us_controller.dart';

import '../../Utils/ConstHelper.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  AboutUsController controller =Get.put(AboutUsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
          "About Us",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ConstHelper.whiteColor,
          ),
        ),
      ),
      body: controller.isLoading.value
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
          :controller.aboutUsModel.value.data!=null?
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Image.asset(
                'assets/image/kmrLive.png',
                // width: Get.width/1.2,
                height: Get.width/6,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Text(
              controller.aboutUsModel.value.data?.companyName??"",
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                color:ConstHelper.blackColor ,
                fontSize: Get.height / 55,
                fontWeight: FontWeight. w700,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              controller.aboutUsModel.value.data?.companyDes??"",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color:ConstHelper.greyColor ,
                fontSize: Get.height / 70,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            commonAboutUsWidget(
              title: controller.aboutUsModel.value.data?.companyMobile??"",
              imageIconData: Icons.call_rounded,
              isIcon: true,
              context: context,
            ),
            commonAboutUsWidget(
              title: controller.aboutUsModel.value.data?.companyEmail??"",
              imageIconData: Icons.email_outlined,
              isIcon: true,
              context: context,
            ),
            commonAboutUsWidget(
              title: controller.aboutUsModel.value.data?.companyWebsite??"",
              imageIconData: Icons.public,
              isIcon: true,
              context: context,
            ),

          ],
        ),
      ) : Row(
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
    ));
  }

  Widget commonAboutUsWidget(
      {bool isIcon = false,
        String? title,
        dynamic imageIconData,
        BuildContext? context}) {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !isIcon
                    ? Image.asset(imageIconData)
                    : Icon(
                  imageIconData,
                  color: ConstHelper.darkBlueColor,
                  size: Get.height * 0.03,
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.width * 0.04,
          ),
          Expanded(
            flex: 4,
            child: Text(
              title ?? "",
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                color: ConstHelper.blackColor,
                fontSize: Get.height / 55,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
