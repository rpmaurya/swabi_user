import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/data/network/base_apiservices.dart';
import 'package:flutter_cab/data/network/network_apiservice.dart';
import 'package:flutter_cab/model/getTrasactionByIdModel.dart';
import 'package:flutter_cab/model/paymentGetWay_model.dart';
import 'package:flutter_cab/model/payment_refund_model.dart';
import 'package:flutter_cab/view_model/services/httpService.dart';

///Payment Create OrderID Repo
class PaymentCreateOrderIDRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<PaymentCreateOderIdModel?> paymentCreateOrderIdApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.createPaymentOrder,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        // queryParameters: query,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"CreatePaymentOrderresponse": response?.data});
      var resp = PaymentCreateOderIdModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // BaseResponseModel baseResponseModel =
      //     BaseResponseModel.fromJson(error.response?.data);
      // print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }

  Future<dynamic> paymentCreateOrderIDRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'payment/create_order?amount=${data["amount"]}&userId=${data["userId"]}',
          data);
      print("paymentCreateOrderID Repo api success");
      return response = PaymentCreateOderIdModel.fromJson(response);
    } catch (e) {
      print("paymentCreateOrderID Repo api not successful error");
      print(e);
      rethrow;
    }
  }
}

///Payment Verify Repo
class PaymentVerifyRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<PaymentVerifyModel?> paymentVerifyApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.verifyPayment,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"paymentVerifyresponse": response?.data});
      var resp = PaymentVerifyModel.fromJson(response?.data);
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

  Future<dynamic> paymentVerifyRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'payment/verify_payment',
          data);
      print("PaymentVerify Repo api success");
      return response = PaymentVerifyModel.fromJson(response);
    } catch (e) {
      print("PaymentVerify Repo api not successful error");
      print(e);
      rethrow;
    }
  }
}

class PaymentTrasactionRespository {
  Future<GetTransactionByIdModel?> getTrasactionByIdApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getTransactionByIdUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"GetTrasactionresponse": response?.data});
      var resp = GetTransactionByIdModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }

  Future<GetTransactionByIdModel?> getRefundTrasactionByIdApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getRefundTransactionByIdUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint("GetTrasactionresponse ${response?.data}");
      var resp = GetTransactionByIdModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}

class PaymentRefundRespository {
  Future<PaymentRefundModel?> getRefundPaymentApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getRefundPaymentUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"Get Refunde details....": response?.data});
      var resp = PaymentRefundModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      // http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}
