import 'package:flutter/material.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/customAlertBox.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/offer_view_model.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:flutter_cab/view_model/services/paymentService.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookYourCab extends StatefulWidget {
  final String carType;
  final String userId;
  final String bookingDate;
  final String totalAmt;
  final String logitude;
  final String latitude;

  const BookYourCab(
      {super.key,
      required this.carType,
      required this.userId,
      required this.logitude,
      required this.latitude,
      required this.bookingDate,
      required this.totalAmt});

  @override
  State<BookYourCab> createState() => _BookYourCabState();
}

class _BookYourCabState extends State<BookYourCab> {
  List<TextEditingController> controller =
      List.generate(9, (index) => TextEditingController());

  List rentalBooking = ['Self', "Someone Others"];
  TextEditingController checkControler = TextEditingController();
  TextEditingController couponController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RentalValidationViewModel>(context, listen: false)
          .fetchRentalValidationModelApi(context, {
        "date": widget.bookingDate,
        "userId": widget.userId,
        // "date":"01-06-2024",
        // "userId":"1001",
      });
      Provider.of<UserProfileViewModel>(context, listen: false)
          .fetchUserProfileViewModelApi(context, {'userId': widget.userId});
    });
  }

  bool isloading = false;
  late BuildContext _savedContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _savedContext = context;
  }

  @override
  void dispose() {
    if (mounted) {}
    // Do not use context directly here; use _safeContext instead
    super.dispose();
  }

  String? offerCode;
  double discountPercentage = 0;
  double discountedAmount = 0;
  bool visibleCoupon = false;
  double disAmount = 0;
  double taxPercentage = 5;
  double payableAmount = 0;
  double taxAmount = 0;
  double maxDisAmount = 0;
  double taxamount() {
    double amt = double.parse(widget.totalAmt);
    return (taxPercentage / 100) * amt;
    // return sumAmount + taxamt;
  }

  double getPercentage() {
    double amt = (discountPercentage / 100) * payableAmount;
    disAmount = amt > maxDisAmount ? maxDisAmount : amt;
    return payableAmount - disAmount.toInt();
  }

  int checkBox = 0;
  List<Body> rentalData = [];
  var rentalValidation, paymentOrderId, profileUser;

  @override
  Widget build(BuildContext context) {
    debugPrint("${widget.userId}UserID");
    debugPrint("${widget.bookingDate} Booking Date");
    debugPrint("${widget.latitude} Booking latitude");
    debugPrint("${widget.logitude} Booking logitude");

    rentalData =
        context.watch<RentalViewModel>().DataList.data?.data.body ?? [];
    rentalValidation = context
        .watch<RentalValidationViewModel>()
        .DataList
        .data
        ?.status
        .message;
    taxAmount = taxamount();
    payableAmount = double.parse(widget.totalAmt) + taxAmount;
    debugPrint('fhjhjbdhdhjdhjdhjdjh${widget.totalAmt.toString()}');
    debugPrint('taxamount.......$taxAmount');
    debugPrint('payAbleamount.......$payableAmount');
    debugPrint('discountamount.......$disAmount');

    // paymentOrderId = context
    //     .watch<PaymentCreateOrderIdViewModel>()
    //     .paymentOrderID
    //     .data
    //     ?.data
    //     .razorpayOrderId;
    profileUser = context.watch<UserProfileViewModel>().DataList.data?.data;
    List<Body> filteredData =
        rentalData.where((rental) => rental.carType == widget.carType).toList();
    debugPrint(widget.carType);
    // debugPrint(paymentOrderId);
    return Scaffold(
      appBar: CustomAppBar(
        heading: "Book Your Ride",
        backBtnOnTap: () => context.pop(context),
      ),
      backgroundColor: bgGreyColor,
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final rental = filteredData[index];

                return Stack(
                  children: [
                    BookingContainer(
                      carName: rental.carType,
                      seats: rental.seats,
                      hour: rental.hours,
                      kilometers: rental.kilometers,
                      pickDate: rental.date,
                      pickTime: rental.pickupTime,
                      pickUpLocation: rental.pickUpLocation,
                      // price: rental.price,
                      loading: false,
                      totalPrice: rental.totalPrice,
                      couponController: couponController,
                      discountedAmount: discountedAmount,
                      couponVisible: visibleCoupon,
                      offerDisAmount: disAmount,
                      taxAmount: taxAmount,
                      payableAmount: payableAmount,
                      onCouponRemoveTap: () {
                        setState(() {
                          visibleCoupon = false;
                          discountedAmount = 0;
                        });
                      },
                      onCouponTap: () {
                        // double? amount = double.parse(rental.totalPrice);
                        if (couponController.text.isEmpty) {
                          Utils.toastMessage('Please Enter Offer Coupon');
                        } else {
                          Provider.of<OfferViewModel>(context, listen: false)
                              .validateOffer(
                                  context: context,
                                  offerCode: couponController.text,
                                  bookingType: 'RENTAL_BOOKING',
                                  bookigAmount: payableAmount.toInt())
                              .then((onValue) {
                            if (onValue?.status?.httpCode == '200') {
                              Utils.toastSuccessMessage(
                                  onValue?.status?.message ?? '');
                              offerCode = onValue?.data?.offerCode;
                              maxDisAmount =
                                  onValue?.data?.maxDiscountAmount ?? 0;
                              discountPercentage =
                                  onValue?.data?.discountPercentage ?? 0;
                              setState(() {
                                visibleCoupon = true;
                                discountedAmount = getPercentage();
                                print(
                                    'discountpercentage.....,..,.,$discountedAmount');
                              });
                            } else {
                              setState(() {
                                discountedAmount = 0;
                              });
                            }
                          });
                        }
                      },
                      onTap: () {
                        ////
                        if (rentalValidation.toString().isNotEmpty &&
                            rentalValidation == "Success") {
                          showDialog(
                              context: context,
                              builder: (context) => _showAlertBox(context, () {
                                    setState(() {
                                      debugPrint(checkBox.toString());
                                    });
                                    if (checkBox == 1) {
                                      PaymentService paymentService =
                                          PaymentService(
                                        context: context,
                                        onPaymentError: () {},
                                        onPaymentSuccess:
                                            (PaymentSuccessResponse response) {
                                          debugPrint(
                                              'paymentResponse#${response.orderId}');

                                          setState(() {
                                            isloading = true; // Show loader
                                          });
                                          if (isloading) {
                                            loaderDailog();
                                          }
                                          // context.pop();

                                          Provider.of<PaymentVerifyViewModel>(
                                                  _savedContext,
                                                  listen: false)
                                              .paymentVerifyViewModelApi(
                                                  context: _savedContext,
                                                  userId:
                                                      widget.userId.toString(),
                                                  paymentId: response.paymentId,
                                                  razorpayOrderId:
                                                      response.orderId,
                                                  razorpaySignature:
                                                      response.signature)
                                              .then(
                                            (value) {
                                              if (value?.status.httpCode ==
                                                  '200') {
                                                print(
                                                    'payment verification is successfull${value?.data.transactionId}');
                                                debugPrint(response.orderId);
                                                debugPrint(
                                                  response.paymentId,
                                                );
                                                debugPrint(response.signature);
                                                //   // Prepare API request body
                                                Map<String, dynamic> data1 = {
                                                  "date": rental.date,
                                                  "pickupTime":
                                                      rental.pickupTime,
                                                  "bookerId": widget.userId,
                                                  "bookingForId": widget.userId,
                                                  "carType": rental.carType,
                                                  "kilometers":
                                                      rental.kilometers,
                                                  "hours": rental.hours,
                                                  "price": rental.totalPrice,
                                                  "transactionId":
                                                      value?.data.transactionId,
                                                  "offerCode": offerCode,
                                                  "discountAmount":
                                                      disAmount.toInt(),
                                                  "taxAmount": taxAmount,
                                                  "taxPercentage":
                                                      taxPercentage,
                                                  "totalPayableAmount":
                                                      discountedAmount == 0
                                                          ? payableAmount
                                                          : discountedAmount,
                                                  "pickUpLocation": rental
                                                      .pickUpLocation
                                                      .trim()
                                                      .replaceAll(
                                                          RegExp(r'\s+'), ' '),
                                                  "locationLatitude":
                                                      widget.latitude,
                                                  "locationLongitude":
                                                      widget.logitude
                                                };
                                                Provider.of<
                                                        RentalBookingViewModel>(
                                                  _savedContext,
                                                  listen: false,
                                                )
                                                    .rentalBookingViewModel(
                                                      context: _savedContext,
                                                      body: data1,
                                                      userId: widget.userId,
                                                    )
                                                    .then((onValue) {})
                                                    .catchError((error) {
                                                  print('error....$error');
                                                }).whenComplete(() {
                                                  setState(() {
                                                    isloading = false;
                                                  });
                                                });
                                              }
                                            },
                                          );

                                          // Call verify payment function after successful payment
                                          // _verifyPayment(context, response);
                                        },
                                      );

                                      paymentService.openCheckout(
                                          amount:
                                              double.parse(rental.totalPrice),
                                          taxAmount: taxAmount,
                                          taxPercentage: taxPercentage,
                                          discountAmount: disAmount,
                                          payableAmount: discountedAmount == 0
                                              ? payableAmount
                                              : discountedAmount,
                                          userId: widget.userId.toString(),
                                          coutryCode: profileUser?.countryCode,
                                          mobileNo: profileUser?.mobile,
                                          email: profileUser?.email);
                                    } else if ((checkBox == 2)) {
                                      debugPrint(
                                          "${rental.totalPrice} Booking Price3");
                                      context.push("/rentalForm/guestBooking",
                                          extra: {
                                            "date": rental.date,
                                            "pickUpLocation":
                                                rental.pickUpLocation,
                                            "price": rental.totalPrice,
                                            "hour": rental.hours,
                                            "carType": rental.carType,
                                            "bookerId": widget.userId,
                                            "kilometer": rental.kilometers,
                                            "pickUpTime": rental.pickupTime,
                                            "offerCode": offerCode ?? '',
                                            "discountAmount": disAmount.toInt(),
                                            "taxAmount": taxAmount,
                                            "taxPercentage": taxPercentage,
                                            "payableAmount":
                                                discountedAmount == 0
                                                    ? payableAmount
                                                    : discountedAmount,
                                            "longi": widget.logitude,
                                            "lati": widget.latitude
                                          });
                                    }
                                    checkBox = 0;
                                    context.pop();
                                  }));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => CustomAlertBox(
                                    height:
                                        AppDimension.getHeight(context) / 3.8,
                                    width: AppDimension.getWidth(context) * .85,
                                    heading: "Booking Alert",
                                    content:
                                        "You already have a booking on this date. Are you sure "
                                        "you want to proceed with this new booking?",
                                    leftBtnReq: true,
                                    rightBtnReq: true,
                                    widgetReq: false,
                                    leftBtnHeading: "No",
                                    rightBtnHeading: "Yes",
                                    btnWidthLeft: 100,
                                    btnWidthRight: 100,
                                    leftOnTap: () => context.pop(),
                                    rightOnTap: () {
                                      context.pop();
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _showAlertBox(context, () {
                                                setState(() {
                                                  debugPrint(
                                                      checkBox.toString());
                                                  // debugPrint("${rental.totalPrice} Booking Price");
                                                });
                                                if ((checkBox == 1)) {
                                                  PaymentService
                                                      paymentService =
                                                      PaymentService(
                                                    context: _savedContext,
                                                    onPaymentError: () {},
                                                    onPaymentSuccess:
                                                        (PaymentSuccessResponse
                                                            response) {
                                                      print(
                                                          'paymentResponse#${response.orderId}');
                                                      setState(() {
                                                        isloading =
                                                            true; // Show loader
                                                      });
                                                      if (isloading) {
                                                        loaderDailog();
                                                      }
                                                      // context.pop();
                                                      // if (!mounted) return;
                                                      Provider.of<PaymentVerifyViewModel>(
                                                              _savedContext,
                                                              listen: false)
                                                          .paymentVerifyViewModelApi(
                                                              context:
                                                                  _savedContext,
                                                              userId: widget
                                                                  .userId
                                                                  .toString(),
                                                              paymentId: response
                                                                  .paymentId,
                                                              razorpayOrderId:
                                                                  response
                                                                      .orderId,
                                                              razorpaySignature:
                                                                  response
                                                                      .signature)
                                                          .then(
                                                        (value) {
                                                          if (value?.status
                                                                  .httpCode ==
                                                              '200') {
                                                            print(
                                                                'payment verification is successfull${value?.data.transactionId}');
                                                            debugPrint(response
                                                                .orderId);
                                                            debugPrint(
                                                              response
                                                                  .paymentId,
                                                            );
                                                            debugPrint(response
                                                                .signature);
                                                            //   // Prepare API request body
                                                            Map<String, dynamic>
                                                                data1 = {
                                                              "date":
                                                                  rental.date,
                                                              "pickupTime": rental
                                                                  .pickupTime,
                                                              "bookerId":
                                                                  widget.userId,
                                                              "bookingForId":
                                                                  widget.userId,
                                                              "carType": rental
                                                                  .carType,
                                                              "kilometers": rental
                                                                  .kilometers,
                                                              "hours":
                                                                  rental.hours,
                                                              "price": rental
                                                                  .totalPrice,
                                                              "transactionId": value
                                                                  ?.data
                                                                  .transactionId,
                                                              "offerCode":
                                                                  offerCode,
                                                              "discountAmount":
                                                                  disAmount
                                                                      .toInt(),
                                                              "taxAmount":
                                                                  taxAmount,
                                                              "taxPercentage":
                                                                  taxPercentage,
                                                              "totalPayableAmount":
                                                                  discountedAmount ==
                                                                          0
                                                                      ? payableAmount
                                                                      : discountedAmount,
                                                              "pickUpLocation": rental
                                                                  .pickUpLocation
                                                                  .trim()
                                                                  .replaceAll(
                                                                      RegExp(
                                                                          r'\s+'),
                                                                      ' '),
                                                              "locationLatitude":
                                                                  widget
                                                                      .latitude,
                                                              "locationLongitude":
                                                                  widget
                                                                      .logitude
                                                            };
                                                            Provider.of<
                                                                    RentalBookingViewModel>(
                                                              _savedContext,
                                                              listen: false,
                                                            )
                                                                .rentalBookingViewModel(
                                                                  context:
                                                                      _savedContext,
                                                                  body: data1,
                                                                  userId: widget
                                                                      .userId,
                                                                )
                                                                .then(
                                                                    (onValue) {})
                                                                .catchError(
                                                                    (error) {
                                                              print(
                                                                  'error....$error');
                                                            }).whenComplete(() {
                                                              setState(() {
                                                                isloading =
                                                                    false;
                                                              });
                                                            });
                                                          }
                                                        },
                                                      );
                                                      // Call verify payment function after successful payment
                                                      // _verifyPayment(context, response);
                                                    },
                                                  );

                                                  paymentService.openCheckout(
                                                      amount: double.parse(
                                                          rental.totalPrice),
                                                      taxAmount: taxAmount,
                                                      taxPercentage:
                                                          taxPercentage,
                                                      discountAmount: disAmount,
                                                      payableAmount:
                                                          discountedAmount == 0
                                                              ? payableAmount
                                                              : discountedAmount,
                                                      userId: widget.userId
                                                          .toString(),
                                                      coutryCode: profileUser
                                                          ?.countryCode,
                                                      mobileNo:
                                                          profileUser?.mobile,
                                                      email:
                                                          profileUser?.email);
                                                } else if ((checkBox == 2)) {
                                                  debugPrint(
                                                      "${rental.totalPrice} Booking Price1");
                                                  context.push(
                                                      "/rentalForm/guestBooking",
                                                      extra: {
                                                        "date": rental.date,
                                                        "pickUpLocation": rental
                                                            .pickUpLocation,
                                                        "price":
                                                            rental.totalPrice,
                                                        "hour": rental.hours,
                                                        "carType":
                                                            rental.carType,
                                                        "bookerId":
                                                            widget.userId,
                                                        "kilometer":
                                                            rental.kilometers,
                                                        "pickUpTime":
                                                            rental.pickupTime,
                                                        "longi":
                                                            widget.logitude,
                                                        "lati": widget.latitude,
                                                        "offerCode":
                                                            offerCode ?? '',
                                                        "discountAmount":
                                                            disAmount.toInt(),
                                                        "taxAmount": taxAmount,
                                                        "taxPercentage":
                                                            taxPercentage,
                                                        "payableAmount":
                                                            discountedAmount ==
                                                                    0
                                                                ? payableAmount
                                                                : discountedAmount,
                                                      });
                                                }
                                                checkBox = 0;
                                                context.pop();
                                              }));
                                    },
                                  ));
                        }
                      },
                    ),
                    // Show loader when loading
                    // if (isloading)

                    //   Container(
                    //     // color: Colors.black.withOpacity(
                    //     //     0.5), // Optional: Dim the background
                    //     child: const Center(
                    //       child: CircularProgressIndicator(),
                    //     ),
                    //   ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _showAlertBox(BuildContext contextx, VoidCallback onTap) {
    return StatefulBuilder(
      builder: (contextx, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dialog(
              surfaceTintColor: background,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              backgroundColor: background,
              child: SizedBox(
                height: 250,
                // height: AppDimension.getHeight(context) / 3.2,
                // width: AppDimension.getWidth(context) / 2.5,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5))),
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 40,
                            height: 30,
                          ),
                          const CustomText(
                              content: "Confirm Booking",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              align: TextAlign.center,
                              textColor: background),
                          InkWell(
                              onTap: () {
                                checkBox = 0;
                                context.pop();
                              },
                              child: const SizedBox(
                                width: 40,
                                height: 35,
                                child: Icon(
                                  Icons.cancel,
                                  color: background,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      color: background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "Please select for whom you booking",
                              style: titleTextStyle,
                            ),
                          ),
                          // const SizedBox(height: 10,),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RadioButtonWithText(
                                    value: 1,
                                    text: "Self",
                                    groupValue: checkBox,
                                    onChanged: (value) {
                                      setState(() {
                                        checkBox = value;
                                      });
                                    },
                                  ),
                                  RadioButtonWithText(
                                    value: 2,
                                    text: "Someone Else",
                                    groupValue: checkBox,
                                    onChanged: (value) {
                                      setState(() {
                                        checkBox = value;
                                      });
                                    },
                                  ),
                                ],
                              )),
                          checkBox == 0
                              ? const SizedBox()
                              : Align(
                                  alignment: Alignment.center,
                                  child: CustomButtonSmall(
                                    borderRadius: BorderRadius.circular(5),
                                    width: 120,
                                    height: 40,
                                    btnHeading: checkBox == 1
                                        ? "Pay Now"
                                        : "Add Details",
                                    onTap: onTap,
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void loaderDailog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpinKitCircle(
                        size: 60,
                        color: btnColor,
                      ),
                      Text(
                        'Please wait..',
                        style: TextStyle(color: Colors.green),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // CircularProgressIndicator(
                      //   color: Colors.green,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class BookingContainer extends StatefulWidget {
  final String carName;
  final String pickTime;
  final String pickDate;
  final String price;
  final String hour;
  final String seats;
  final String totalPrice;
  final String kilometers;
  final bool loading;
  final String pickUpLocation;
  final TextEditingController couponController;
  final VoidCallback onCouponTap;
  final VoidCallback onCouponRemoveTap;
  final bool couponVisible;
  final VoidCallback onTap;
  final double discountedAmount;
  final double offerDisAmount;
  final double taxAmount;
  final double payableAmount;

  const BookingContainer(
      {this.carName = "",
      this.pickTime = "",
      this.pickDate = "",
      this.loading = false,
      this.hour = "",
      this.seats = "",
      this.price = "",
      this.totalPrice = "",
      this.kilometers = "",
      this.pickUpLocation = "",
      required this.couponController,
      required this.onTap,
      required this.onCouponTap,
      required this.onCouponRemoveTap,
      required this.couponVisible,
      required this.discountedAmount,
      required this.offerDisAmount,
      required this.taxAmount,
      required this.payableAmount,
      super.key});

  @override
  State<BookingContainer> createState() => _BookingContainerState();
}

class _BookingContainerState extends State<BookingContainer> {
  @override
  Widget build(BuildContext context) {
    debugPrint('payableAmount...............,,,, ${widget.payableAmount}');
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: naturalGreyColor.withOpacity(.3))),
            child: Column(
              children: [
                ///First Line of Design
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: curvePageColor))),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 60,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                rentalCar1,
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.carName,
                                    style: GoogleFonts.lato(
                                        color: greyColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Seats : ${widget.seats}",
                                    style: GoogleFonts.lato(
                                        color: greyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Hour : ${widget.hour}",
                                    style: GoogleFonts.lato(
                                        color: greyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Date : ${widget.pickDate}",
                                    style: GoogleFonts.lato(
                                        color: greyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),

                ///Second Line Design
                Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: curvePageColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 10,
                          // contentPadding:
                          //     const EdgeInsets.symmetric(horizontal: 10),
                          leading: Icon(Icons.edit_road),
                          title: Text(
                            "Kilometer",
                            style: titleText,
                          ),
                          subtitle:
                              Text('${widget.kilometers}/KM', style: titleText),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 10,
                          contentPadding: const EdgeInsets.only(left: 45),
                          leading: const Icon(Icons.lock_clock),
                          title: Text(
                            'Pickup Time',
                            style: titleText,
                          ),
                          subtitle: Text(
                            widget.pickTime,
                            style: titleText,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                ///Third Line Design
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: curvePageColor))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location : ",
                          style: titleText,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.pickUpLocation,
                          style: titleText,
                        )
                        // SizedBox(
                        //   width: AppDimension.getWidth(context) * .65,
                        //   child: CustomText(
                        //     content: widget.pickUpLocation,
                        //     align: TextAlign.start,
                        //     fontWeight: FontWeight.w400,
                        //     maxline: 10,
                        //     fontSize: 16,
                        //   ),
                        // )
                        // Text(
                        //   pickUpLocation,
                        //   style: titleTextStyle,
                        // ),
                      ],
                    )),

                ///Forth Line Design
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rental Amount',
                            style: titleText,
                          ),
                          Text(
                            "AED ${widget.totalPrice}",
                            style: titleText,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax Amount  (5 %)',
                            style: titleText,
                          ),
                          Text(
                            "+ AED ${widget.taxAmount}",
                            style: titleText,
                          ),
                        ],
                      ),
                      widget.discountedAmount == 0
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Save Amount',
                                  style: titleText,
                                ),
                                Text(
                                  "- AED ${widget.offerDisAmount.toInt()}",
                                  style: titleText,
                                ),
                              ],
                            ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payable Amount ',
                            style: pageHeadingTextStyle,
                          ),
                          Text(
                            widget.discountedAmount == 0
                                ? 'AED ${widget.payableAmount.toInt()}'
                                : "AED ${widget.discountedAmount.toInt()}",
                            style: pageHeadingTextStyle,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "(Inclusive of Taxes)",
                          style: titleTextStyle1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: background,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: naturalGreyColor.withOpacity(.3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Customtextformfield(
                          controller: widget.couponController,
                          readOnly: widget.couponVisible ? true : false,
                          hintText: 'Coupon code'),
                    ),
                    const SizedBox(width: 10),
                    widget.couponVisible
                        ? CustomButtonSmall(
                            // disable: widget.couponVisible ?? false,
                            height: 45,
                            width: 80,
                            btnHeading: 'Remove',
                            onTap: widget.onCouponRemoveTap)
                        : CustomButtonSmall(
                            // disable: widget.couponVisible ?? false,
                            height: 45,
                            width: 80,
                            btnHeading: 'Apply',
                            onTap: widget.onCouponTap)
                  ],
                ),
                widget.couponVisible
                    ? Text(
                        'Congrats!  You have availed discount of AED ${widget.offerDisAmount.toInt()}.',
                        style: TextStyle(color: greenColor),
                      )
                    : Container()
              ],
            ),
          ),
          const SizedBox(height: 15),

          ///Benefits and Tax Details
          Material(
            elevation: 0,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: background,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: naturalGreyColor.withOpacity(.3))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      content:
                          "Cab and driver details. will be shared up to 30 min prior to departure.",
                      fontSize: 16,
                      maxline: 2,
                      align: TextAlign.start,
                      fontWeight: FontWeight.w400,
                      textColor: textColor),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Material(
            elevation: 0,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: background,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: naturalGreyColor.withOpacity(.3))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          content: "Estimated Fare",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w700,
                          textColor: textColor),
                      CustomText(
                          content: "AED 1800",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      CustomText(
                          content: "Applied rate card",
                          fontSize: 16,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w700,
                          textColor: textColor),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          content: "Base fare1 hr 10 km",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                      CustomText(
                          content: "AED 1800",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          content: "Extra km fare after 10 km",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                      CustomText(
                          content: "AED 15 per km",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          content: "Extra ride time fare after 1 hr",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                      CustomText(
                          content: "AED 3 per min",
                          fontSize: 16,
                          maxline: 2,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w600,
                          textColor: textColor),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomText(
                      maxline: 5,
                      align: TextAlign.start,
                      fontSize: 16,
                      textColor: blackColor,
                      content:
                          "Extra charges on exceeding package. GST and Toll, if applicable, will"
                          " be added to the bill. Please pay parking as and when required. "
                          "Base fare amount is the minimum bill amount a customer has to pay for package.")
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButtonSmall(
              height: 40,
              width: AppDimension.getWidth(context) * .25,
              loading: widget.loading,
              btnHeading: "Book Now",
              onTap: widget.onTap,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ConfirmationAlertBox extends StatelessWidget {
  final VoidCallback onTap;

  const ConfirmationAlertBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      backgroundColor: background,
      child: SizedBox(
        height: AppDimension.getHeight(context) * .2,
        width: AppDimension.getWidth(context) * .85,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  const CustomTextWidget(
                      content: "Booking Confirmation",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textColor: background),
                  SizedBox(
                    width: 30,
                    height: 40,
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: background,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: CustomTextWidget(
                        content: "Are Your Sure Want Booking ?",
                        fontSize: 15,
                        align: TextAlign.start,
                        fontWeight: FontWeight.w600,
                        textColor: textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButtonSmall(
                      width: AppDimension.getWidth(context) * .25,
                      btnHeading: "Confirm",
                      onTap: onTap,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessAlertBox extends StatelessWidget {
  final VoidCallback onTap;

  const SuccessAlertBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      backgroundColor: background,
      child: SizedBox(
        height: AppDimension.getHeight(context) / 3.2,
        width: AppDimension.getWidth(context) * .5,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
                color: greenColor,
              ),
              width: double.infinity,
              height: 100,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Card(
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.check,
                      color: greenColor,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  const CustomTextWidget(
                      content: "Your Booking Successfully Booked",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textColor: textColor),
                  const SizedBox(height: 40),
                  CustomButtonSmall(btnHeading: "OK", onTap: onTap)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
