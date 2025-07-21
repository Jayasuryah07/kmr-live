import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kmr_flutter_application/Controllers/notification_controller.dart';
import '../../Utils/const_helper.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  Future<void> _refreshNotifications() async {
    await controller.fetchAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstHelper.lightBlueColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: ConstHelper.whiteColor),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Notifications",
            style: TextStyle(
              fontSize: Get.width * 0.05,
              fontWeight: FontWeight.w600,
              color: ConstHelper.whiteColor,
            ),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: ConstHelper.darkBlueColor),
            );
          }

          if (controller.notificationList.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refreshNotifications,
              child: ListView(
                children: [
                  SizedBox(height: Get.height * 0.25),
                  Center(
                    child: Column(
                      children: [
                        const Icon(Icons.notifications_off, size: 48, color: Colors.grey),
                        const SizedBox(height: 12),
                        Text(
                          "No Notifications Available",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshNotifications,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: controller.notificationList.length,
              itemBuilder: (context, index) {
                final item = controller.notificationList[index];
                return NotificationCard(item: item);
              },
            ),
          );
        }),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final dynamic item;

  const NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM, yyyy').format(item.notificationCreateDate ?? DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
          vertical: Get.height * 0.015,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: ConstHelper.notificationImagePath + (item.notificationImage ?? ""),
              imageBuilder: (context, imageProvider) => Container(
                height: Get.width / 6,
                width: Get.width / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Container(
                height: Get.width / 6,
                width: Get.width / 6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ConstHelper.whiteColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CircularProgressIndicator(
                  color: ConstHelper.orangeColor,
                  strokeWidth: 2,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: Get.width / 6,
                width: Get.width / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ConstHelper.whiteColor,
                  image: DecorationImage(
                    image: NetworkImage(ConstHelper.noImageFoundPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.notificationHeading ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: Get.width * 0.045,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      color: ConstHelper.darkBlueColor,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Text(
                    item.notificationDescription ?? '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: Get.width * 0.04,
                      letterSpacing: 1,
                      color: ConstHelper.blackColor,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.015),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "🗓️ $dateStr",
                      style: TextStyle(
                        fontSize: Get.width * 0.035,
                        color: ConstHelper.blackColor.withAlpha(204),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kmr_flutter_application/Controllers/notification_controller.dart';
//
// import '../../Utils/const_helper.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   NotificationController  controller = Get.put(NotificationController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => SafeArea(child:  Scaffold(
//       appBar: AppBar(
//         backgroundColor: ConstHelper.lightBlueColor,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Center(
//             child: Icon(
//               Icons.arrow_back_outlined,
//               color: ConstHelper.whiteColor,
//             ),
//           ),
//         ),
//         titleSpacing: 0,
//         title: Text(
//           "Notifications",
//           style: TextStyle(
//             fontSize: Get.width*0.05,
//             fontWeight: FontWeight.w600,
//             color: ConstHelper.whiteColor,
//           ),
//         ),
//       ),
//       body: Container(
//         padding:  const EdgeInsets.all(12),
//         child: controller.isLoading.value ? Center(child: CircularProgressIndicator(color: ConstHelper.darkBlueColor,),): controller.notificationList.isEmpty ?  Center(
//           child: Text("No Notifications Available",style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: Get.width*0.045
//           ),),
//         ) :ListView.builder(
//           itemCount: controller.notificationList.length,
//           itemBuilder: (context, index) {
//             return Card(
//               child: Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.01),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                   SizedBox(
//                     height: Get.width / 6,
//                     width: Get.width / 6,
//                     child: ClipRRect(
//                       borderRadius:
//                       BorderRadius.circular(6),
//                       child: CachedNetworkImage(
//                         imageUrl:  ConstHelper.notificationImagePath+(controller.notificationList[index].notificationImage??"") ,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) =>
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                 BorderRadius.circular(
//                                     6),
//                                 color: ConstHelper
//                                     .whiteColor,
//                               ),
//                               alignment: Alignment.center,
//                               child: SizedBox(
//                                 height: Get.width / 20,
//                                 width: Get.width / 20,
//                                 child:
//                                 CircularProgressIndicator(
//                                   color: ConstHelper
//                                       .orangeColor,
//                                   strokeWidth: 2,
//                                 ),
//                               ),
//                             ),
//                         errorWidget:
//                             (context, url, error) =>
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                 BorderRadius.circular(
//                                     6),
//                                 color: ConstHelper
//                                     .whiteColor,
//                               ),
//                               child: Image.network(
//                                 ConstHelper.noImageFoundPath,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: Get.width*0.04,),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                       Text(controller.notificationList[index].notificationHeading.toString(),
//                         textAlign: TextAlign.justify,
//                         style: TextStyle(fontSize: Get.width * 0.045,
//                           letterSpacing: 1,fontWeight: FontWeight.bold,color: ConstHelper.darkBlueColor),),
//                         SizedBox(height: Get.height*0.01,),
//
//                         Text(controller.notificationList[index].notificationDescription.toString(),
//                             textAlign: TextAlign.justify,
//                             style: TextStyle(fontSize: Get.width * 0.04,
//                           letterSpacing: 1,fontWeight: FontWeight.normal,color: ConstHelper.blackColor)),
//                         SizedBox(height: Get.height*0.015,),
//
//                         Row(
//                         children: [
//                           Expanded(
//                             child: Text("🗓️ ${DateFormat('dd MMM, yyyy').format(controller.notificationList[index].notificationCreateDate!)}",
//                                 textAlign: TextAlign.end,
//                                 style: TextStyle(fontSize: Get.width * 0.035,
//                                 letterSpacing: 1,
//                                     color: ConstHelper.blackColor.withAlpha(204)
//                                 )
//                             ),
//                           ),
//                         ],
//                       ),
//
//                     ],),
//                   ),
//                 ],),
//               ),
//             );
//           },
//         ),
//       ),
//     )));
//
//   }
//
// }