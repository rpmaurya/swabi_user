import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../respository/user.dart';
import '/model/user_model.dart';
import '/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = UserRepository();
  late bool setupFinish = false;

  bool check = true;
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    {
      _myRepo.loginApi(data).then((value) async {
        // print(value);
        setLoading(false);
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        print("save token");
        // userPreference.saveEmail(value['user']);
        print(value['data']['userId'].toString());
        String userID = value['data']['userId'].toString();
        String token1 = value['data']['token'].toString();
        userPreference.saveToken(UserModel(token: token1));
        userPreference.saveUserId(UserModel(userId: userID));
        print('userId: $userID');
        print('token: ${token1.toString()}');
        Utils.toastSuccessMessage("Login Successfully");
        context.go('/');
      }).onError((error, stackTrace) {
        setLoading(false);
        FocusScope.of(context).unfocus();
        Utils.toastMessage(
          "Email and Password is not present!",
        );
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }
  }

  Future<void> userLoginApi(
      {required BuildContext context,
      required String email,
      required String password,
      required bool rememberMe}) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
      'userType': 'USER'
    };
    try {
      setLoading(true);
      _myRepo.userloginApi(context: context, body: body).then((value) {
        if (value?.status?.httpCode == '200') {
          final userPreference =
              Provider.of<UserViewModel>(context, listen: false);
          print("save token");
          // userPreference.saveEmail(value['user']);
          print('login');

          userPreference.saveToken(UserModel(token: value?.data?.token));
          userPreference
              .saveUserId(UserModel(userId: value?.data?.userId.toString()));
          rememberMe
              ? userPreference.saveRememberMe(email, password, rememberMe)
              : userPreference.clearRememberMe();
          print('token: ${value?.data?.token}');
          print('user: ${value?.data?.userId.toString()}');
          Utils.toastSuccessMessage("Login Successfully");
          context.go('/');
          setLoading(false);
        }
      }).onError((error, stackTrace) {
        FocusScope.of(context).unfocus();

        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      debugPrint('error $e');
    }
  }
}
