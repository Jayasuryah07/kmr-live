
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
          "Notification",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ConstHelper.whiteColor,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: controller.isLoading.value ? Center(child: CircularProgressIndicator(color: ConstHelper.darkBlueColor,),): controller.notificationList.isEmpty ? const Center(
          child: Text("No Notifications Available",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
          ),),
        ) :ListView.builder(
          itemCount: controller.notificationList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: SizedBox(
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
                title:Text(controller.notificationList[index].notificationHeading.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: ConstHelper.darkBlueColor),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.notificationList[index].notificationDescription.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: ConstHelper.blackColor)),
                    Text("Date : ${DateFormat('dd-MMM-yyyy').format(controller.notificationList[index].notificationCreateDate!)}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: ConstHelper.blackColor)),


                  ],
                ),

              ),
            );
          },
        ),
      ),
    ));
  }
}
