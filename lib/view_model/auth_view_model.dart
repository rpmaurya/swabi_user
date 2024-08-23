

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
        final userPreference = Provider.of<UserViewModel>(
            context, listen: false);
        print("save token");
        // userPreference.saveEmail(value['user']);
        print(value['data']['userId'].toString());
        String userID = value['data']['userId'].toString();
        String token1 = value['data']['token'].toString();
        userPreference.saveToken(UserModel(token: token1));
        userPreference.saveUserId(UserModel(userId: userID));
        print('userId: $userID');
        print('token: ${token1.toString()}');
        Utils.flushBarSuccessMessage("Login Successfully",context);
        context.go('/');
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.flushBarErrorMessage("Email and Password is not present!", context);
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }
  }
  // Future<void> loginApi(dynamic data, BuildContext context) async {
  //   setLoading(true);
  //   {
  //     _myRepo.loginApi(data).then((value) async {
  //       debugPrint(value);
  //       setLoading(false);
  //       final userPreference = Provider.of<UserViewModel>(
  //           context, listen: false);
  //       debugPrint("save token");
  //       // userPreference.saveEmail(value['user']);
  //       debugPrint(value['data']['userId'].toString());
  //       String userID = value['data']['userId'].toString();
  //       String token1 = value['data']['token'].toString();
  //       userPreference.saveToken(UserModel(token: token1));
  //       userPreference.saveUserId(UserModel(userId: userID));
  //       debugPrint('userId: $userID');
  //       debugPrint('token: ${token1.toString()}');
  //       Utils.toastMessage("Login Successfully",greenColor);
  //       context.go('/');
  //     }).onError((error, stackTrace) {
  //       setLoading(false);
  //       if(error.toString() == "Null check operator used on a null value")
  //        {
  //          Utils.flushBarErrorMessage(error.toString(), context,Colors.red);
  //          // Utils.flushBarErrorMessage("Please Enter Valid Email & Password", context,Colors.red);
  //        }
  //       if (kDebugMode) {
  //         print(error.toString());
  //       }
  //     });
  //   }
  // }


}
