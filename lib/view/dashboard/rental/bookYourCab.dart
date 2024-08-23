import 'package:flutter/material.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/customAlertBox.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/razorPay_payment.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rentalHistoryManagment.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookYourCab extends StatefulWidget {
  final String carType;
  final String userId;
  final String bookingDate;
  // final int totalAmt;
  final String logitude;
  final String latitude;

  const BookYourCab({
    super.key,
    required this.carType,
    required this.userId,
    required this.logitude,
    required this.latitude,
    required this.bookingDate,
    // required this.totalAmt
  });

  @override
  State<BookYourCab> createState() => _BookYourCabState();
}

class _BookYourCabState extends State<BookYourCab> {
  List<TextEditingController> controller =
      List.generate(9, (index) => TextEditingController());

  List rentalBooking = ['Self', "Someone Others"];
  TextEditingController checkControler = TextEditingController();

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

  @override
  void dispose() {
    // Do not use context directly here; use _safeContext instead
    super.dispose();
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
          SizedBox(
            height: AppDimension.getHeight(context) * .9,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredData.length,
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
                        onTap: () {
                          double amt = double.parse(rental.totalPrice);

                          ////
                          if (rentalValidation.toString().isNotEmpty &&
                              rentalValidation == "Success") {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    _showAlertBox(context, () async {
                                      if (!mounted) return;

                                      setState(() {
                                        debugPrint(checkBox.toString());
                                      });
                                      if (checkBox == 1) {
                                        print(
                                            ',nmnmnmnmnm,m,m,m.................');
                                        await Future.delayed(
                                            Duration(milliseconds: 100));
                                        if (!mounted) return;

                                        // Show the second dialog
                                        await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return RazorpayPayment(
                                              userId: widget.userId,
                                              amount: amt,
                                              email: profileUser.email,
                                              coutryCode:
                                                  profileUser.countryCode,
                                              mobileNo: profileUser.mobile,
                                            );
                                          },
                                        ).then((_) async {
                                          if (!mounted) return;
                                          setState(() {
                                            isloading = true; // Show loader
                                          });
                                          if (isloading) {
                                            loaderDailog();
                                          }
                                          // Retrieve transaction ID
                                          var transactionId = await Provider.of<
                                                      PaymentVerifyViewModel>(
                                                context,
                                                listen: false,
                                              )
                                                  .paymentVerify
                                                  .data
                                                  ?.data
                                                  .transactionId ??
                                              '';

                                          debugPrint(
                                              "${rental.totalPrice} Booking Price2");

                                          // Prepare API request body
                                          Map<String, dynamic> data1 = {
                                            "date": rental.date,
                                            "pickupTime": rental.pickupTime,
                                            "bookerId": widget.userId,
                                            "bookingForId": widget.userId,
                                            "carType": rental.carType,
                                            "kilometers": rental.kilometers,
                                            "hours": rental.hours,
                                            "price": rental.totalPrice,
                                            "transactionId": transactionId,
                                            "pickUpLocation": rental
                                                .pickUpLocation
                                                .trim()
                                                .replaceAll(
                                                    RegExp(r'\s+'), ' '),
                                            "locationLatitude": widget.latitude,
                                            "locationLongitude": widget.logitude
                                          };

                                          if (mounted) {
                                            setState(() {
                                              print("${data1}Data1");
                                            });

                                            // Perform booking API call

                                            await Provider.of<
                                                    RentalBookingViewModel>(
                                              context,
                                              listen: false,
                                            )
                                                .rentalBookingViewModel(
                                                  context: context,
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
                                        });
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
                                      width:
                                          AppDimension.getWidth(context) * .85,
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
                                            builder: (context) => _showAlertBox(
                                                    context, () async {
                                                  setState(() {
                                                    debugPrint(
                                                        checkBox.toString());
                                                    // debugPrint("${rental.totalPrice} Booking Price");
                                                  });
                                                  if ((checkBox == 1)) {
                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds: 100));
                                                    if (!mounted) return;

                                                    // Show the second dialog
                                                    await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return RazorpayPayment(
                                                          userId: widget.userId,
                                                          amount: amt,
                                                          email:
                                                              profileUser.email,
                                                          coutryCode:
                                                              profileUser
                                                                  .countryCode,
                                                          mobileNo: profileUser
                                                              .mobile,
                                                        );
                                                      },
                                                    ).then((_) async {
                                                      if (!mounted) return;
                                                      setState(() {
                                                        isloading =
                                                            true; // Show loader
                                                      });
                                                      if (isloading) {
                                                        loaderDailog();
                                                      }
                                                      // Retrieve transaction ID
                                                      var transactionId =
                                                          await Provider.of<
                                                                      PaymentVerifyViewModel>(
                                                                context,
                                                                listen: false,
                                                              )
                                                                  .paymentVerify
                                                                  .data
                                                                  ?.data
                                                                  .transactionId ??
                                                              '';

                                                      debugPrint(
                                                          "${rental.totalPrice} Booking Price2");

                                                      // Prepare API request body
                                                      Map<String, dynamic>
                                                          data1 = {
                                                        "date": rental.date,
                                                        "pickupTime":
                                                            rental.pickupTime,
                                                        "bookerId":
                                                            widget.userId,
                                                        "bookingForId":
                                                            widget.userId,
                                                        "carType":
                                                            rental.carType,
                                                        "kilometers":
                                                            rental.kilometers,
                                                        "hours": rental.hours,
                                                        "price":
                                                            rental.totalPrice,
                                                        "transactionId":
                                                            transactionId,
                                                        "pickUpLocation": rental
                                                            .pickUpLocation
                                                            .trim()
                                                            .replaceAll(
                                                                RegExp(r'\s+'),
                                                                ' '),
                                                        "locationLatitude":
                                                            widget.latitude,
                                                        "locationLongitude":
                                                            widget.logitude
                                                      };

                                                      if (mounted) {
                                                        setState(() {
                                                          print(
                                                              "${data1}Data1");
                                                        });

                                                        // Perform booking API call
                                                        await Provider.of<
                                                                RentalBookingViewModel>(
                                                          context,
                                                          listen: false,
                                                        )
                                                            .rentalBookingViewModel(
                                                          context: context,
                                                          body: data1,
                                                          userId: widget.userId,
                                                        )
                                                            .then((onValue) {
                                                          if (onValue?.status
                                                                  .httpCode ==
                                                              '200') {
                                                            print(
                                                                'cvbmbmnbnbnbnbnbnb');
                                                          }
                                                        }).catchError((error) {
                                                          print(
                                                              'error....$error');
                                                        }).whenComplete(() {
                                                          setState(() {
                                                            isloading == false;
                                                          });
                                                        });
                                                      }
                                                    });
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
                                                          "lati":
                                                              widget.latitude
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
          ),
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
                                    text: "Someone Other",
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
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Please wait..',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class BookingContainer extends StatelessWidget {
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

  final VoidCallback onTap;

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
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border:
                          Border(bottom: BorderSide(color: curvePageColor))),
                  child: ListTile(
                    leading: SizedBox(
                      width: 80,
                      height: 60,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            rentalCar1,
                            fit: BoxFit.cover,
                          )),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          carName,
                          style: GoogleFonts.lato(
                              color: greyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Date : $pickDate",
                          style: GoogleFonts.lato(
                              color: greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hour : $hour",
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Timing : $pickTime",
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        // Text(
                        //   "Seats : $seats",
                        //   style: GoogleFonts.lato(
                        //       color: greyColor,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w600),
                        // ),
                      ],
                    ),
                  )),

              ///Second Line Design
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: curvePageColor))),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.edit_road)
                                // Image.asset(
                                //   fuel,
                                // ),
                                )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Kilometer",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            kilometers,
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  seat,
                                ),
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Seats",
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              seats,
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///Third Line Design
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: curvePageColor))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location : ",
                        style: titleTextStyle,
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: AppDimension.getWidth(context) * .65,
                        child: CustomText(
                          content: pickUpLocation,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w400,
                          maxline: 10,
                          fontSize: 16,
                        ),
                      )
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AED $totalPrice",
                              style: appbarTextStyle,
                            ),
                            Text(
                              "Inclusive of GST",
                              style: titleTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomButtonSmall(
                          height: 40,
                          width: AppDimension.getWidth(context) * .25,
                          loading: loading,
                          btnHeading: "Book Now",
                          onTap: onTap,
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                CustomTextWidget(
                    content: "Driver & Cab details?",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: textColor),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                    content:
                        "Cab and driver details? will be shared up to 30 min prior to departure.",
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
        )
      ],
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
