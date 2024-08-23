import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RazorpayPayment extends StatefulWidget {
  final String userId;
  // final String orderId;
  final double amount;
  final String email;
  final String mobileNo;
  final String coutryCode;
  const RazorpayPayment({
    Key? key,
    required this.userId,
    // required this.orderId,
    required this.amount,
    required this.email,
    required this.mobileNo,
    required this.coutryCode,
  }) : super(key: key);

  @override
  _RazorpayPaymentState createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String orderId) async {
    var options = {
      'key': 'rzp_test_6RDAELPDeFpXXx',
      'amount': (widget.amount * 100).toInt(),
      'name': 'SWABI',
      // 'order_id': widget.orderId,
      'order_id': orderId,

      'description': 'Payment for Product/Service',
      'prefill': {
        'contact': "${widget.coutryCode} ${widget.mobileNo}",
        'email': widget.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: ${response.paymentId!}",
    //     toastLength: Toast.LENGTH_SHORT);
    Provider.of<PaymentVerifyViewModel>(context, listen: false)
        .paymentVerifyViewModelApi(
            context: context,
            userId: widget.userId,
            paymentId: response.paymentId,
            razorpayOrderId: response.orderId,
            razorpaySignature: response.signature)
        .then(
      (value) {
        if (value?.status.httpCode == '200') {
          print(
              'payment verification is successfull${value?.data.transactionId}');
          debugPrint(response.orderId);
          debugPrint(
            response.paymentId,
          );
          debugPrint(response.signature);
          context.pop();
          // context.pop();
        }
      },
    );

    // context.pop();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.flushBarErrorMessage(
        "ERROR: ${response.code} - ${response.message!}", context);
    // Fluttertoast.showToast(
    //     msg: "ERROR: ${response.code} - ${response.message!}",
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> initiatePayment() async {
    try {
      // Fetching the payment order ID from the API
      final response = await Provider.of<PaymentCreateOrderIdViewModel>(context,
              listen: false)
          .paymentCreateOrderIdViewModelApi(
              context: context,
              amount: widget.amount.toInt(),
              userId: widget.userId.toString());

      // Extract the Razorpay order ID from the response
      var paymentOrderId = response?.data.razorpayOrderId;

      openCheckout(paymentOrderId ?? '');
    } catch (error) {
      print("Error initiating payment: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: AppDimension.getHeight(context) / 3,
        width: AppDimension.getWidth(context) / 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Amount: ${widget.amount}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: btnColor),
                onPressed: () {
                  initiatePayment();
                },
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: background),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
