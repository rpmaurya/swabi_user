import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/data/response/baseResponse.dart';
import 'package:flutter_cab/model/paymentDetailsModel.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/view_model/services/httpService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';

class RentalRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> rentalRepositoryApi(Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'rental/rental_car_price?date=${data["date"]}&pickupTime=${data["pickupTime"]}&seat=${data["seat"]}&hours=${data["hours"]}&kilometers=${data["kilometers"]}&pickUpLocation=${data["pickUpLocation"]}&longitude=${data["longitude"]}&latitude=${data["latitude"]}');
      // print("rental api success");
      return response = RentalCarListStatusModel.fromJson(response);
    } catch (e) {
      // print("rental api not successful error");
      // print(e);
      rethrow;
    }
  }
}

///Rental Booking Repo
class RentalBookingRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<RentalCarBookingModel?> rentalBookingApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var prefsToken = await SharedPreferences.getInstance();
    dynamic token = prefsToken.getString('token');
    Map<String, String> headerData = {
      "Content-Type": "application/json",
      "token": token,
    };
    var http = HttpService(
        isAuthorizeRequest: false,
        headers: headerData,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.rentalCarBookingUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print("rentalBooking Repo api success${response?.data}");
      var resp = RentalCarBookingModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // BaseResponseModel baseResponseModel =
      //     BaseResponseModel.fromJson(error.response?.data);
      // print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
    }
    return null;
  }

  Future<dynamic> rentalBookingRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'rental/booking_v2',
          data);
      // dynamic response = await _apiServices.getPostApiResponse(
      //     'http://swabi.ap-south-1.elasticbeanstalk.com/'
      //     'rental/booking_v2?date=${data["date"]}&pickupTime=${data["pickupTime"]}&bookerId=${data["bookerId"]}&bookingForId=${data["bookingForId"]}&carType=${data["carType"]}&kilometers=${data["kilometers"]}&hours=${data["hours"]}&price=${data["price"]}&pickUpLocation=${data["pickUpLocation"]}&locationLatitude=${data["locationLatitude"]}&locationLongitude=${data["locationLongitude"]}&guestName=${data["guestName"]}&guestMobile=${data["guestMobile"]}&gender=${data["gender"]}',
      //     data);
      print("rentalBooking Repo api success $response");
      return response = RentalCarBookingModel.fromJson(response);
    } catch (e) {
      print("rentalBooking Repo api not successful error");
      // print(e);
      rethrow;
    }
  }
}
// ///Rental Booking Repo
// class RentalBookingRepository {
//   final BaseApiServices _apiServices = NetworkApiService();
//
//   Future<dynamic> rentalBookingRepositoryApi(data) async {
//     try {
//       dynamic response = await _apiServices.getPostApiResponse(
//           'http://swabi.ap-south-1.elasticbeanstalk.com/'
//               'rental/booking?date=${data["date"]}&pickupTime=${data["pickupTime"]}&userId=${data["userId"]}&carType=${data["carType"]}&kilometers=${data["kilometers"]}&hours=${data["hours"]}&price=${data["price"]}&pickUpLocation=${data["pickUpLocation"]}',
//           data);
//       print("rentalBooking Repo api success");
//       return response = RentalCarBookingModel.fromJson(response);
//     } catch (e) {
//       print("rentalBooking Repo api not successful error");
//       print(e);
//       rethrow;
//     }
//   }
// }

///Rental Booking Cancel Repo
class RentalBookingCancelRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> rentalBookingCancelRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'rental/cancel_rental_booking?id=${data["id"]}&reason=${data["reason"]}&cancelledBy=${data["cancelledBy"]}');
      // print("rentalBooking cancel Repo api success");
      return response = RentalCarBookingCancelModel.fromJson(response);
    } catch (e) {
      // print("rentalBooking cancel Repo api not successful error");
      // print(e);
      rethrow;
    }
  }
}

///Rental Booking List Repo
class RentalBookingListRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> rentalBookingListRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'rental/get_rental_booking_by_userId?userId=${data["userId"]}&pageNumber=${data["pageNumber"]}&pageSize=${data["pageSize"]}&bookingStatus=${data["bookingStatus"]}');
      // print("rentalBooking Repo api success");
      return response = RentalCarBookingListModel.fromJson(response);
    } catch (e) {
      // print("rentalBooking Repo api not successful error");
      print(e);
      rethrow;
    }
  }
}

///Rental View Single Detail Repo
class RentalViewDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> rentalViewDetailsRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse("http://swabi.ap-south-1.elasticbeanstalk.com"
              "/rental/get_rental_booking_by_id?id=${data["id"]}");
      print("rental View Detail Repo api success");
      return response = RentalDetailsSingleModel.fromJson(response);
    } catch (e) {
      print("rental View Detail api not successful error");
      print(e);
      rethrow;
    }
  }
}

///Rental View Single payment Detail Repo
class RentalViewPaymentDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<PaymentDetailsModel?> paymentDetailsApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.paymentDetailUrl,
        queryParameters: query,
        bodyType: HttpBodyType.JSON,
        methodType: HttpMethodType.GET,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print('response..${response?.data}');
      var resp = PaymentDetailsModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // BaseResponseModel baseResponseModel =
      //     BaseResponseModel.fromJson(error.response?.data);
      // print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
        context: context,
        error: error,
      );
    }

    return null;
  }
}

///Rental Validation  Repo
class RentalValidationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> rentalValidationRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "http://swabi.ap-south-1.elasticbeanstalk.com"
          "/rental/check_rental_booking_by_date?date=${data["date"]}&userId=${data["userId"]}");
      print("rental Validation Repo Success");
      return response = RentalCarBookingValidationModel.fromJson(response);
    } catch (e) {
      print("rental Validation Repo Field");
      print(e);
      rethrow;
    }
  }
}

///Get Rental Range List  Repo
class GetRentalRangeListRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getRentalRangeListRepositoryApi(data) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.rentalRangeList);
      return response = GetRentalRangeListModel.fromJson(response);
    } catch (e) {
      print("rental Validation Repo Field");
      print(e);
      rethrow;
    }
  }
}
