import 'package:get/get.dart';
import '../Models/user_model.dart';
import '../Utils/api_helper.dart';
import '../Utils/const_helper.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  Rx<UserModel> useDataModel = UserModel().obs;

  var currentPage = 0.obs; // Observable to track the current page

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getProfileData();
    super.onReady();
  }

  void getProfileData() async {
    if (!(await ConstHelper.checkInternet())) {
      Get.snackbar(
        "No Internet",
        'Please check your internet connection',
        snackPosition: SnackPosition
            .BOTTOM, // Position: TOP or BOTTOM
      );
      return;
    }
    useDataModel.value = await ApiHelper.apiHelper.fetchUserApiUrl(
      loading: isLoading,
    );
  }
}
