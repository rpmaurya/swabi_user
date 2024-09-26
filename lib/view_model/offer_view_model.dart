import 'package:flutter/material.dart';
import 'package:flutter_cab/model/offerDetailByIdModel.dart';
import 'package:flutter_cab/model/offerListModel.dart';
import 'package:flutter_cab/respository/offer_repository.dart';
import 'package:go_router/go_router.dart';

class OfferViewModel with ChangeNotifier {
  final _myRepo = OfferRepository();
  OfferListModel? offerListModel;
  OfferDetailByIdModel? offerDetailByIdModel;
  bool isLoading = false;
  Future<void> getOfferList(
      {required BuildContext context, required String date}) async {
    Map<String, dynamic> query = {"date": date, "bookingType": "ALL"};
    try {
      await _myRepo
          .offerListApi(context: context, query: query)
          .then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          offerListModel = onValue;
          notifyListeners();
        }
      });
    } catch (e) {
      debugPrint('error..$e');
    }
  }

  Future<void> getOfferDetails(
      {required BuildContext context, required int offerId}) async {
    Map<String, dynamic> query = {"offerId": offerId};
    try {
      isLoading = true;
      notifyListeners();
      await _myRepo
          .offerDetailsApi(context: context, query: query)
          .then((onValue) {
        if (onValue?.status?.httpCode == '200') {
          offerDetailByIdModel = onValue;
          isLoading = false;
          notifyListeners();
          context.push('/offerDetails');
        }
      });
    } catch (e) {
      debugPrint('error..$e');
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<OfferDetailByIdModel?> validateOffer(
      {required BuildContext context,
      required String offerCode,
      required String bookingType,
      required int bookigAmount}) async {
    Map<String, dynamic> query = {
      "offerCode": offerCode,
      "bookingType": bookingType,
      "bookingAmount": bookigAmount
    };
    try {
      isLoading = true;
      notifyListeners();
      var resp = await _myRepo.validateOfferApi(context: context, query: query);
      return resp;
    } catch (e) {
      debugPrint('error..$e');
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
