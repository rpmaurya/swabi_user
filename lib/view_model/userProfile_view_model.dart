// Rental Booking View Model

import 'package:flutter/material.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/changepassword_model.dart';
import 'package:flutter_cab/model/user_profile_model.dart';
import 'package:flutter_cab/respository/user_profi_repository.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserProfileViewModel with ChangeNotifier {
  final _myRepo = UserProfileRepository();
  ApiResponse<UserProfileModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<UserProfileModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchUserProfileViewModelApi(
    BuildContext context,
    data,
    /*String uid */
  ) async {
    setDataList(ApiResponse.loading());
    _myRepo.userProfileRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      // context.push("/profilePage",extra: {"userId":uid});
    }).onError((error, stackTrace) {
      // debugPrint("data nhi chla");
      Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// ///Profile Image View Model
class ProfileImageViewModel with ChangeNotifier {
  final _myRepo = ProfileImageRepository();
  ApiResponse<String> DataList = ApiResponse.loading();

  setDataList(ApiResponse<String> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> postProfileImageApi(BuildContext context, dynamic data) async {
    _myRepo.fetchProfileImageApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      Utils.flushBarSuccessMessage(
          DataList.data ?? "Profile Uploaded Successfully", context);
      // print('Profile Upload Completed');
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      // print('Profile Failed');
      // print(error.toString());
      // Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}

///User Profile Update View Model
class UserProfileUpdateViewModel with ChangeNotifier {
  final _myRepo = UserProfileUpdateRepository();
  ApiResponse<UserProfileUpdateModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<UserProfileUpdateModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchUserProfileUpdateViewModelApi(
      BuildContext context, data, String uid) async {
    setDataList(ApiResponse.loading());
    _myRepo.userProfileUpdateRepositoryApi(data).then((value) async {
      context.pop();
      Provider.of<UserProfileViewModel>(context, listen: false)
          .fetchUserProfileViewModelApi(
              context, {"userId": uid}).then((value) => print("k"));
      // Provider.of<UserProfileViewModel>(
      //     context, listen: false).
      // fetchUserProfileViewModelApi(
      //     context, {
      //   "userId":uid
      // }, uid).then((value) => print("k"));

      setDataList(ApiResponse.completed(value));
      Utils.flushBarSuccessMessage("Profile Updated Success", context);
      // Utils.flushBarSuccessMessage("Profile Updated Success", context);
      // print("aaadtad");
    }).onError((error, stackTrace) {
      // debugPrint(error.toString());
      // print("api failed");
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

class ChangePasswordViewModel with ChangeNotifier {
  final _myRepo = UserProfileUpdateRepository();
  ApiResponse<ChangePasswordModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<ChangePasswordModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<ChangePasswordModel?> changePasswordViewModelApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    try {
      setDataList(ApiResponse.loading());
      var resp =
          await _myRepo.changePasswordApi(context: context, query: query);
      setDataList(ApiResponse.completed(resp));
      // Utils.flushBarSuccessMessage("Changed password Successfully", context);
      return resp;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
