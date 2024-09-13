import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/data/response/baseResponse.dart';
import 'package:flutter_cab/model/registration_model.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/services/httpService.dart';

import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';

class RegistrationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  // Future<dynamic> fetchRegistrationListApi(dynamic data) async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getPostWithoutApiResponse(AppUrl.signUp, data);
  //     print("signUP Response $response + $data");
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<SignUpModel?> fetchRegistrationListApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.signupUrl,
        body: body,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        isAuthorizeRequest: false);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print('response...$response');
      var resp = SignUpModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      // ignore: use_build_context_synchronously
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}
