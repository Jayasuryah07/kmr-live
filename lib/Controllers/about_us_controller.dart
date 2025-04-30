import 'package:get/get.dart';
import '../Models/about_us_model.dart';
import '../Utils/ApiHelper.dart';

class AboutUsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  Rx<AboutUsModel> aboutUsModel = AboutUsModel().obs;

  var currentPage = 0.obs; // Observable to track the current page

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getAboutUsData();
    super.onReady();
  }

  void getAboutUsData() async {
    aboutUsModel.value = await ApiHelper.apiHelper.fetchAboutUsApiUrl(
      loading: isLoading,
    );
  }
}
