import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/data/network/base_apiservices.dart';
import 'package:flutter_cab/data/network/network_apiservice.dart';
import 'package:flutter_cab/data/response/baseResponse.dart';
import 'package:flutter_cab/model/changepassword_model.dart';
import 'package:flutter_cab/model/commonModel.dart';
import 'package:flutter_cab/model/user_profile_model.dart';
import 'package:flutter_cab/view_model/services/httpService.dart';

///Rental View Single Detail Repo
class UserProfileRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> userProfileRepositoryApi(Map<String, String> data) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("http://swabi.ap-south-1.elasticbeanstalk.com"
              "/user/get_user_by_userId?userId=${data["userId"]}");
      // print("UserProfile Repo api success $data");
      return response = UserProfileModel.fromJson(response);
    } catch (e) {
      // print("UserProfile Repo api not success");
      // print(e);
      rethrow;
    }
  }
}

class ProfileImageRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> fetchProfileImageApi(data) async {
    try {
      /// for image
      dynamic response = await _apiServices.uploadImageHTTP2(
          "http://swabi.ap-south-1.elasticbeanstalk.com/"
          "user/upload_profile",
          data["image"],
          data['userId']);

      return response["data"]["body"];
    } catch (e) {
      if (kDebugMode) {
        // print("$e profile image field");
      }
      rethrow;
    }
  }
}

class UserProfileUpdateRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> userProfileUpdateRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponseWithData(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/user/update_user?userId=${data["userId"]}&firstName=${data["firstName"]}&lastName=${data["lastName"]}&address=${data["address"]}&gender=${data["gender"]}&mobile=${data["mobile"]}",
          data);
      // dynamic response = await _apiServices.getPutApiResponseWithData(AppUrl.userProfileUpdate, data);
      // print("UserProfile Update Repo api success $data");
      return response = UserProfileUpdateModel.fromJson(response);
    } catch (e) {
      // print("UserProfile Update Repo api not success");
      // print(e);
      rethrow;
    }
  }

  Future<ChangePasswordModel?> changePasswordApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.changepasswordUrl,
        methodType: HttpMethodType.PATCH,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = ChangePasswordModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<CommonModel?> sendOtpApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.sendOtpsUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<CommonModel?> verifyOtpApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.verifyOtpUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<CommonModel?> resetPasswordApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.resetPassordUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = CommonModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }
}
