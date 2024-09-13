import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;
  final BuildContext context;
  final Function onPaymentSuccess;
  PaymentService({required this.context, required this.onPaymentSuccess}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(
      {required double amount,
      required String userId,
      required String coutryCode,
      required String mobileNo,
      required String email}) async {
    print(
      'object$amount-----$userId',
    );
    final response =
        await Provider.of<PaymentCreateOrderIdViewModel>(context, listen: false)
            .paymentCreateOrderIdViewModelApi(
                context: context,
                amount: amount.toInt(),
                userId: userId.toString());

    // Extract the Razorpay order ID from the response
    var paymentOrderId = response?.data.razorpayOrderId;
    print('paymentId:....$paymentOrderId');
    var options = {
      'key': 'rzp_test_6RDAELPDeFpXXx',
      'amount': (amount).toInt(),
      'name': 'SWABI',
      // 'order_id': widget.orderId,
      'order_id': paymentOrderId,

      'description': 'Payment for Product/Service',
      'prefill': {'contact': "${coutryCode} ${mobileNo}", 'email': email},
      'external': {
        'wallets': ['paytm']
      },
      'image': 'assets/images/Asset 233000 1.png', // Replace with your logo URL
      // Customize the color theme of the payment interface
      'theme': {
        'color': '#7B1E34' // Replace with your desired color code
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    onPaymentSuccess(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.flushBarErrorMessage(
        "ERROR: ${response.code} - ${response.message!}", context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void dispose() {
    _razorpay.clear(); // Removes all listeners
  }
  // }
}
