
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmr_flutter_application/Controllers/fetch_notification_controller.dart';

import '../../Utils/ConstHelper.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController  controller = Get.put(NotificationController());

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
          "Notifications",
          style: TextStyle(
            fontSize: Get.width*0.05,
            fontWeight: FontWeight.w600,
            color: ConstHelper.whiteColor,
          ),
        ),
      ),
      body: Container(
        padding:  EdgeInsets.all(12),
        child: controller.isLoading.value ? Center(child: CircularProgressIndicator(color: ConstHelper.darkBlueColor,),): controller.notificationList.isEmpty ?  Center(
          child: Text("No Notifications Available",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Get.width*0.06
          ),),
        ) :ListView.builder(
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(
                    height: Get.width / 6,
                    width: Get.width / 6,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl:  ConstHelper.notificationImagePath+(controller.notificationList[index].notificationImage??"") ,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    6),
                                color: ConstHelper
                                    .whiteColor,
                              ),
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: Get.width / 20,
                                width: Get.width / 20,
                                child:
                                CircularProgressIndicator(
                                  color: ConstHelper
                                      .orangeColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) =>
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    6),
                                color: ConstHelper
                                    .whiteColor,
                              ),
                              child: Image.network(
                                ConstHelper.noImageFoundPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width*0.04,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(controller.notificationList[index].notificationHeading.toString(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: Get.width * 0.045,
                          letterSpacing: 1,fontWeight: FontWeight.bold,color: ConstHelper.darkBlueColor),),
                        SizedBox(height: Get.height*0.01,),

                        Text(controller.notificationList[index].notificationDescription.toString(),
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: Get.width * 0.04,
                          letterSpacing: 1,fontWeight: FontWeight.normal,color: ConstHelper.blackColor)),
                        SizedBox(height: Get.height*0.015,),

                        Row(
                        children: [
                          Expanded(
                            child: Text("Date : ${DateFormat('dd-MMM-yyyy').format(controller.notificationList[index].notificationCreateDate!)}",
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: Get.width * 0.035,
                                letterSpacing: 1,color: ConstHelper.blackColor.withOpacity(0.8))),
                          ),
                        ],
                      ),

                    ],),
                  ),
                ],),
              ),
            );
          },
        ),
      ),
    ));
  }
}
