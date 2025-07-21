import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/home_controller.dart';
import '../../Utils/const_helper.dart';

class NewsDataPage extends StatefulWidget {
  const NewsDataPage({super.key});

  @override
  State<NewsDataPage> createState() => _NewsDataPageState();
}

class _NewsDataPageState extends State<NewsDataPage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: ConstHelper.whiteColor),
            backgroundColor: ConstHelper.lightBlueColor,
            titleSpacing: 0,
            title: Text(
             "${homeController.selectCategoryData.value.categoryName?? ''} (News)",
              style: TextStyle(
                color: ConstHelper.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: Get.width * 0.05,
                letterSpacing: 1,
              ),
            ),
          ),
          backgroundColor: ConstHelper.whiteColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Center(
                  child: Container(
                    height: Get.width/2.5,
                    width: Get.width/2.5,
                    decoration: BoxDecoration(
                        color: const Color(0xffF7F7F7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(77), // Light grey shadow with opacity
                          spreadRadius: 2, // Spread radius
                          blurRadius: 5, // Blur radius for softness
                          offset: const Offset(2, 2), // Horizontal and vertical offset
                        ),
                      ],
                        border: Border.all(color: ConstHelper.darkBlueColor),
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width*0.06),),),
                    // child: Image.asset('assets/image/imageNotFound.png',fit: BoxFit.cover,),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width*0.06),),
                      child: CachedNetworkImage(
                        imageUrl: homeController.selectNewsData.value.newsImage == null || homeController.selectNewsData.value.newsImage!.trim().isEmpty ? ConstHelper.noImageFoundPath : '${ConstHelper.newsImagePath}${homeController.selectNewsData.value.newsImage!}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            height: Get.width/15,
                            width: Get.width/15,
                            child: CircularProgressIndicator(color: ConstHelper.darkBlueColor,strokeWidth: 2,),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ConstHelper.whiteColor,
                          ),
                          child: Image.asset(
                            'assets/image/imageNotFound.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*0.04),
                  child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "🗓️ ${homeController.selectNewsData.value.newsCreatedDate == null || homeController.selectNewsData.value.newsCreatedDate!.year <= 0 ? 'Date N/A' : DateFormat('dd MMM,yyyy').format(homeController.selectNewsData.value.newsCreatedDate !)}",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: ConstHelper.blackColor,letterSpacing:1,fontWeight: FontWeight.w400,fontSize: Get.width*0.04,
                        ),
                      ),
                    ),
                  ],
                ),),

                Container(
                  padding: EdgeInsets.all( Get.width/40),
                  margin: EdgeInsets.symmetric(horizontal:  Get.width/30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(77), // Light grey shadow with opacity
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius for softness
                        offset: const Offset(2, 2), // Horizontal and vertical offset
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width*0.01),),),
                  // child: Image.asset('assets/image/imageNotFound.png',fit: BoxFit.cover,),
                  child: Column(
                    children: [
                      Center(child: Text(homeController.selectNewsData.value.newsHeadlines == null || homeController.selectNewsData.value.newsHeadlines!.trim().isEmpty ? 'Headline N/A' : homeController.selectNewsData.value.newsHeadlines!.toUpperCase(),textAlign: TextAlign.center,style: TextStyle(color: ConstHelper.darkBlueColor,letterSpacing:1,fontWeight: FontWeight.w600,fontSize: Get.width*0.05,),)),
                      const Divider(thickness: 0.9,),
                      SizedBox(height: Get.width/40,),
                      Center(child: Text(homeController.selectNewsData.value.newsContent == null || homeController.selectNewsData.value.newsContent!.trim().isEmpty ? 'Details N/A' : homeController.selectNewsData.value.newsContent!,
                        textAlign:TextAlign.justify,
                        style: TextStyle(
                          color: ConstHelper.blackColor.withAlpha(230),
                          letterSpacing:1,
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width*0.04,
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                ],
            ),
          ),
        ));
  }
}
