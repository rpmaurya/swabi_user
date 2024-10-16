import 'package:flutter/material.dart';
import 'package:flutter_cab/data/response/api_response.dart';
import 'package:flutter_cab/model/getTrasactionByIdModel.dart';
import 'package:flutter_cab/model/paymentGetWay_model.dart';
import 'package:flutter_cab/model/payment_refund_model.dart';
import 'package:flutter_cab/respository/payment_gateway_repository.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:go_router/go_router.dart';

/// Rental Booking View Model
class PaymentCreateOrderIdViewModel with ChangeNotifier {
  final _myRepo = PaymentCreateOrderIDRepository();
  ApiResponse<PaymentCreateOderIdModel> paymentOrderID = ApiResponse.loading();
  setDataList(ApiResponse<PaymentCreateOderIdModel> response) {
    paymentOrderID = response;
    notifyListeners();
  }

  Future<PaymentCreateOderIdModel?> paymentCreateOrderIdViewModelApi(
      {required BuildContext context,
      required int amount,
      required String userId,
      required double taxAmount,
      required double taxPercentage,
      required double discountAmount,
      required double totalPayableAmount}) async {
    Map<String, dynamic> body = {
      "price": amount,
      "taxAmount": taxAmount,
      "userId": userId,
      "taxPercentage": taxPercentage,
      "discountAmount": discountAmount.toInt(),
      "totalPayableAmount": totalPayableAmount
    };
    try {
      setDataList(ApiResponse.loading());
      var resp =
          await _myRepo.paymentCreateOrderIdApi(context: context, body: body);
      setDataList(ApiResponse.completed(resp));
      return resp;
    } catch (e) {
      setDataList(ApiResponse.error(e.toString()));
      print(e);
    } finally {
      setDataList(ApiResponse.error(''));
    }
    return null;
  }

  // Future<void> fetchPaymentCreateOrderIdViewModelApi(
  //   BuildContext context,
  //   data,
  //   // String? carType, id, date, lati, longi
  // ) async {
  //   setDataList(ApiResponse.loading());
  //   var resp =
  //       _myRepo.paymentCreateOrderIDRepositoryApi(data).then((value) async {
  //     print(data);
  //     setDataList(ApiResponse.completed(value));
  //     // context.push('/rentalForm/bookYourCab', extra: {
  //     //   "carType": carType,
  //     //   "userId": id,
  //     //   "bookdate": date,
  //     //   "longitude": longi,
  //     //   "latitude": lati,
  //     //   // "totalAmt":totalAmt
  //     // });
  //     // Utils.flushBarSuccessMessage("Payment Order Id Success", context);
  //   }).onError((error, stackTrace) {
  //     // debugPrint(error.toString());
  //     // Utils.flushBarErrorMessage(error.toString(), context);
  //     setDataList(ApiResponse.error(error.toString()));
  //   });
  // }
}

/// Rental Booking View Model
class PaymentVerifyViewModel with ChangeNotifier {
  final _myRepo = PaymentVerifyRepository();
  ApiResponse<PaymentVerifyModel> paymentVerify = ApiResponse.loading();
  setDataList(ApiResponse<PaymentVerifyModel> response) {
    paymentVerify = response;
    notifyListeners();
  }

  Future<PaymentVerifyModel?> paymentVerifyViewModelApi(
      {required BuildContext context,
      required String userId,
      required String? paymentId,
      required String? razorpayOrderId,
      required String? razorpaySignature}) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "paymentId": paymentId,
      "razorpayOrderId": razorpayOrderId,
      "razorpaySignature": razorpaySignature
    };
    try {
      print('bodyofpaymentverification..$body');
      setDataList(ApiResponse.loading());
      var resp = await _myRepo.paymentVerifyApi(context: context, body: body);
      setDataList(ApiResponse.completed(resp));
      // Utils.flushBarSuccessMessage("Payment paymentVerify Success", context);
      return resp;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> fetchPaymentVerifyViewModelApi(
      BuildContext context, data) async {
    print('verification data :...$data');
    setDataList(ApiResponse.loading());
    _myRepo.paymentVerifyRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      Utils.toastSuccessMessage("Payment paymentVerify Success");
      // context.pop();
      context.pop();
    }).onError((error, stackTrace) {
      // debugPrint(error.toString());
      Utils.toastMessage(
        error.toString(),
      );
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

class GetTranactionViewModel with ChangeNotifier {
  final _myRepo = PaymentTrasactionRespository();
  ApiResponse<GetTransactionByIdModel> getTrasaction = ApiResponse.loading();
  setDataList(ApiResponse<GetTransactionByIdModel> response) {
    getTrasaction = response;
    notifyListeners();
  }

  Future<GetTransactionByIdModel?> getTranactionApi(
      {required BuildContext context,
      required Map<String, dynamic> query}) async {
    try {
      print('bodyofpaymentverification..$query');
      setDataList(ApiResponse.loading());
      var resp =
          await _myRepo.getTrasactionByIdApi(context: context, query: query);
      setDataList(ApiResponse.completed(resp));
      // Utils.flushBarSuccessMessage("Payment paymentVerify Success", context);
      return resp;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

class GetPaymentRefundViewModel with ChangeNotifier {
  final _myRepo = PaymentRefundRespository();
  ApiResponse<PaymentRefundModel> getPaymentRefund = ApiResponse.loading();
  setDataList(ApiResponse<PaymentRefundModel> response) {
    getPaymentRefund = response;
    notifyListeners();
  }

  Future<PaymentRefundModel?> getPaymentRefundApi(
      {required BuildContext context, required String paymentId}) async {
    Map<String, dynamic> query = {"paymentId": paymentId};
    try {
      print('refundQuery..$query');
      setDataList(ApiResponse.loading());
      var resp =
          await _myRepo.getRefundPaymentApi(context: context, query: query);
      setDataList(ApiResponse.completed(resp));
      // Utils.flushBarSuccessMessage("Payment paymentVerify Success", context);
      return resp;
    } catch (e) {
      setDataList(ApiResponse.error(e.toString()));
      print(e);
    }
    return null;
  }
}
