import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cab/data/app_url.dart';
import 'package:flutter_cab/model/user_model.dart';
import 'package:flutter_cab/view_model/services/http_service.dart';
import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';

class UserRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  //user registration
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostWithoutApiResponse(AppUrl.login, data);
      debugPrint("registration api success $data");
      return response;
    } catch (e) {
      debugPrint("registration api not successful error");
      print(e);
      rethrow;
    }
  }

  Future<UserLoginModel?> userloginApi(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.loginUrl,
        methodType: HttpMethodType.POST,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({"passord change response": response?.data});
      var resp = UserLoginModel.fromJson(response?.data);
      return resp;
    } catch (error) {
      print({'error..': error});
      http.handleErrorResponse(context: context, error: error);
      rethrow;
    }
  }
}
