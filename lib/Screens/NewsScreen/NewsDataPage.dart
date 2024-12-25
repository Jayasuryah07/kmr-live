import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmr/Controllers/HomeController.dart';
import 'package:kmr/Utils/ConstHelper.dart';

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
            backgroundColor: ConstHelper.darkBlueColor,
            title: Text(
              'KMR LIVE',
              style: TextStyle(
                color: ConstHelper.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          backgroundColor: ConstHelper.whiteColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: Get.width/3,
                      width: Get.width/3,
                      color: Color(0xffF7F7F7),
                      // child: Image.asset('assets/image/imageNotFound.png',fit: BoxFit.cover,),
                      child: CachedNetworkImage(
                        imageUrl: homeController.selectNewsData.value.newsImage == null || homeController.selectNewsData.value.newsImage!.trim().isEmpty ? ConstHelper.noImageFoundPath : '${ConstHelper.newsImagePath}${homeController.selectNewsData.value.newsImage!}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            height: Get.width/20,
                            width: Get.width/20,
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
                  SizedBox(height: Get.width/40,),
                  Center(child: Text(homeController.selectNewsData.value.newsHeadlines == null || homeController.selectNewsData.value.newsHeadlines!.trim().isEmpty ? 'Headline N/A' : homeController.selectNewsData.value.newsHeadlines!,textAlign: TextAlign.center,style: TextStyle(color: ConstHelper.blackColor,fontWeight: FontWeight.w600,fontSize: 15,),)),
                  SizedBox(height: Get.width/40,),
                  Center(child: Text(homeController.selectNewsData.value.newsContent == null || homeController.selectNewsData.value.newsContent!.trim().isEmpty ? 'Details N/A' : homeController.selectNewsData.value.newsContent!,style: TextStyle(color: ConstHelper.blackColor.withOpacity(0.6),fontWeight: FontWeight.w500,fontSize: 13,))),
                ],
              ),
            ),
          ),
        ));
  }
}
