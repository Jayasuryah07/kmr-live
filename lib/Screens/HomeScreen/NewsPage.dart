import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controllers/HomeController.dart';
import '../../Utils/ConstHelper.dart';
import '../NewsScreen/NewsDataPage.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    homeController.getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: ConstHelper.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width/30,),
        child: Obx(
          () => homeController.loadData.value ? Center(child: CircularProgressIndicator(color: ConstHelper.darkBlueColor,),) : homeController.searchStart.value ? homeController.searchedNewsDataList.isEmpty ? RefreshIndicator(
            onRefresh: () async {
              await homeController.getNewsData();
            },
            backgroundColor: ConstHelper.whiteColor, color: ConstHelper.darkBlueColor,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height / 3.8,
                    horizontal: Get.width * 0.04,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Oops! Nothing here now—fresh content incoming!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ConstHelper.darkBlueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width*0.045,
                              letterSpacing: 1
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : RefreshIndicator(
            onRefresh: () async {
              await homeController.getNewsData();
            },
            backgroundColor: ConstHelper.whiteColor,
            color: ConstHelper.darkBlueColor,
            child: ListView.builder(
              itemCount: homeController.searchedNewsDataList.length,
              itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: Get.width/30,bottom: (index+1) != homeController.searchedNewsDataList.length ? 0 : Get.width/30,),
                child: Container(
                  decoration: BoxDecoration(
                    color: ConstHelper.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: ConstHelper.cementColor.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Get.width/5,
                              width: Get.width/5,
                              color: Color(0xffF7F7F7),
                              // child: Image.asset('assets/image/imageNotFound.png',fit: BoxFit.cover,),
                              child: CachedNetworkImage(
                                imageUrl: homeController.searchedNewsDataList[index].newsImage == null || homeController.searchedNewsDataList[index].newsImage!.trim().isEmpty ? ConstHelper.noImageFoundPath : '${ConstHelper.newsImagePath}${homeController.searchedNewsDataList[index].newsImage!}',
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
                            SizedBox(width: Get.width/60,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(homeController.searchedNewsDataList[index].newsHeadlines == null || homeController.searchedNewsDataList[index].newsHeadlines!.trim().isEmpty ? 'Headline N/A' : homeController.searchedNewsDataList[index].newsHeadlines!,
                                    maxLines: 2,
                                    style: TextStyle(color: ConstHelper.blackColor,fontWeight: FontWeight.w600,fontSize: Get.width * 0.045,
                                      letterSpacing: 1,),),
                                  Text(homeController.searchedNewsDataList[index].newsContent == null || homeController.searchedNewsDataList[index].newsContent!.trim().isEmpty ? 'Details N/A' : homeController.searchedNewsDataList[index].newsContent!,style: TextStyle(color: ConstHelper.blackColor.withOpacity(0.6),fontWeight: FontWeight.w500,fontSize: Get.width * 0.04,
                                    letterSpacing: 1,),maxLines: 3,),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text:  "🗓️ " +(homeController.
                                              searchedNewsDataList[index].newsCreatedDate ==
                                                  null ||
                                                  homeController
                                                      .searchedNewsDataList[index].newsCreatedDate!
                                                      .year <=
                                                      0
                                                  ? 'Date N/A'
                                                  : DateFormat(
                                                  'dd/MMM/yyyy')
                                                  .format(homeController
                                                  .searchedNewsDataList[index].newsCreatedDate!)),
                                              style: TextStyle(
                                                fontSize: Get.width*0.035,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w400,
                                                color: ConstHelper.blackColor
                                                    .withOpacity(0.9),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child:  InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                homeController.selectNewsData.value = homeController.searchedNewsDataList[index];
                                                Get.to(const NewsDataPage(),transition: Transition.fadeIn);
                                              },
                                              borderRadius: BorderRadius.circular(10),
                                              child: Text("View More",style: TextStyle(color: ConstHelper.darkBlueColor,decoration:TextDecoration.underline,fontSize: Get.width * 0.035,
                                                  letterSpacing: 1,fontWeight: FontWeight.w600),)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },),
          ) : homeController.allNewsDataList.isEmpty ? RefreshIndicator(
            onRefresh: () async {
              await homeController.getNewsData();
            },
            backgroundColor: ConstHelper.whiteColor,
            color: ConstHelper.darkBlueColor,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height / 3.8,
                    horizontal: Get.width * 0.04,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Oops! Nothing here now—fresh content incoming!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ConstHelper.darkBlueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width*0.045,
                              letterSpacing: 1
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : RefreshIndicator(
            onRefresh: () async {
              await homeController.getNewsData();
            },
            backgroundColor: ConstHelper.whiteColor,
            color: ConstHelper.darkBlueColor,
            child: ListView.builder(itemCount: homeController.allNewsDataList.length,itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: Get.width/30,bottom: (index+1) != homeController.allNewsDataList.length ? 0 : Get.width/30,),
                child: Container(
                  decoration: BoxDecoration(
                    color: ConstHelper.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: ConstHelper.cementColor.withOpacity(0.6),
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: Get.width/60,),
                              Row(
                                children: [
                                  Container(
                                    height: Get.width/5,
                                    width: Get.width/5,
                                    color: Color(0xffF7F7F7),
                                    // child: Image.asset('assets/image/imageNotFound.png',fit: BoxFit.cover,),
                                    child: CachedNetworkImage(
                                      imageUrl: homeController.allNewsDataList[index].newsImage == null || homeController.allNewsDataList[index].newsImage!.trim().isEmpty ? ConstHelper.noImageFoundPath : '${ConstHelper.newsImagePath}${homeController.allNewsDataList[index].newsImage!}',
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
                                  SizedBox(width: Get.width/60,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(homeController.allNewsDataList[index].newsHeadlines == null || homeController.allNewsDataList[index].newsHeadlines!.trim().isEmpty ? 'Headline N/A' : homeController.allNewsDataList[index].newsHeadlines!,
                                          maxLines: 2,
                                          style: TextStyle(color: ConstHelper.darkBlueColor,letterSpacing:1,
                                            height: 1.3,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,fontSize: Get.width*0.04,),),
                                        Text(homeController.allNewsDataList[index].newsContent == null || homeController.allNewsDataList[index].newsContent!.trim().isEmpty ? 'Details N/A' : homeController.allNewsDataList[index].newsContent!,
                                          style: TextStyle(color: ConstHelper.blackColor.withOpacity(0.9),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,letterSpacing:1,fontSize: Get.width*0.035,),maxLines: 3,),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:  "🗓️ " +(homeController.
                                  allNewsDataList[index].newsCreatedDate ==
                                              null ||
                                              homeController
                                                  .allNewsDataList[index].newsCreatedDate!
                                                  .year <=
                                                  0
                                              ? 'Date N/A'
                                              : DateFormat(
                                              'dd/MMM/yyyy')
                                              .format(homeController
                                              .allNewsDataList[index].newsCreatedDate!)),
                                          style: TextStyle(
                                            fontSize: Get.width*0.035,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w400,
                                            color: ConstHelper.blackColor
                                                .withOpacity(0.9),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                               /*   Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:homeController.allNewsDataList[index].newsCreatedDate == null || homeController.allNewsDataList[index].newsCreatedDate!.year <= 0 ? 'Date N/A' : DateFormat('dd/MMM/yyyy').format(homeController.allNewsDataList[index].newsCreatedDate!),
                                          style: TextStyle(fontSize: Get.width*0.03,color: ConstHelper.blackColor.withOpacity(0.8),),
                                        ),
                                        // const TextSpan(text: '  '),
                                        // TextSpan(
                                        //   text: homeController.allNewsDataList[index].vendorSpotCreatedTime == null || homeController.allNewsDataList[index].vendorSpotCreatedTime!.trim().isEmpty ? 'Time N/A' : DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(homeController.allNewsDataList[index].vendorSpotCreatedTime!)),
                                        //   style: TextStyle(fontSize: 12,color: ConstHelper.blackColor.withOpacity(0.6),),
                                        // ),
                                      ],
                                    ),
                                  ),*/
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:  InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            homeController.selectNewsData.value = homeController.allNewsDataList[index];
                                            Get.to(const NewsDataPage(),transition: Transition.fadeIn);
                                          },
                                          borderRadius: BorderRadius.circular(10),
                                          child: Text("View More",style: TextStyle(color: ConstHelper.darkBlueColor,letterSpacing:1,decoration:TextDecoration.underline,fontSize: Get.width*0.035,fontWeight: FontWeight.w600),)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },),
          ),
        ),
      ),
    ));
  }
}
