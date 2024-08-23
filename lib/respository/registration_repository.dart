import 'package:flutter_cab/data/app_url.dart';

import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';

class RegistrationRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> fetchRegistrationListApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostWithoutApiResponse(AppUrl.signUp, data);
      print("signUP Response $response + $data");
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
