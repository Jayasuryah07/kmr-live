import 'package:get/get.dart';
import 'package:kmr_flutter_application/Models/notification_model.dart';
import '../Utils/api_helper.dart';
import '../Utils/const_helper.dart';

class NotificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  RxList<NotificationData> notificationList = <NotificationData>[].obs;
  var currentPage = 0.obs;

  @override
  void onReady() {
    fetchAllNotifications(); // Load initially
    super.onReady();
  }

  Future<void> fetchAllNotifications() async {
    if (!(await ConstHelper.checkInternet())) {
      Get.snackbar(
        "No Internet",
        'Please check your internet connection',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    notificationList.value = await ApiHelper.apiHelper.fetchNotificationApiUrl(
      loading: isLoading,
    );
  }
}

// import 'package:get/get.dart';
// import 'package:kmr_flutter_application/Models/notification_model.dart';
// import '../Utils/api_helper.dart';
// import '../Utils/const_helper.dart';
//
// class NotificationController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   RxBool isLoading = false.obs;
//
//   RxList<NotificationData> notificationList = <NotificationData>[].obs;
//
//   var currentPage = 0.obs; // Observable to track the current page
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   @override
//   void onReady() {
//     getNotificationData();
//     super.onReady();
//   }
//
//   void getNotificationData() async {
//     if (!(await ConstHelper.checkInternet())) {
//       Get.snackbar(
//         "No Internet",
//         'Please check your internet connection',
//         snackPosition: SnackPosition
//             .BOTTOM, // Position: TOP or BOTTOM
//       );
//       return;
//     }
//     notificationList.value = await ApiHelper.apiHelper.fetchNotificationApiUrl(
//       loading: isLoading,
//     );
//   }
// }