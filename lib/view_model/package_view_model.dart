import 'package:flutter/material.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/respository/packageRepository.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Get Package List View Model
class GetPackageListViewModel with ChangeNotifier {
  final _myRepo = GetPackageListRepository();
  ApiResponse<GetPackageListModel> getPackageList = ApiResponse.loading();

  setDataList(ApiResponse<GetPackageListModel> response) {
    getPackageList = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageListViewModelApi(
      BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageListRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint('Get Package List Api Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package List Api Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// Get Package Activity By Id View Model
class GetPackageActivityByIdViewModel with ChangeNotifier {
  final _myRepo = GetPackageActivityByIdRepository();
  ApiResponse<GetPackageDetailsByIdModel> getPackageActivityById =
      ApiResponse.loading();

  setDataList(ApiResponse<GetPackageDetailsByIdModel> response) {
    getPackageActivityById = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageActivityByIdViewModelApi(BuildContext context,
      data, String packID, String uId, String dateBooking) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageActivityByIdRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      context.push("/package/packageDetails",
          extra: {"packageID": packID, "userId": uId, "bookDate": dateBooking});
      debugPrint('Get Package Activity By Id ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package Activity By Id ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// Get Package BOOKING By Id View Model
class GetPackageBookingByIdViewModel with ChangeNotifier {
  final _myRepo = GetPackageBookedByIdRepository();
  ApiResponse<BookPackageByMemberModel> getPackageBookingById =
      ApiResponse.loading();

  setDataList(ApiResponse<BookPackageByMemberModel> response) {
    getPackageBookingById = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageBookingByIdViewModelApi(
      BuildContext context, data, String urId) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageBookedByIdRepositoryApi(data).then((value) async {
      // setDataList(ApiResponse.completed(value));
      Utils.flushBarSuccessMessage("Your Package Booked", context);
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryBookedViewModelApi(context, {
        "userId": urId,
        "bookingStatus": "BOOKED",
        "pageNumber": "0",
        "pageSize": "100",
      });
      context.pushReplacement("/package/packageHistoryManagement",
          extra: {"userID": urId});
      debugPrint('Get Package Booking By Id ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package Booking By Id ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// Get Package History View Model
class GetPackageHistoryViewModel with ChangeNotifier {
  final _myRepo = GetPackageHistoryRepository();
  ApiResponse<GetPackageHistoryModel> getBookedHistory = ApiResponse.loading();
  ApiResponse<GetPackageHistoryModel> getUpcommingHistory =
      ApiResponse.loading();
  ApiResponse<GetPackageHistoryModel> getCompletedHistory =
      ApiResponse.loading();
  ApiResponse<GetPackageHistoryModel> getCancelledHistory =
      ApiResponse.loading();

  setDataList(ApiResponse<GetPackageHistoryModel> response) {
    getBookedHistory = response;
    notifyListeners();
  }

  setDataList1(ApiResponse<GetPackageHistoryModel> response) {
    getCompletedHistory = response;
    notifyListeners();
  }

  setDataList2(ApiResponse<GetPackageHistoryModel> response) {
    getCancelledHistory = response;
    notifyListeners();
  }

  setDataList3(ApiResponse<GetPackageHistoryModel> response) {
    getUpcommingHistory = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageHistoryBookedViewModelApi(
      BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageHistoryRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint('Get Package History ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package History ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchGetPackageHistoryUpCommingViewModelApi(
      BuildContext context, data) async {
    setDataList3(ApiResponse.loading());
    _myRepo.getPackageHistoryRepositoryApi(data).then((value) async {
      setDataList3(ApiResponse.completed(value));
      debugPrint('Get Package History ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package History ViewModel Failed');
      setDataList3(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchGetPackageHistoryCompletedViewModelApi(
      BuildContext context, data) async {
    setDataList1(ApiResponse.loading());
    _myRepo.getPackageHistoryRepositoryApi(data).then((value) async {
      setDataList1(ApiResponse.completed(value));
      debugPrint('Get Package History ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package History ViewModel Failed');
      setDataList1(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchGetPackageHistoryCancelledViewModelApi(
      BuildContext context, data) async {
    setDataList2(ApiResponse.loading());
    _myRepo.getPackageHistoryRepositoryApi(data).then((value) async {
      setDataList2(ApiResponse.completed(value));
      debugPrint('Get Package Canacelled ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package History ViewModel Failed');
      setDataList2(ApiResponse.error(error.toString()));
    });
  }
}

// Get Package History Detail By Id View Model
class GetPackageHistoryDetailByIdViewModel with ChangeNotifier {
  final _myRepo = GetPackageHistoryDetailByIdRepository();
  ApiResponse<GetPackageHIstoryDetailsModel> getPackageHistoryDetailById =
      ApiResponse.loading();

  setDataList(ApiResponse<GetPackageHIstoryDetailsModel> response) {
    getPackageHistoryDetailById = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageHistoryDetailByIdViewModelApi(
      BuildContext context, data, String userID, String bookingID) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageHistoryDetailByIdRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      // context.push("/package/packageDetails",extra: {"packageID":packID,"userId":uId,"bookDate":dateBooking});
      context.push("/package/packageDetailsPageView",
          extra: {"user": userID, "book": bookingID});
      debugPrint('Get Package History Detail By Id ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package History Detail By Id ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

/// Get Package List View Model
class PackageCancelViewModel with ChangeNotifier {
  final _myRepo = PackageCancelRepository();
  ApiResponse<PackageCancelModel> packageCancel = ApiResponse.loading();

  setDataList(ApiResponse<PackageCancelModel> response) {
    packageCancel = response;
    notifyListeners();
  }

  Future<void> fetchPackageCancelViewModelApi(
      BuildContext context, data, String urId) async {
    setDataList(ApiResponse.loading());
    _myRepo.packageCancelRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryBookedViewModelApi(context, {
        "userId": urId,
        "bookingStatus": "BOOKED",
        "pageNumber": "0",
        "pageSize": "100",
      }).then((value) =>
              Provider.of<GetPackageHistoryViewModel>(context, listen: false)
                  .fetchGetPackageHistoryCancelledViewModelApi(context, {
                "userId": urId,
                "bookingStatus": "CANCELLED",
                "pageNumber": "0",
                "pageSize": "100",
              }));

      context.pop();
      context.pop();
      Utils.flushBarSuccessMessage(
          packageCancel.data?.data.body ?? '', context);
      debugPrint('Get Package Cancel Api Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package Cancel Api Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// Add PickUp Location Package View Model
class AddPickUpLocationPackageViewModel with ChangeNotifier {
  final _myRepo = AddPickUpLocationPackageRepository();
  ApiResponse<AddPickUpLocationModel> addPickUpLocationPackage =
      ApiResponse.loading();

  setDataList(ApiResponse<AddPickUpLocationModel> response) {
    addPickUpLocationPackage = response;
    notifyListeners();
  }

  Future<void> fetchAddPickUpLocationPackageViewModelApi(
      BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.addPickUpLocationPackageRepositoryApi(data).then((value) async {
      // setDataList(ApiResponse.completed(value));
      context.pop(context);
      // context.pop(context);
      Utils.flushBarSuccessMessage("PickUp Location Add Success", context);
      debugPrint('Get Package Activity By Id ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package Activity By Id ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// GetPackageItinerary View Model
class GetPackageItineraryViewModel with ChangeNotifier {
  final _myRepo = GetPackageItineraryRepository();
  ApiResponse<GetPackageItineraryModel> getPackageItineraryList =
      ApiResponse.loading();

  setDataList(ApiResponse<GetPackageItineraryModel> response) {
    getPackageItineraryList = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageItineraryViewModelApi(
      BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageItineraryRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint('GetPackageItinerary ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('GetPackageItinerary ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}
