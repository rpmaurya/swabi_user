import 'package:flutter/cupertino.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/registration_model.dart';
import 'package:flutter_cab/respository/registration_repository.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:go_router/go_router.dart';

class PostSignUpViewModel with ChangeNotifier {
  final _myRepo = RegistrationRepository();
  bool _loading = false;
  bool get loading => _loading;
  ApiResponse<SignUpModel> DataList = ApiResponse.loading();
  setDataList(ApiResponse<SignUpModel> response) {
    DataList = response;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<SignUpModel?> fetchPostSingUp(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    try {
      setLoading(true);
      setDataList(ApiResponse.loading());
      _myRepo
          .fetchRegistrationListApi(context: context, body: body)
          .then((onValue) {
        if (onValue?.status.httpCode == '200') {
          setLoading(false);
          setDataList(ApiResponse.completed(onValue));
          // print("Signup Success");
          Utils.flushBarSuccessMessage("SignUp Successfully", context);
          context.push("/login");
        }
      }).onError((error, stactrace) {
        setLoading(false);
        setDataList(ApiResponse.error(error.toString()));
      });
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrr$e');
      setLoading(false);
      setDataList(ApiResponse.error(e.toString()));
    }
    return null;
  }
  // Future fetchPostSingUp(data, BuildContext context) async {
  //   setDataList(ApiResponse.loading());
  //   _myRepo
  //       .fetchRegistrationListApi(context: context, body: data)
  //       .then((value) {
  //     setDataList(ApiResponse.completed(value));
  //     // print("Signup Success");
  //     Utils.flushBarSuccessMessage("SignUp Successfully", context);
  //     context.push("/login");
  //   }).onError((error, stackTrace) {
  //     setDataList(ApiResponse.error(error.toString()));
  //     // if(error.toString())
  //     Utils.flushBarSuccessMessage("SignUp Successfully field", context);
  //     print(error.toString());
  //   });
  // }
}
