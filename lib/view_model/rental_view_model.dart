import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/respository/rental_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
// ignore: depend_on_referenced_packages

// Rental View Model
class RentalViewModel with ChangeNotifier {
  final _myRepo = RentalRepository();
  bool _loading = false;
  bool get loading => _loading;
  ApiResponse<RentalCarListStatusModel> DataList = ApiResponse.loading();

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setDataList(ApiResponse<RentalCarListStatusModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchRentalViewModelApi(BuildContext context, data,
      String myUserId, double lati, double logi) async {
    setLoading(true);
    setDataList(ApiResponse.loading());
    _myRepo.rentalRepositoryApi(data).then((value) async {
      setLoading(false);
      setDataList(ApiResponse.completed(value));
      // debugPrint('Rental Api Success');
      (DataList.data?.data.body ?? []).isEmpty
          ? Utils.flushBarErrorMessage(
              DataList.data?.data.errorMessage ?? "Something went wrong",
              context)
          : null;
      (DataList.data?.data.body ?? []).isNotEmpty
          ? context.push('/rentalForm/carsDetails',
              extra: {'id': myUserId, 'logitude': logi, "latitude": lati})
          : null;
      // (DataList.data?.data.body ?? []).isEmpty ? Utils.flushBarErrorMessage(DataList.data?.data.errorMessage ?? "Something went wrong", context, redColor) : null;
    }).onError((error, stackTrace) {
      setLoading(false);
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// Get Rental Range List View Model
class GetRentalRangeListViewModel with ChangeNotifier {
  final _myRepo = GetRentalRangeListRepository();
  ApiResponse<GetRentalRangeListModel> getRentalRangeList =
      ApiResponse.loading();

  setDataList(ApiResponse<GetRentalRangeListModel> response) {
    getRentalRangeList = response;
    notifyListeners();
  }

  Future<void> fetchGetRentalRangeListViewModelApi(
      BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.getRentalRangeListRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // debugPrint(error.toString());
      if (error.toString() == "Null check operator used on a null value") {
        // Utils.flushBarErrorMessage("", context);
      }
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

/// Rental Booking View Model
class RentalBookingViewModel with ChangeNotifier {
  final _myRepo = RentalBookingRepository();
  ApiResponse<RentalCarBookingModel> DataList = ApiResponse.loading();
  bool isLoading = false;
  setDataList(ApiResponse<RentalCarBookingModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<RentalCarBookingModel?> rentalBookingViewModel(
      {required BuildContext context,
      required Map<String, dynamic> body,
      required String userId}) async {
    try {
      isLoading == true;
      notifyListeners();
      setDataList(ApiResponse.loading());
      await _myRepo
          .rentalBookingApi(context: context, body: body)
          .then((onValue) {
        if (onValue?.status.httpCode == '200') {
          setDataList(ApiResponse.completed(onValue));
          debugPrint("Booking2 sucessfully....");
          // if (context.mounted) return;
          context.pop();
          isLoading == false;
          notifyListeners();
          Utils.flushBarSuccessMessage("Ride Booked Successfully", context);
          context.replace("/rentalForm/happyScreen", extra: {'userId': userId});

          // }
        }
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> fetchRentalViewModelApi(
      BuildContext context, data, String userId) async {
    setDataList(ApiResponse.loading());
    debugPrint("Booking1");
    _myRepo.rentalBookingRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint("Booking2.......... $value");
      context.replace("/rentalForm/happyScreen", extra: {'userId': userId});
      // context.replace("/rentalForm/happyScreen");
      debugPrint("Booking3");
      // Utils.flushBarSuccessMessage("Ride Booked Successfully", context);
      // debugPrint('RentalBooking Api Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      // debugPrint('RentalBooking Api Failed');
      // Utils.flushBarErrorMessage(DataList.data?.data.toString(), context);
      Utils.flushBarErrorMessage("Enter valid phone number", context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

// Rental Booking View Model
class RentalBookingCancelViewModel with ChangeNotifier {
  final _myRepo = RentalBookingCancelRepository();
  ApiResponse<RentalCarBookingCancelModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<RentalCarBookingCancelModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchRentalBookingCancelViewModelApi(
      BuildContext context, data, String userId) async {
    setDataList(ApiResponse.loading());
    _myRepo.rentalBookingCancelRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      // debugPrint('RentalBooking Cancel Api Success');
      Provider.of<RentalBookingListViewModel>(context, listen: false)
          .fetchRentalBookingListBookedViewModelApi(context, {
        'userId': userId,
        'pageNumber': '0',
        'pageSize': '100',
        'bookingStatus': 'BOOKED',
      });
      Provider.of<RentalBookingListViewModel>(context, listen: false)
          .fetchRentalBookingListCancelledViewModelApi(context, {
        'userId': userId,
        'pageNumber': '0',
        'pageSize': '100',
        'bookingStatus': 'CANCELLED',
      });

      context.pop();
      context.pop();
      // context.pop();
      Utils.flushBarSuccessMessage(DataList.data?.data.body ?? '', context);
    }).onError((error, stackTrace) {
      // debugPrint(error.toString());
      setDataList(ApiResponse.error(error.toString()));
      // Utils.flushBarErrorMessage(error.toString(), context,redColor);
    });
  }
}

// Rental Booking List FilterWise View Model
class RentalBookingListViewModel with ChangeNotifier {
  final _myRepo = RentalBookingListRepository();
  ApiResponse<RentalCarBookingListModel> rentalBookingList =
      ApiResponse.loading();
  ApiResponse<RentalCarBookingListModel> rentalCancelList =
      ApiResponse.loading();
  ApiResponse<RentalCarBookingListModel> rentalUpcommingList =
      ApiResponse.loading();
  ApiResponse<RentalCarBookingListModel> rentalOnRunningList =
      ApiResponse.loading();
  ApiResponse<RentalCarBookingListModel> rentalCompletedList =
      ApiResponse.loading();

  setDataList(ApiResponse<RentalCarBookingListModel> response) {
    rentalBookingList = response;
    notifyListeners();
  }

  setDataList1(ApiResponse<RentalCarBookingListModel> response) {
    rentalCancelList = response;
    notifyListeners();
  }

  setDataList4(ApiResponse<RentalCarBookingListModel> response) {
    rentalUpcommingList = response;
    notifyListeners();
  }

  setDataList2(ApiResponse<RentalCarBookingListModel> response) {
    rentalOnRunningList = response;
    notifyListeners();
  }

  setDataList3(ApiResponse<RentalCarBookingListModel> response) {
    rentalCompletedList = response;
    notifyListeners();
  }

  Future<void> fetchRentalBookingListBookedViewModelApi(
      BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchRentalBookingListCancelledViewModelApi(
      BuildContext context, data) async {
    setDataList1(ApiResponse.loading());
    _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
      setDataList1(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDataList1(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchRentalBookingListOnRunningViewModelApi(
      BuildContext context, data) async {
    setDataList2(ApiResponse.loading());
    _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
      setDataList2(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDataList2(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchRentalBookingListUpcommingViewModelApi(
      BuildContext context, data) async {
    setDataList4(ApiResponse.loading());
    _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
      setDataList4(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDataList4(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchRentalBookingListCompletedViewModelApi(
      BuildContext context, data) async {
    // debugPrint("Completed 1");
    setDataList3(ApiResponse.loading());

    _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
      setDataList3(ApiResponse.completed(value));
      // debugPrint("Completed 3");
    }).onError((error, stackTrace) {
      // debugPrint("Completed 2");
      debugPrint(error.toString());
      setDataList3(ApiResponse.error(error.toString()));
    });
  }
  // Future<void> fetchRentalBookingListCompletedViewModelApi(BuildContext context,data) async {
  //   setDataList3(ApiResponse.loading());
  //   _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
  //     setDataList3(ApiResponse.completed(value));
  //     // context.push('/rentalForm/rentalCarBooking');
  //     // Utils.toastMessage("Rental Car List Completed Booking",greenColor);
  //   }).onError((error, stackTrace) {
  //     // Utils.flushBarErrorMessage(error.toString(), context,redColor);
  //     setDataList3(ApiResponse.error(error.toString()));
  //   });
  // }
}

// Rental View Detail View Model
class RentalViewDetailViewModel with ChangeNotifier {
  final _myRepo = RentalViewDetailsRepository();
  ApiResponse<RentalDetailsSingleModel> DataList = ApiResponse.loading();
  ApiResponse<RentalDetailsSingleModel> DataList1 = ApiResponse.loading();

  setDataList(ApiResponse<RentalDetailsSingleModel> response) {
    DataList = response;
    notifyListeners();
  }

  setDataList1(ApiResponse<RentalDetailsSingleModel> response) {
    DataList1 = response;
    notifyListeners();
  }

  Future<void> fetchRentalBookedViewDetialViewModelApi(
      BuildContext context, data, String bookid, String uid) async {
    setDataList(ApiResponse.loading());
    debugPrint(bookid);
    _myRepo.rentalViewDetailsRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      context.push('/rentalForm/rentalBookedPageView',
          extra: {"bookedId": bookid, "useriD": uid});
      // Utils.toastMessage("Rental Car View Detail Booking");
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchRentalCancelledViewDetialViewModelApi(
      BuildContext context, data, String cancelId) async {
    setDataList1(ApiResponse.loading());
    _myRepo.rentalViewDetailsRepositoryApi(data).then((value) async {
      setDataList1(ApiResponse.completed(value));
      context.push('/rentalForm/rentalCancelledPageView',
          extra: {"cancelledId": cancelId});
      // Utils.toastMessage("Rental Car View Detail Booking");
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList1(ApiResponse.error(error.toString()));
    });
  }
}

/// Rental Validation View Model
class RentalValidationViewModel with ChangeNotifier {
  final _myRepo = RentalValidationRepository();
  ApiResponse<RentalCarBookingValidationModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<RentalCarBookingValidationModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchRentalValidationModelApi(BuildContext context, data) async {
    setDataList(ApiResponse.loading());
    _myRepo.rentalValidationRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      debugPrint('Rental Validation Api ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Rental Validation Api ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}
