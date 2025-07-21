import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Models/category_data_model.dart';
import '../Models/live_data_model.dart';
import '../Models/news_data_model.dart';
import '../Models/sub_category_model.dart';
import '../Models/user_data_model.dart';
import '../Models/vendor_rate_data_model.dart';
import '../Models/vendor_spot_rate_data_model.dart';
import '../Screens/home_screen/live_page.dart';
import '../Screens/home_screen/news_page.dart';
import '../Screens/home_screen/rates_page.dart';
import '../Screens/home_screen/spot_page.dart';
import '../Utils/api_helper.dart';
import '../Utils/shared_pref_helper.dart';
import '../Models/category_item_model.dart';

class HomeController extends GetxController {
  RxInt sliderIndex = 0.obs;
  RxBool favorite = false.obs;
  RxBool loadData = false.obs;
  RxBool loadCatData = false.obs;
  RxBool isOpen = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool searchStart = false.obs;
  RxBool searchClick = false.obs;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController txtSearch = TextEditingController();
  RxInt selectedTabIndex = 0.obs;
  RxList<LiveDataModel> allLiveDataList = <LiveDataModel>[].obs;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  RxList<VendorRateDataModel> allRatesDataList = <VendorRateDataModel>[].obs;
  RxList<SubCatg> allSubCtgList = <SubCatg>[].obs;
  var allSpotRateDataList =
      <VendorSpotRateDataModel>[].obs;
  RxList<NewsDataModel> allNewsDataList = <NewsDataModel>[].obs;

  RxList<LiveDataModel> searchedLiveDataList = <LiveDataModel>[].obs;
  RxList<CategoryItem> categoryFirstItem =  <CategoryItem>[].obs;
  RxList<VendorRateDataModel> searchedRatesDataList =
      <VendorRateDataModel>[].obs;
  RxList<VendorSpotRateDataModel> searchedSpotRateDataList =
      <VendorSpotRateDataModel>[].obs;
  RxList<NewsDataModel> searchedNewsDataList = <NewsDataModel>[].obs;
  Rx<NewsDataModel> selectNewsData = NewsDataModel().obs;
  RxList<CategoryDataModel> allCategoryDataList = <CategoryDataModel>[].obs;
  Rx<CategoryDataModel> selectCategoryData = CategoryDataModel().obs;
  RxList<SubCategoryDataModel> allSubCategoryDataList =
      <SubCategoryDataModel>[].obs;
  TabController? tabController;
  RxString otpVerificationId = "".obs;
  RxInt otpResendCode = 0.obs;
  RxString mobileNo = "".obs;
  RxString password = "".obs;

  RxList screens = [
    const LivePage(),
    const RatesPage(),
    const SpotPage(),
    const NewsPage(),
  ].obs;
  // final advancedDrawerController = AdvancedDrawerController();
  // RxList communityDataList = [].obs;
  // RxList gotraDataListCommunityIdWise = [].obs;
  // RxList educationDataList = [].obs;
  // RxList<MembersDataModel> allMembersDataListGenderWise = <MembersDataModel>[].obs;
  // RxList<MembersDataModel> allShortlistedDataList = <MembersDataModel>[].obs;
  // Rx<MembersDataModel> selectedMembersData = MembersDataModel().obs;
  RxString firebaseFCMToken = "".obs;
  Rx<UserDataModel> userDataWithToken = UserDataModel().obs;
  Rx<User> userData = User().obs;

  Future<void> getUserData() async {
    String userStringData =
        SharedPrefHelper.sharedPreferences.getString('userData') ?? '';
    Map userMapData = userStringData.isEmpty ? {} : jsonDecode(userStringData);
    userDataWithToken.value = userMapData.isEmpty
        ? UserDataModel()
        : UserDataModel.fromJson(userMapData);
    userData.value = userDataWithToken.value.user ?? User();
  }

  Future<void> getLiveData({
    required String categoryValue,
    required String? subCategoryValue,
  }) async {
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchStart.value = false;
    searchClick.value = false;
    loadData.value = true;

    // await ApiHelper.apiHelper
    //     .getAllLiveDataList(
    //   categoryValue: categoryValue,
    //   subCategoryValue: subCategoryValue!,
    // )
    //     .then(
    //   (liveDataList) {
    //     allLiveDataList.value = liveDataList.data??[];
    //     searchedLiveDataList.value = liveDataList.data??[];
    //     allSubCtgList.value = liveDataList.subCatg??[];
    //     loadData.value = false;
    //   },
    // );
    //
    // loadData.value = false;

    try {
      final liveDataList = await ApiHelper.apiHelper.getAllLiveDataList(
        categoryValue: categoryValue,
        subCategoryValue: subCategoryValue!,
      );

      allLiveDataList.value = liveDataList.data ?? [];
      searchedLiveDataList.value = liveDataList.data ?? [];
      allSubCtgList.value = liveDataList.subCatg ?? [];

    } catch (error) {
      debugPrint('LiveData-Error: $error');
    } finally {
      loadData.value = false;
    }


  }
  // Method to filter products based on search query
  void filterLiveData(String searchQuery) {
    // Backup the original data if it's not already backed up
    if (searchedLiveDataList.isEmpty) {
      searchedLiveDataList.assignAll(allLiveDataList);
    }

    if (searchQuery.isEmpty) {
      // Restore the original data when the search query is empty
      allLiveDataList.value = List<LiveDataModel>.from(searchedLiveDataList);
    } else {
      // Filter products based on the search query
      allLiveDataList.value = searchedLiveDataList
          .where((liveData) =>
      liveData.vendorName
          .toString()
          .trim()
          .toLowerCase()
          .contains(searchQuery) ||
          liveData.vendorProduct
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery) ||
          liveData.vendorProductSize
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery) ||
          liveData.vendorProductRate
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery) ||
          liveData
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery) ||
          liveData
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchQuery))
          .toList();
    }

    // Debug logs
    debugPrint("Filtered products length: ${searchedLiveDataList.length}");
    debugPrint("Displayed products length: ${allLiveDataList.length}");
  }

  Future<void> getCategoryItemData({
    required String id,
  }) async {
    loadCatData.value = true;
    categoryFirstItem.clear();

    // try {
    //   await ApiHelper.apiHelper
    //       .getSubCategoryItem(
    //     id: id,
    //   )
    //       .then(
    //     (categoryData) {
    //       if(categoryData.data != null && categoryData.data!.isNotEmpty){
    //         categoryFirstItem.value = categoryData.data??[];
    //         loadCatData.value = false;
    //       }
    //     },
    //   );
    // } catch (error) {
    //   loadCatData.value = false;
    //   debugPrint('Cache-Error : $error');
    // }

    try {
      final categoryData = await ApiHelper.apiHelper.getSubCategoryItem(id: id);

      if (categoryData.data != null && categoryData.data!.isNotEmpty) {
        categoryFirstItem.value = categoryData.data!;
      }

    } catch (error) {
      debugPrint('Cache-Error : $error');
    } finally {
      loadCatData.value = false;
    }


  }

  Future<void> getRateData({
    required String categoryValue,
    required String? subCategoryValue,
  }) async {
    loadData.value = true;
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchStart.value = false;
    searchClick.value = false;

    // try {
    //   await ApiHelper.apiHelper
    //       .getAllRatesDataList(
    //     categoryValue: categoryValue,
    //     subCategoryValue: subCategoryValue!,
    //   )
    //       .then((ratesDataList) {
    //       allRatesDataList.value = ratesDataList.data??[];
    //       searchedRatesDataList.value = ratesDataList.data??[];
    //       allSubCtgList.value = ratesDataList.subCatg??[];
    //       loadData.value = false;
    //     },
    //   );
    // } catch (error) {
    //   loadData.value = false;
    //   debugPrint('Cache-Error : $error');
    // }

    try {
      final ratesDataList = await ApiHelper.apiHelper.getAllRatesDataList(
        categoryValue: categoryValue,
        subCategoryValue: subCategoryValue!,
      );

      allRatesDataList.value = ratesDataList.data ?? [];
      searchedRatesDataList.value = ratesDataList.data ?? [];
      allSubCtgList.value = ratesDataList.subCatg ?? [];
    } catch (error) {
      debugPrint('Cache-Error : $error');
    } finally {
      loadData.value = false;
    }

  }

  void filterRatesData(String searchValue) {
    // Backup the original data if it's not already backed up
    if (searchedRatesDataList.isEmpty) {
      searchedRatesDataList.assignAll(allRatesDataList);
    }

    if (searchValue.isEmpty) {
      // Restore the original data when the search query is empty
      allRatesDataList.value = List<VendorRateDataModel>.from(searchedRatesDataList);
    } else {
      allRatesDataList.value = searchedRatesDataList.where((p0) {
        // Format date
        String date = '';
        if (p0.vendorCreatedDate != null &&
            (p0.vendorCreatedDate?.year ?? 0) > 0) {
          date = DateFormat('dd/MMM/yyyy').format(p0.vendorCreatedDate!);
        }

        // Format time
        String time = '';
        if (p0.vendorCreatedTime != null &&
            p0.vendorCreatedTime!.trim().isNotEmpty) {
          try {
            final parsedTime = DateFormat("HH:mm:ss").parse(
                p0.vendorCreatedTime!);
            time = DateFormat('hh:mm a').format(parsedTime);
          } catch (e) {
            time = '';
          }
        }

        List<VendorProduct> vendorProduct = p0.vendorProduct ?? [];

        // Lowercase search
        final query = searchValue.toLowerCase().trim();

        return (p0.vendorName ?? "").trim().toLowerCase().contains(query) ||
            (p0.vendorCity ?? "").trim().toLowerCase().contains(query) ||
            date.toLowerCase().trim().contains(query) ||
            time.toLowerCase().trim().contains(query) ||
            vendorProduct.any((element) =>
            (element.vendorProduct ?? "").toLowerCase().trim().contains(query) ||
                (element.vendorProductSize ?? "").toLowerCase().trim().contains(
                    query) ||
                (element.vendorProductRate ?? "").toString().trim()
                    .toLowerCase()
                    .contains(query));
      }).toList();
    }

    debugPrint("Filtered products length: ${searchedRatesDataList.length}");
    debugPrint("Displayed products length: ${allRatesDataList.length}");
  }

  Future<void> getSpotRateData({
    required String categoryValue,
  }) async {
    loadData.value = true;
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchStart.value = false;
    searchClick.value = false;
    try {
      await ApiHelper.apiHelper
          .getAllSpotDataList(
        categoryValue: categoryValue,
      )
          .then(
            (spotRateDataList) {
          allSpotRateDataList.value = spotRateDataList;
          searchedSpotRateDataList.value = spotRateDataList;
          loadData.value = false;
        },
      );
    } catch (error) {
      loadData.value = false;
      debugPrint('Cache-Error : $error');
    }
  }

  void filterSpotData(String searchQuery) {
    // Backup the original data if it's not already backed up
    if (searchedSpotRateDataList.isEmpty) {
      searchedSpotRateDataList.assignAll(allSpotRateDataList);
    }

    if (searchQuery.isEmpty) {
      // Restore the original data when the search query is empty
      allSpotRateDataList.value = List<VendorSpotRateDataModel>.from(allSpotRateDataList);
    } else {
      // Filter products based on the search query
      allSpotRateDataList.value = searchedSpotRateDataList.where((p0) {
        // Format date
        String date = '';
        if (p0.vendorSpotCreatedDate != null &&
            (p0.vendorSpotCreatedDate?.year ?? 0) > 0) {
          date = DateFormat('dd/MMM/yyyy').format(p0.vendorSpotCreatedDate!);
        }

        // Format time
        String time = '';
        if (p0.vendorSpotCreatedTime != null &&
            p0.vendorSpotCreatedTime!.trim().isNotEmpty) {
          try {
            final parsedTime = DateFormat("HH:mm:ss").parse(
                p0.vendorSpotCreatedTime!);
            time = DateFormat('hh:mm a').format(parsedTime);
          } catch (e) {
            time = '';
          }
        }

        // Lowercase search
        return (p0.vendorSpotHeading ?? "").trim().toLowerCase().contains(searchQuery) ||
            (p0.vendorSpotDetails ?? "").trim().toLowerCase().contains(searchQuery) ||
            date.toLowerCase().trim().contains(searchQuery) ||
            time.toLowerCase().trim().contains(searchQuery);
      }).toList();
    }

    // Debug logs
    debugPrint("Filtered products length: ${searchedLiveDataList.length}");
    debugPrint("Displayed products length: ${allLiveDataList.length}");
  }

  Future<void> getNewsData() async {
    loadData.value = true;
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchStart.value = false;
    searchClick.value = false;
    try {
      await ApiHelper.apiHelper.getAllNewsDataList().then(
            (newsDataList) {
          allNewsDataList.value = newsDataList;
          loadData.value = false;
        },
      );
    } catch (error) {
      loadData.value = false;
      debugPrint('Cache-Error : $error');
    }
  }

  Future<void> getCategoryData() async {
    try {
      await ApiHelper.apiHelper.getCategoryDataList().then(
            (categoryDataList) {
          allCategoryDataList.value = categoryDataList;
          debugPrint("allCategoryDataList ${allCategoryDataList.length}");
        },
      );
    } catch (error) {
      debugPrint('Cache-Error : $error');
    }
  }

  /// Resend Timer
  final otp = "".obs;
  RxString verify = ''.obs;
  RxInt resendToken = 0.obs;
  late Timer timer;
  final start = 30.obs;
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(oneSec, (Timer timer) {
      if (start.value < 1) {
        timer.cancel();
      } else {
        start.value = start.value - 1;
      }
    });
  }

}
