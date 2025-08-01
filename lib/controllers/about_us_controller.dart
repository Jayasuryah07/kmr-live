import 'package:get/get.dart';
import '../Models/about_us_model.dart';
import '../Utils/api_helper.dart';
import '../Utils/const_helper.dart';

class AboutUsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  Rx<AboutUsModel> aboutUsModel = AboutUsModel().obs;

  var currentPage = 0.obs; // Observable to track the current page

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAboutUsData();
    super.onReady();
  }

  void getAboutUsData() async {
    if (!(await ConstHelper.checkInternet())) {
      Get.snackbar(
        "No Internet",
        'Please check your internet connection',
        snackPosition: SnackPosition
            .BOTTOM, // Position: TOP or BOTTOM
      );
      return;
    }
    else
    {
      aboutUsModel.value = await ApiHelper.apiHelper.fetchAboutUsApiUrl(
        loading: isLoading,
      );
    }
  }

}
