import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/app_excaptions.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/model/GetIssueModel.dart';
import 'package:flutter_cab/model/IssueDetailModel.dart';
import 'package:flutter_cab/model/RaiseIssueModel.dart';
import 'package:flutter_cab/view_model/services/httpService.dart';

class RaiseissueRepository {
  Future<RaiseIssueModel?> requestRaiseIssueApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.raiseIssueUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of raise issue request${response?.data}');
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = RaiseIssueModel.fromJson(response.data);
        return resp;
      } else {
        throw ApiException('Server returned an error: ${response?.statusCode}');
      }
    } catch (dioError) {
      http.handleErrorResponse(context: context, error: dioError);
    }
    return null;
  }

  Future<GetIssueModel?> getRaiseIssueApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getIssueUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of get raise issue${response?.data}');
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = GetIssueModel.fromJson(response.data);
        return resp;
      } else {
        throw ApiException('Server returned an error: ${response?.statusCode}');
      }
    } catch (dioError) {
      http.handleErrorResponse(context: context, error: dioError);
    }
    return null;
  }

  Future<IssueDetailsModel?> getRaiseIssueDetailsApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.getIssueDetailsUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      debugPrint('respone of get raise issue${response?.data}');
      if (response?.statusCode != null &&
          response!.statusCode! >= 200 &&
          response.statusCode! < 300) {
        var resp = IssueDetailsModel.fromJson(response.data);
        return resp;
      } else {
        throw ApiException('Server returned an error: ${response?.statusCode}');
      }
    } catch (dioError) {
      http.handleErrorResponse(context: context, error: dioError);
      //   if (dioError.type == DioExceptionType.connectionTimeout ||
      //       dioError.type == DioExceptionType.receiveTimeout) {
      //     throw TimeoutException('Connection TimeOut');
      //   } else if (dioError.type == DioExceptionType.connectionError) {
      //     throw NetworkException('Internet Connection error');
      //   } else if (dioError.response != null) {
      //     throw ApiException(
      //         'Server responded with an error: ${dioError.response?.data}');
      //   } else {
      //     throw UnknownException('Unknown error occurred');
      //   }
      // } catch (e) {
      //   throw UnknownException('An unexpected error occurred: $e');
    }
    return null;
  }
}
