import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/data/network/base_apiservices.dart';
import 'package:flutter_cab/data/network/network_apiservice.dart';
import 'package:flutter_cab/data/response/baseResponse.dart';
import 'package:flutter_cab/model/changeMobileModel.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/services/httpService.dart';

///Get Package List Repo
class GetPackageListRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getPackageListRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices.getGetApiResponse(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package/get_package_list?pageNumber=${data["pageNumber"]}&pageSize=${data["pageSize"]}&packageStatus=${data["packageStatus"]}&search=${data["search"]}&date=${data["date"]}"
          // "/package/get_package_list?pageNumber=${data["pageNumber"]}&"
          //     "pageSize=${data["pageSize"]}&packageStatus=${data["packageStatus"]}"
          // "&search=${data["search"]}&date=${data["date"]}"
          );
      print("Get Package List Repo Success");
      return response = GetPackageListModel.fromJson(response);
    } catch (e) {
      print("Get Package List Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Get Package Activity By Id Repo
class GetPackageActivityByIdRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getPackageActivityByIdRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices
          .getGetApiResponse("http://swabi.ap-south-1.elasticbeanstalk.com"
              "/package/get_package_by_id?packageId=${data["packageId"]}");
      print("Get Package Activity By Id Repo Success");
      return response = GetPackageDetailsByIdModel.fromJson(response);
    } catch (e) {
      print("Get Package Activity By Id Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Post Package Booking By Id Repo
class GetPackageBookedByIdRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getPackageBookedByIdRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices.getPostApiResponse(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package_booking/book_package",
          data);
      print("Get Package Booked By Id Repo Success");
      // return response = BookPackageByMemberModel.fromJson(response);
    } catch (e) {
      print("Get Package Booked By Id Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Get Package History By Id Repo
class GetPackageHistoryRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getPackageHistoryRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package_booking/get_package_booking_by_userId?userId=${data["userId"]}&bookingStatus=${data["bookingStatus"]}&pageNumber=${data["pageNumber"]}&pageSize=${data["pageSize"]}");
      print("Get Package History Repo Success$response");
      return response = GetPackageHistoryModel.fromJson(response);
    } catch (e) {
      print("Get Package History Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Get Package History Details By Id Repo
class GetPackageHistoryDetailByIdRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<GetPackageHIstoryDetailsModel?>
      getPackageHistoryDetailByIdRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices.getGetApiResponse(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package_booking/get_package_booking_by_id?packageBookingId=${data["packageBookingId"]}");
      print("Get Package History Detail By Id Repo Success");
      var resp = GetPackageHIstoryDetailsModel.fromJson(response);
      return resp;
    } catch (e) {
      print("Get Package History Detail By Id Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Package Cancel Repo
class PackageCancelRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> packageCancelRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices.patchApiResponseWithData(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package_booking/cancel_package_booking?packageBookingId=${data["packageBookingId"]}&cancellationReason=${data["cancellationReason"]}&cancelledBy=${data["cancelledBy"]}",
          data);
      print("Package Cancel Repo Success");
      return response = PackageCancelModel.fromJson(response);
    } catch (e) {
      print("Package Cancel Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Add PickUp Location Repo
class AddPickUpLocationPackageRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> addPickUpLocationPackageRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices.patchApiResponseWithData(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package_booking/add_pickup_location?packageBookingId=${data["packageBookingId"]}&pickupLocation=${data["pickupLocation"]}",
          data);
      print("Add PickUp Location Package Repo Success");
      return response;
      // return response = AddPickUpLocationModel.fromJson(response);
    } catch (e) {
      print("Add PickUp Location Package Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Get Package Itinerary Repo
class GetPackageItineraryRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getPackageItineraryRepositoryApi(data) async {
    try {
      // dynamic response = await _apiServices.getGetApiResponse(AppUrl.getPackageList);
      dynamic response = await _apiServices.getGetApiResponse(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/package_booking/get_itinerary_by_package_booking_id?packageBookingId=${data["packageBookingId"]}");
      print("GetPackageItinerary Repo Success");
      // return response;
      return response = GetPackageItineraryModel.fromJson(response);
    } on DioException catch (e) {
      print("GetPackageItinerary Repo Field");
      print(e.response?.data);
      rethrow;
    }
  }
}

///Get Package Itinerary Repo
class ChangeMobileRepository {
  Future<ChangeMobileModel?> changeMobile(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.changeMobileUrl,
        body: body,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print('response...$response');
      var resp = ChangeMobileModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // BaseResponseModel baseResponseModel =
      //     BaseResponseModel.fromJson(error.response?.data);
      // print(baseResponseModel.status?.message);
      // Utils.flushBarErrorMessage(
      //     baseResponseModel.status?.message ?? '', context);
      // throw error.response?.data;
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }
}
