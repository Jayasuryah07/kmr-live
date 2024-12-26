
import 'package:dio/dio.dart';

import 'package:get/get.dart' as getX;

import '../Controllers/HomeController.dart';
import '../Models/CategoryDataModel.dart';
import '../Models/LiveDataModel.dart';
import '../Models/NewsDataModel.dart';
import '../Models/SubCategoryModel.dart';
import '../Models/VendorRateDataModel.dart';
import '../Models/VendorSpotRateDataModel.dart';
import 'API.dart';
import '../Models/CategoryItemModel.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();
  API api = API();
  String authorizationToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmIyNGYwOTc5YTRkYmYxMWJmMmRhNzNhNGYwYjAwNWVjZDQwNzZhMDIzMDNlZjVjYWY1YmIwYzE3NzdiZDQ1OWU1MDQ5MWE0MTkzZWY3YzEiLCJpYXQiOjE3MTU1NzkwNzIuNzQzNjk5MDczNzkxNTAzOTA2MjUsIm5iZiI6MTcxNTU3OTA3Mi43NDM3MDE5MzQ4MTQ0NTMxMjUsImV4cCI6MTc0NzExNTA3Mi43MzA1ODI5NTI0OTkzODk2NDg0Mzc1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.PKcii6hvnpbaeY7LMT4upRaQTpdyuq1Z4OetjKPbh9wXct0e8EYN_cekpADpBVC6TZDXgZUDNNGtAwgCoPQNUCRkbJblp2QctbSVh-g6DN-l4JTINPvPAE5LDlQXRxRDwXFwB2QIiWUyMDj69wrPfVaHaE3rUMH3bM6QT6a5WuOta4jd6eOOqUnobTgRrC0Cuqwe1SAymbia5yPQtSudoO1FvK7r2rA_fzjyrEZdNu82LmcaTRjv9NiFroQLS-dhxL0rUOh3jLuRcycNB6nOBx33X-_UGV8R6ShpBsSgNG6itwmesX5rVUWBQzSSHSfUNMZbwf5uQOidpvUUewdSypednscnmPRKs8uCWUWiUabKWHAJ56ndIMSjXqZhOzNJfEcuQhWyKJ_ZEklJGGvVYs49Pq2FJuIHWqAwVL_KhZd2iDWM8qZ0pFyFyLr6QDB37q_h818UJi3v6XsIsr7B5IJpQq1AdQnOZ9Up60I-9o2i-HXJxo8EDVOXmunslS-wnh4UCUm-mjTjAm8y7pMQ2Q99-0Z5vOtrc5-4cJHKUQBHW0s44qPjVPgyPW6cwjBRN1c_7wl1oSUOVR4hNBafnxtWlqNc8UkakGaWJKtE7FAgISRQ-jt8KudKSsd55uR6YPnROV2duuI2glrz_rZQXZoe6agkMwpwUBobV_SnmGE';

  void getAuthorizationToken() {
    HomeController homeController = getX.Get.put(HomeController());
    authorizationToken = homeController.userDataWithToken.value.token ?? '';
    print('Token : $authorizationToken');
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
        return data;
      } else {
        return {};
      }
    } catch (error) {
      print('Error :$error');
      return {};
    }
  }

  Future<Map> loginUser({
    required String mobileNo,
    required String password,
    required String deviceId,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'mobile': mobileNo,
        'password': password,
        'device_id': deviceId,
      });
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
    } catch (error) {
      return {};
    }
  }

  Future<List<LiveDataModel>> getAllLiveDataList({
    required String categoryValue,
    required String subCategoryValue,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'c_value': categoryValue,
        'c_sub_value': subCategoryValue,
      });

      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-live',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => LiveDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
      return [];
    }
  }

  Future<CategoryItemModel> getSubCategoryItem({
    required String id,
  }) async {
    try {
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
        print('getSubCategoryItem $data');
        return  CategoryItemModel.fromJson(data);
      } else {
        return CategoryItemModel();
      }
    } catch (error) {
      print('Error $error');
      return CategoryItemModel();
    }
  }

  Future<List<VendorRateDataModel>> getAllRatesDataList({
    required String categoryValue,
    required String subCategoryValue,
  }) async {
    try {
      getAuthorizationToken();
      var data = FormData.fromMap({
        'c_value': categoryValue,
        'c_sub_value': subCategoryValue,
      });

      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-rates',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => VendorRateDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
      return [];
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
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => VendorSpotRateDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
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
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => NewsDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
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
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => CategoryDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
      return [];
    }
  }

  Future<List<SubCategoryDataModel>> getCategoryIdWiseSubCategoryDataList(
      {required String categoryId}) async {
    try {
      getAuthorizationToken();

      var data = FormData.fromMap({
        'c_id': categoryId,
      });

      var headers = {'Authorization': 'Bearer $authorizationToken'};

      // Dio dio = Dio();

      Response response = await api.dio.post('fetch-sub-category',
          data: data,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        var data = response.data;
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
                .map((e) => SubCategoryDataModel.fromJson(e))
                .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
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
        print('aadadada $data');
        return List.from(data == null
            ? []
            : (data['data'] ?? [])
            .map((e) => NewsDataModel.fromJson(e))
            .toList());
      } else {
        return [];
      }
    } catch (error) {
      print('Error $error');
      return [];
    }
  }
}
