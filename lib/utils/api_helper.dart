
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' as getX;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kmr_flutter_application/Models/about_us_model.dart';
import 'package:kmr_flutter_application/Models/notification_model.dart';

import '../Controllers/home_controller.dart';
import '../Models/category_data_model.dart';
import '../Models/live_data_model.dart';
import '../Models/news_data_model.dart';
import '../Models/sub_category_model.dart';
import '../Models/vendor_rate_data_model.dart';
import '../Models/vendor_spot_rate_data_model.dart';
import '../Models/user_model.dart';
import 'api.dart';
import '../Models/category_item_model.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();
  API api = API();
  String authorizationToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmIyNGYwOTc5YTRkYmYxMWJmMmRhNzNhNGYwYjAwNWVjZDQwNzZhMDIzMDNlZjVjYWY1YmIwYzE3NzdiZDQ1OWU1MDQ5MWE0MTkzZWY3YzEiLCJpYXQiOjE3MTU1NzkwNzIuNzQzNjk5MDczNzkxNTAzOTA2MjUsIm5iZiI6MTcxNTU3OTA3Mi43NDM3MDE5MzQ4MTQ0NTMxMjUsImV4cCI6MTc0NzExNTA3Mi43MzA1ODI5NTI0OTkzODk2NDg0Mzc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.PKcii6hvnpbaeY7LMT4upRaQTpdyuq1Z4OetjKPbh9wXct0e8EYN_cekpADpBVC6TZDXgZUDNNGtAwgCoPQNUCRkbJblp2QctbSVh-g6DN-l4JTINPvPAE5LDlQXRxRDwXFwB2QIiWUyMDj69wrPfVaHaE3rUMH3bM6QT6a5WuOta4jd6eOOqUnobTgRrC0Cuqwe1SAymbia5yPQtSudoO1FvK7r2rA_fzjyrEZdNu82LmcaTRjv9NiFroQLS-dhxL0rUOh3jLuRcycNB6nOBx33X-_UGV8R6ShpBsSgNG6itwmesX5rVUWBQzSSHSfUNMZbwf5uQOidpvUUewdSypednscnmPRKs8uCWUWiUabKWHAJ56ndIMSjXqZhOzNJfEcuQhWyKJ_ZEklJGGvVYs49Pq2FJuIHWqAwVL_KhZd2iDWM8qZ0pFyFyLr6QDB37q_h818UJi3v6XsIsr7B5IJpQq1AdQnOZ9Up60I-9o2i-HXJxo8EDVOXmunslS-wnh4UCUm-mjTjAm8y7pMQ2Q99-0Z5vOtrc5-4cJHKUQBHW0s44qPjVPgyPW6cwjBRN1c_7wl1oSUOVR4hNBafnxtWlqNc8UkakGaWJKtE7FAgISRQ-jt8KudKSsd55uR6YPnROV2duuI2glrz_rZQXZoe6agkMwpwUBobV_SnmGE';

  void getAuthorizationToken() {
    HomeController homeController = getX.Get.put(HomeController());
    homeController.getUserData();
    authorizationToken = homeController.userDataWithToken.value.token ?? '';
    log('Token : $authorizationToken');
  }

  Future<Map> checkMobileNumber({
    required String mobileNo,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'mobile': mobileNo,
      });
      Response response = await api.dio.post(
        'check-mobile',
        data: data,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint("login response ::::::::::::::::::: $data");
        return data;
      } else {
        return {};
      }
    } catch (error) {
      debugPrint('Error :$error');
      return {};
    }
  }

  Future<Map> loginUser({
    required String mobileNo,
    required String password,
    required String deviceId,
  }) async {

      getAuthorizationToken();
      var data = FormData.fromMap({
        'mobile': mobileNo,
        'password': password,
        'device_id': deviceId,
      });
      debugPrint({
        'mobile': mobileNo,
        'password': password,
        'device_id': deviceId,
      }.toString());
      Response response = await api.dio.post(
        'login',
        data: data,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      } else {
        return {};
      }

  }  Future signUpUser({
    required String mobileNo,
    required String name,
    required String email,
    required String city,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'name': name ,
        'mobile': mobileNo,
        'email': email,
        'city': city,
      });
      debugPrint({
        'name': name ,
        'mobile': mobileNo,
        'email': email,
        'city': city,
      }.toString());
      Response response = await api.dio.post(
        'panel-create-vendor-user-signup',
        data: data,
      );
      var body = response.data;
      debugPrint(body);
      if (response.statusCode == 200) {
        return body;
      } else {
        return body;
      }
    } catch (error) {
      return {};
    }
  }

  Future<Map> postFeedBackApi({
    required String sub,
    required String des,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'feedback_subject': sub,
        'feedback_description': des
      });
      debugPrint({
        'feedback_subject': sub,
        'feedback_description': des
      }.toString());
      var headers = {'Authorization': 'Bearer $authorizationToken'};

      Response response = await api.dio.post(
        'create-feedback',
        data: data,
          options: Options(
            headers: headers,
          ),);
      if (response.statusCode == 200) {
        var data = response.data;
        return data;
      } else {
        return {};
      }
    } catch (error) {
      return {};
    }
  }

  Future<LiveDataListModel> getAllLiveDataList({
    required String categoryValue,
    required String? subCategoryValue,
  }) async {

      getAuthorizationToken();
      var data = FormData.fromMap({
        'c_value': categoryValue,
        'c_sub_value': subCategoryValue,
      });
      debugPrint({
        'c_value': categoryValue,
        'c_sub_value': subCategoryValue,
      }.toString());

      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-live',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('Success: $data');
        return LiveDataListModel.fromJson(data)
                ;
      } else {
        return LiveDataListModel();
      }

  }

  Future<CategoryItemModel> getSubCategoryItem({
    required String id,
  }) async {
    try {
      debugPrint(id);
      getAuthorizationToken();
      var data = FormData.fromMap({
        'id': id,
      });

      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-live-history',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('getSubCategoryItem $data');
        return  CategoryItemModel.fromJson(data);
      } else {
        return CategoryItemModel();
      }
    } catch (error) {
      debugPrint('Error $error');
      return CategoryItemModel();
    }
  }

  Future<VendorRateModel> getAllRatesDataList({
    required String categoryValue,
    required String? subCategoryValue,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'c_value': categoryValue,
        'c_sub_value': subCategoryValue,
      });
   debugPrint({
     'c_value': categoryValue,
     'c_sub_value': subCategoryValue,
   }.toString());
      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-rates',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        log('Success: $data');
        return VendorRateModel.fromJson(data);
      } else {
        return VendorRateModel();
      }
    } catch (error) {
      debugPrint('Error $error');
      return VendorRateModel();
    }
  }

  Future<List<VendorSpotRateDataModel>> getAllSpotDataList({
    required String categoryValue,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'c_value': categoryValue,
      });

      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-spot-rates',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('Success: $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => VendorSpotRateDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error $error');
      return [];
    }
  }

  Future<List<NewsDataModel>> getAllNewsDataList() async {
    try {
      getAuthorizationToken();
      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-news',
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('Success: $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => NewsDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error $error');
      return [];
    }
  }

  Future<List<CategoryDataModel>> getCategoryDataList() async {
    try {
      getAuthorizationToken();
      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-category',
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('Success: $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => CategoryDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error $error');
      return [];
    }
  }

  Future<List<SubCategoryDataModel>> getCategoryIdWiseSubCategoryDataList(
      {required String categoryId,
      required int index
      }) async {
    try {
      getAuthorizationToken();
     debugPrint(categoryId);
      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();
     var path = index ==0?'fetch-live-sub-category':index ==1?"fetch-rates-sub-category":"fetch-spot-rates-sub-category";
      Response response = await api.dio.post(/*'fetch-sub-category'*/path,
          data: {'c_value': categoryId},
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('Success: $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => SubCategoryDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error $error');
      return [];
    }
  }

  Future<List<NewsDataModel>> getAllSliderDataList() async {
    try {
      getAuthorizationToken();
      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-news',
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('Success: $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
            .map((e) => NewsDataModel.fromJson(e))
            .toList());
      } else {
        return [];
      }
    } catch (error) {
      debugPrint('Error $error');
      return [];
    }
  }

  Future<UserModel> fetchUserApiUrl({
    required RxBool loading,
  }) async {
    UserModel userModel = UserModel();
    try {
      getAuthorizationToken();
      var headers = {'Authorization': 'Bearer $authorizationToken'};
      loading.value = true;
      Response response = await api.dio.post('fetch-profile',
          options: Options(
            headers: headers,
          ));

      debugPrint("fetchUserApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchUserApiUrl response:- ${response.data}");

          userModel = userModelFromJson(jsonEncode(response.data));
          loading.value = false;

      } else {
        loading.value = false;
      }
    } catch (error) {        loading.value = false;

    debugPrint(error.toString());
      return userModel;
    }
    return userModel;
  }

  Future<AboutUsModel> fetchAboutUsApiUrl({
    required RxBool loading,
  }) async {
    AboutUsModel aboutUsModel = AboutUsModel();
    try {
      getAuthorizationToken();
      var headers = {'Authorization': 'Bearer $authorizationToken'};
      loading.value = true;
      Response response = await api.dio.post('fetch-aboutus',
          options: Options(
            headers: headers,
          ));

      debugPrint("fetchAboutUsApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchAboutUsApiUrl response:- ${response.data}");

        aboutUsModel = aboutUsModelFromJson(jsonEncode(response.data));
          loading.value = false;

      } else {
        loading.value = false;
      }
    } catch (error) {        loading.value = false;

    debugPrint(error.toString());
      return aboutUsModel;
    }
    return aboutUsModel;
  }

  Future<List<NotificationData>> fetchNotificationApiUrl({
    required RxBool loading,
  }) async {
    try {
      getAuthorizationToken();
      var headers = {'Authorization': 'Bearer $authorizationToken'};
      loading.value = true;

      final response = await api.dio.post(
        'fetch-notification',
        options: Options(headers: headers),
      );

      debugPrint("fetchNotificationApiUrl statusCode: ${response.statusCode}");
      debugPrint("fetchNotificationApiUrl response: ${response.data}");

      if (response.statusCode == 200) {
        return notificationModelFromJson(jsonEncode(response.data)).data ?? [];
      }
    } catch (error) {
      debugPrint("Error fetching notifications: $error");
    } finally {
      loading.value = false;
    }

    return [];
  }

  // Future<List<NotificationData>> fetchNotificationApiUrl({
  //   required RxBool loading,
  // }) async {
  //   try {
  //     getAuthorizationToken();
  //     var headers = {'Authorization': 'Bearer $authorizationToken'};
  //     loading.value = true;
  //     Response response = await api.dio.post('fetch-notification',
  //         options: Options(
  //           headers: headers,
  //         ));
  //
  //     debugPrint("fetchNotificationApiUrl statusCode:- ${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       debugPrint("fetchNotificationApiUrl response:- ${response.data}");
  //       loading.value = false;
  //
  //       return notificationModelFromJson(jsonEncode(response.data)).data??[];
  //
  //     } else {
  //       loading.value = false;
  //     }
  //   } catch (error) {
  //     loading.value = false;
  //
  //     debugPrint(error.toString());
  //     return [];
  //   }
  //   return [];
  // }

  Future postDeleteProfileApi() async {
    try {
      var headers = {
        'Authorization': 'Bearer $authorizationToken',
      };
      Response response = await api.dio.post(
        'delete-profile',
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint(data.toString());
        debugPrint('Success: ${data.runtimeType} ${data['data'].runtimeType}');

        return data;
      } else {
        return {};
      }
    } catch (error) {
      debugPrint(error.toString());
      return {};
    }
  }
}
