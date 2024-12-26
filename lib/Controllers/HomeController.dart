import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/CategoryDataModel.dart';
import '../Models/LiveDataModel.dart';
import '../Models/NewsDataModel.dart';
import '../Models/SubCategoryModel.dart';
import '../Models/UserDataModel.dart';
import '../Models/VendorRateDataModel.dart';
import '../Models/VendorSpotRateDataModel.dart';
import '../Screens/HomeScreen/LivePage.dart';
import '../Screens/HomeScreen/NewsPage.dart';
import '../Screens/HomeScreen/RatesPage.dart';
import '../Screens/HomeScreen/SpotPage.dart';
import '../Utils/ApiHelper.dart';
import '../Utils/SharedPrefHelper.dart';
import '../Models/CategoryItemModel.dart';

class HomeController extends GetxController {
  RxBool check = false.obs;
  RxInt sliderIndex = 0.obs;
  RxBool favorite = false.obs;
  RxBool loadData = false.obs;
  RxBool loadCatData = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool searchStart = false.obs;
  RxBool searchClick = false.obs;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController txtSearch = TextEditingController();
  RxInt selectedTabIndex = 0.obs;
  RxList<LiveDataModel> allLiveDataList = <LiveDataModel>[].obs;
  RxList<VendorRateDataModel> allRatesDataList = <VendorRateDataModel>[].obs;
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
    required String subCategoryValue,
  }) async {
    loadData.value = true;
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchStart.value = false;
    searchClick.value = false;
    try {
      await ApiHelper.apiHelper
          .getAllLiveDataList(
        categoryValue: categoryValue,
        subCategoryValue: subCategoryValue,
      )
          .then(
        (liveDataList) {
          allLiveDataList.value = liveDataList;
          loadData.value = false;
        },
      );
    } catch (error) {
      loadData.value = false;
      print('Cache-Error : $error');
    }
  }

  Future<void> getCategoryItemData({
    required String id,
  }) async {
    loadCatData.value = true;
    categoryFirstItem.clear();
    try {
      await ApiHelper.apiHelper
          .getSubCategoryItem(
        id: id,
      )
          .then(
        (categoryData) {
          if(categoryData.data != null && categoryData.data!.isNotEmpty){
            categoryFirstItem.value = categoryData.data??[];
            loadCatData.value = false;
          }
        },
      );
    } catch (error) {
      loadCatData.value = false;
      print('Cache-Error : $error');
    }
  }

  Future<void> getRateData({
    required String categoryValue,
    required String subCategoryValue,
  }) async {
    loadData.value = true;
    txtSearch.clear();
    searchFocusNode.unfocus();
    searchStart.value = false;
    searchClick.value = false;
    try {
      await ApiHelper.apiHelper
          .getAllRatesDataList(
        categoryValue: categoryValue,
        subCategoryValue: subCategoryValue,
      )
          .then(
        (ratesDataList) {
          allRatesDataList.value = ratesDataList;
          loadData.value = false;
        },
      );
    } catch (error) {
      loadData.value = false;
      print('Cache-Error : $error');
    }
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
          loadData.value = false;
        },
      );
    } catch (error) {
      loadData.value = false;
      print('Cache-Error : $error');
    }
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
      print('Cache-Error : $error');
    }
  }

  Future<void> getCategoryData() async {
    try {
      await ApiHelper.apiHelper.getCategoryDataList().then(
        (categoryDataList) {
          allCategoryDataList.value = categoryDataList;
          print("SSSSSSSC ${allCategoryDataList.length}");
        },
      );
    } catch (error) {
      print('Cache-Error : $error');
    }
  }
}
