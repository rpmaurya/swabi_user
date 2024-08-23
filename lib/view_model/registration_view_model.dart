

import 'package:flutter/cupertino.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/registration_model.dart';
import 'package:flutter_cab/respository/registration_repository.dart';
import 'package:flutter_cab/utils/utils.dart';

class PostSignUpViewModel with ChangeNotifier {
  final _myRepo = RegistrationRepository();
  ApiResponse<SignUpModel> DataList = ApiResponse.loading();
  setDataList(ApiResponse<SignUpModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future fetchPostSingUp(data, BuildContext context) async {
    setDataList(ApiResponse.loading());
    _myRepo.fetchRegistrationListApi(data).then((value) {
      setDataList(ApiResponse.completed(value));
      // print("Signup Success");
      Utils.flushBarSuccessMessage("SignUp Successfully",context);
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      // if(error.toString())
        Utils.flushBarSuccessMessage("SignUp Successfully field",context);
        // print(error.toString());

    });
  }
}