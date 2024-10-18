import 'package:flutter/material.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/changeMobileModel.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/respository/packageRepository.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
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
  bool isLoading = false;
  setDataList(ApiResponse<BookPackageByMemberModel> response) {
    getPackageBookingById = response;
    notifyListeners();
  }

  Future<void> fetchGetPackageBookingByIdViewModelApi(
      BuildContext context, data, String urId) async {
    setDataList(ApiResponse.loading());
    isLoading = true;
    notifyListeners();
    _myRepo.getPackageBookedByIdRepositoryApi(data).then((value) async {
      // setDataList(ApiResponse.completed(value));
      Utils.toastSuccessMessage("Your Package Booked");
      isLoading = false;
      notifyListeners();
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryBookedViewModelApi(context, {
        "userId": urId,
        "bookingStatus": "ALL",
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
      isLoading = false;
      notifyListeners();
    });
  }
}

// Get Package History View Model
class GetPackageHistoryViewModel with ChangeNotifier {
  final _myRepo = GetPackageHistoryRepository();
  ApiResponse<GetPackageHistoryModel> getBookedHistory = ApiResponse.loading();
  setDataList(ApiResponse<GetPackageHistoryModel> response) {
    getBookedHistory = response;
    notifyListeners();
  }

  void updateDayStatus({required String newStatus, required String bookingId}) {
    if (getBookedHistory.data != null) {
      var booking = getBookedHistory.data?.data.content
          .firstWhere((e) => e.packageBookingId == bookingId);

      if (booking != null) {
        booking.bookingStatus = newStatus;
        notifyListeners(); // Notify listeners after the change
      }
    }
  }

// Asynchronous function to fetch data from the repository
  Future<GetPackageHistoryModel?> fetchGetPackageHistoryBookedViewModelApi(
      BuildContext context, Map<String, dynamic> data) async {
    try {
      // Set state to loading before starting the API call
      setDataList(ApiResponse.loading());

      // Await the API call
      final value = await _myRepo.getPackageHistoryRepositoryApi(data);

      // Set the state to completed when the API call is successful
      setDataList(ApiResponse.completed(value));

      debugPrint('Get Package History ViewModel Success');
      return value;
    } catch (error) {
      // If there's an error, set the state to error
      debugPrint('Get Package History ViewModel Failed: $error');
      setDataList(ApiResponse.error(error.toString()));
    }
    return null;
  }
  // Future<void> fetchGetPackageHistoryBookedViewModelApi(
  //     BuildContext context, data) async {
  //   setDataList(ApiResponse.loading());
  //   _myRepo.getPackageHistoryRepositoryApi(data).then((value) async {
  //     setDataList(ApiResponse.completed(value));
  //     debugPrint('Get Package History ViewModel Success');
  //   }).onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //     debugPrint('Get Package History ViewModel Failed');
  //     setDataList(ApiResponse.error(error.toString()));
  //   });
  // }
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
      context.push("/package/packageDetailsPageView", extra: {
        "user": userID,
        "book": bookingID,
        "paymentId": value?.data.paymentId
      });
      debugPrint('Get Package History Detail By Id ViewModel Success');
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrint('Get Package History Detail By Id ViewModel Failed');
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchPackageHistoryDetailByIdViewModelApi(
      BuildContext context, data, String bookingID) async {
    setDataList(ApiResponse.loading());
    _myRepo.getPackageHistoryDetailByIdRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      // context.push("/package/packageDetails",extra: {"packageID":packID,"userId":uId,"bookDate":dateBooking});

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

  Future<PackageCancelModel?> fetchPackageCancelViewModelApi(
      BuildContext context,
      data,
      String urId,
      String bookingId,
      String paymentId) async {
    try {
      setDataList(ApiResponse.loading());
      await _myRepo
          .packageCancelRepositoryApi(context: context, query: data)
          .then((onValue) {
        if (onValue?.status.httpCode == '200') {
          Provider.of<GetPackageItineraryViewModel>(context, listen: false)
              .fetchGetPackageItineraryViewModelApi(
                  context, {"packageBookingId": bookingId});

          Provider.of<GetPaymentRefundViewModel>(context, listen: false)
              .getPaymentRefundApi(context: context, paymentId: paymentId);
          Provider.of<GetPackageHistoryDetailByIdViewModel>(context,
                  listen: false)
              .fetchPackageHistoryDetailByIdViewModelApi(
                  context, {"packageBookingId": bookingId}, bookingId);
          Provider.of<GetPackageHistoryViewModel>(context, listen: false)
              .updateDayStatus(newStatus: "CANCELLED", bookingId: bookingId);
          setDataList(ApiResponse.completed(onValue));
          context.pop();
          Utils.toastSuccessMessage(packageCancel.data?.data.body ?? '');
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('Get Package Cancel Api Failed');
      setDataList(ApiResponse.error(e.toString()));
    }
    return null;
    // setDataList(ApiResponse.loading());
    // await _myRepo
    //     .packageCancelRepositoryApi(context: context, query: data)
    //     .then((value) async {
    //   Provider.of<GetPackageItineraryViewModel>(context, listen: false)
    //       .fetchGetPackageItineraryViewModelApi(
    //           context, {"packageBookingId": bookingId});

    //   Provider.of<GetPaymentRefundViewModel>(context, listen: false)
    //       .getPaymentRefundApi(context: context, paymentId: paymentId);
    //   setDataList(ApiResponse.completed(value));
    //   context.pop();
    //   Utils.toastSuccessMessage(packageCancel.data?.data.body ?? '');
    //   debugPrint('Get Package Cancel Api Success');
    // }).onError((error, stackTrace) {
    //   // context.pop();
    //   debugPrint(error.toString());
    //   debugPrint('Get Package Cancel Api Failed');
    //   setDataList(ApiResponse.error(error.toString()));
    // });
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
      Utils.toastSuccessMessage(
        "PickUp Location Add Success",
      );
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

class ChangeMobileViewModel with ChangeNotifier {
  final _myRepo = ChangeMobileRepository();
  ApiResponse<ChangeMobileModel> changeMobile = ApiResponse.loading();

  setDataList(ApiResponse<ChangeMobileModel> response) {
    changeMobile = response;
    notifyListeners();
  }

  Future<ChangeMobileModel?> changeMobileApi(
      {required BuildContext context,
      required Map<String, dynamic> body,
      required String bookingId}) async {
    try {
      setDataList(ApiResponse.loading());
      _myRepo.changeMobile(context: context, body: body).then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          setDataList(ApiResponse.completed(onValue));
          Provider.of<GetPackageHistoryDetailByIdViewModel>(context,
                  listen: false)
              .fetchPackageHistoryDetailByIdViewModelApi(
                  context, {"packageBookingId": bookingId}, bookingId);
          // print("Signup Success");
          Utils.toastSuccessMessage("changed Successfully");
        }
        context.pop();
      }).onError((error, stactrace) {
        setDataList(ApiResponse.error(error.toString()));
      });
    } catch (e) {
      print('errrrrrrrrrrrrrrrrrrrr$e');
    }
    return null;
  }
}
