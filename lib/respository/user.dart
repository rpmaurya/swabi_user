import 'package:flutter/cupertino.dart';
import 'package:flutter_cab/data/app_url.dart';
import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';
class UserRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  //user registration
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostWithoutApiResponse(AppUrl.login, data);
      debugPrint("registration api success $data");
      return response;
    } catch (e) {
      debugPrint("registration api not successful error");
      print(e);
      rethrow;
    }
  }
}
