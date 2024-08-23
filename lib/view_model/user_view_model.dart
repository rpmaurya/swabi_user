import 'package:flutter/material.dart';
import '../respository/user.dart';
import '../utils/utils.dart';
import '/model/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final _myRepo = UserRepository();
  bool _loading = false;
  bool get loading => _loading;
  String filename = '';
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> saveToken(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<bool> saveUserId(UserModel userID) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('userId', userID.userId.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return UserModel(token: token);
  }

  Future<UserModel> getUserId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? userId = sp.getString('userId');
    return UserModel(userId: userId);
  }

  // Future<bool> removeUser(context) async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   print(sp.toString());
  //   Utils.flushBarSuccessMessage('Logout Successfully', context);
  //   sp.clear();
  //   print("token dismis");
  //   return true;
  // }

  Future<dynamic> remove(context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    sp.remove('userId');
    sp.remove('baseUrl');
    sp.clear();
    Utils.flushBarSuccessMessage("Logout Successful", context);
  }

}
