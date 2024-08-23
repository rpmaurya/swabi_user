// import 'package:HRM/data/response/api_response.dart';
// import 'package:HRM/model/getVisit_model.dart';
// import 'package:HRM/model/visitList_model.dart';
// import 'package:HRM/model/visit_create_model.dart';
// import 'package:HRM/repository/visit_management_repository.dart';
// import 'package:HRM/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
//
// import '../../../model/visit_type_list_model.dart';
//
// //Visit List
// class VisitListViewModel with ChangeNotifier {
//   final _myRepo = VisitListRepository();
//   ApiResponse<VisitListModel> DataList = ApiResponse.loading();
//   ApiResponse<VisitTypeListModel> DataList1 = ApiResponse.loading();
//   ApiResponse<VisitStatusListModel> DataList2 = ApiResponse.loading();
//
//   bool _isFilterApplied = false;
//
//   bool get isFilterApplied => _isFilterApplied;
//
//   void updateYourData(bool newData) {
//     _isFilterApplied = newData;
//     notifyListeners();
//   }
//
//   setDataList(ApiResponse<VisitListModel> response) {
//     DataList = response;
//     print("Res Print $response");
//     notifyListeners();
//   }
//
//   setDataList1(ApiResponse<VisitTypeListModel> response) {
//     DataList1 = response;
//     notifyListeners();
//   }
//
//   setDataList2(ApiResponse<VisitStatusListModel> response) {
//     DataList2 = response;
//     notifyListeners();
//   }
//
//   Future<void> fetchVisitListApi(BuildContext context, dynamic data) async {
//     setDataList(ApiResponse.loading());
//     _myRepo.fetchVisitListApi(data).then((value) {
//       setDataList(ApiResponse.completed(value));
//     }).onError((error, stackTrace) {
//       // Utils.flushBarErrorMessage(error.toString(), context);
//       print(error.toString());
//     });
//   }
//
//   Future<void> fetchVisitTypeListApi(BuildContext context) async {
//     _myRepo.fetchVisitListTypeApi().then((value) {
//       setDataList1(ApiResponse.completed(value));
//       // Utils.toastSuccessMessage(value['message']);
//     }).onError((error, stackTrace) {
//       // Utils.flushBarErrorMessage(error.toString(), context);
//       print(error.toString());
//     });
//   }
//
//   Future<void> fetchVisitStatusListApi(BuildContext context) async {
//     _myRepo.fetchVisitLisStatusApi().then((value) {
//       setDataList2(ApiResponse.completed(value));
//     }).onError((error, stackTrace) {
//       print("error is coming");
//       // Utils.flushBarErrorMessage(error.toString(), context);
//       print(error.toString());
//     });
//   }
// }
//
// // Create Visit View Model
// class CreateVisitViewModel with ChangeNotifier {
//   final _myRepo = CreateVisitRepository();
//   ApiResponse<VisitCreateModel> DataList = ApiResponse.loading();
//
//   setDataList(ApiResponse<VisitCreateModel> response) {
//     DataList = response;
//     notifyListeners();
//   }
//
//   Future<void> fetchCreateVisitApi(
//       BuildContext context, Map<String, dynamic> data) async {;
//     setDataList(ApiResponse.loading());
//     _myRepo.fetchCreateVisitApi(data).then((value) async {
//       setDataList(ApiResponse.completed(value));
//       Provider.of<VisitListViewModel>(context, listen: false)
//           .fetchVisitListApi(context, {});
//       Navigator.pop(context);
//       Utils.flushBarSuccessMessage(value.message, context);
//     }).onError((error, stackTrace) {
//       print(error.toString());
//       print('Create Visit List Failed');
//       Utils.flushBarErrorMessage(error.toString(), context);
//       setDataList(ApiResponse.error(error.toString()));
//     });
//   }
// }
//
// // Get Visit View Model
// // class UpdateGetVisitModel with ChangeNotifier {
// //   final _myRepo = UpdateGetVisitRepository();
// //   ApiResponse<GetVisitModel> DataList = ApiResponse.loading();
// //
// //   setDataList(ApiResponse<GetVisitModel> response) {
// //     DataList = response;
// //     notifyListeners();
// //   }
// //
// //   Future<void> fetchUpdateGetVisitApi(
// //       BuildContext context, Map<String, dynamic> data) async {
// //     print("UPdate getVIsit model $data");
// //     setDataList(ApiResponse.loading());
// //     _myRepo.fetchGetVisitApi(data).then((value) async {
// //       print('Update Get Visit Successful Model');
// //       setDataList(ApiResponse.completed(value));
// //       Utils.flushBarSuccessMessage(value.message, context);
// //     }).onError((error, stackTrace) {
// //       print(error.toString());
// //       print('Update Get Visit Failed');
// //       Utils.flushBarErrorMessage(error.toString(), context);
// //       setDataList(ApiResponse.error(error.toString()));
// //     });
// //   }
// // }
//
// class UpdateGetVisitModel with ChangeNotifier {
//   final _myRepo = UpdateGetVisitRepository();
//   ApiResponse<GetVisitModel> DataList = ApiResponse.loading();
//
//   setDataList(ApiResponse<GetVisitModel> response) {
//     DataList = response;
//     notifyListeners();
//   }
//
//   Future<void> fetchUpdateGetVisitApi(
//       BuildContext context, data, String data1) async {
//     setDataList(ApiResponse.loading());
//     _myRepo.fetchGetVisitApi(data).then((value) {
//       setDataList(ApiResponse.completed(value));
//
//       // Utils.flushBarSuccessMessage(value.message, context);
//       context.push("/visit/updateVisit",
//           extra: {"visit": value.data, "status": data1});
//     }).onError((error, stackTrace) {
//       Utils.flushBarErrorMessage(error.toString(), context);
//       setDataList(ApiResponse.error(error.toString()));
//     });
//   }
// }
