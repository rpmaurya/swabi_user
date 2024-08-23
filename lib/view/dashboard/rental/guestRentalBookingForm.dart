import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/res/razorPay_payment.dart';
import 'package:flutter_cab/res/validationTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookingData {
  final String date;
  final String pickUpTime;
  final String bookerId;
  final String carType;
  final String kilometer;
  final String hour;
  final String price;
  final String pickUpLocation;

  BookingData({
    required this.date,
    required this.pickUpTime,
    required this.bookerId,
    required this.carType,
    required this.kilometer,
    required this.hour,
    required this.price,
    required this.pickUpLocation,
  });
}

class GuestRentalBookingForm extends StatefulWidget {
  // final BookingData data;
  final String date;
  final String pickUpTime;
  final String bookerId;
  final String carType;
  final String kilometer;
  final String hour;
  final String price;
  final String pickUpLocation;
  final String longi;
  final String lati;

  const GuestRentalBookingForm(
      {super.key,
      // required this.data,
      required this.date,
      required this.pickUpTime,
      required this.bookerId,
      required this.carType,
      required this.kilometer,
      required this.hour,
      required this.price,
      required this.pickUpLocation,
      required this.longi,
      required this.lati});

  @override
  State<GuestRentalBookingForm> createState() => _GuestRentalBookingFormState();
}

class _GuestRentalBookingFormState extends State<GuestRentalBookingForm> {
  List<TextEditingController> controller =
      List.generate(3, (index) => TextEditingController());
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();

  bool loader = false;
  bool isloading = false;
  var profileUser;
  @override
  Widget build(BuildContext context) {
    String status =
        context.watch<RentalBookingViewModel>().DataList.status.toString();
    profileUser = context.watch<UserProfileViewModel>().DataList.data?.data;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Guest Detail",
      ),
      body: PageLayout_Page(
          child: Container(
        child: Column(
          children: [
            // CustomTextFeild(
            //   prefixIcon: true,
            //     img: user,
            //     width: double.infinity,
            //     headingReq: true,
            //     hint: "Enter your name",
            //     heading: "Guest Name",
            //     controller: controller[0]),
            ValidationTextField(
                focusNode: focusNode1,
                headingReq: true,
                prefixIcon: true,
                width: double.infinity,
                validation: true,
                img: user,
                hint: "Enter your name",
                heading: "Guest Name",
                controller: controller[0]),
            const SizedBox(height: 10),
            CustomTextFeild(
                focusNode: focusNode2,
                width: double.infinity,
                prefixIcon: true,
                img: contact,
                number: true,
                hint: "XXXXXXXXXX",
                headingReq: true,
                heading: "Mobile",
                controller: controller[1]),
            const SizedBox(height: 10),
            FormCommonSingleAlertSelector(
              title: "Gender",
              controller: controller[2],
              elevation: 0,
              width: double.infinity,
              textStyle: titleTextStyle,
              showIcon: const Icon(
                Icons.event_seat,
                color: naturalGreyColor,
              ),
              iconReq: false,
              data: const ["Male", "Female"],
              // icons: gender,
              icon: genderImg,
              border: true,

              ///Hint Color
              initialValue: "Select Gender",
              alertBoxTitle: "Select Gender",
            ),
            // CustomDropDownButton(
            //   controller: controller[2],
            //   hint: "Select Gender",
            //   width:double.infinity,
            //   title: "Gender",
            //   dropDownValues: const ["Male","Female"],
            //   iconReq: false,
            //   iconImg: gender,
            //   iconImgReq: true,
            //   icon: const Icon(Icons.ac_unit_outlined),
            //   selectedValue: "",
            //   // selectedValue: "2 Hr 30 KM",
            //   onTap: () {
            //   },
            //   headingReq: true,
            // ),
            const Spacer(),
            CustomButtonBig(
              btnHeading: "Book",
              loading: status == "Status.loading" && loader,
              onTap: () async {
                if (controller[0].text.isEmpty) {
                  Utils.flushBarErrorMessage("Kindly Enter Name", context);
                } else if (controller[1].text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      "Kindly Enter Mobile No.", context);
                } else if (controller[2].text.isEmpty) {
                  Utils.flushBarErrorMessage("Kindly Select Gender", context);
                } else {
                  loader = true;
                  double amt = double.parse(widget.price);
                  if (!mounted) return;
                  BuildContext dialogContext = context;
                  // Show the second dialog
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return RazorpayPayment(
                        userId: widget.bookerId,
                        amount: amt,
                        email: profileUser.email,
                        coutryCode: profileUser.countryCode,
                        mobileNo: profileUser.mobile,
                      );
                    },
                  ).then((_) async {
                    if (!mounted) return;
                    // setState(() {
                    //   isloading = true; // Show loader
                    // });
                    // if (isloading) {
                    //   loaderDailog();
                    // }
                    // Retrieve transaction ID
                    var transactionId =
                        await Provider.of<PaymentVerifyViewModel>(
                              context,
                              listen: false,
                            ).paymentVerify.data?.data.transactionId ??
                            '';

                    // Prepare API request body
                    Map<String, dynamic> body = {
                      "date": widget.date,
                      "pickupTime": widget.pickUpTime,
                      "bookerId": widget.bookerId,
                      "carType": widget.carType,
                      "kilometers": widget.kilometer,
                      "hours": widget.hour,
                      "price": widget.price,
                      "transactionId": transactionId,
                      "pickUpLocation": widget.pickUpLocation,
                      "guestName": controller[0].text,
                      "guestMobile": controller[1].text,
                      "gender": controller[2].text,
                      "locationLatitude": widget.lati,
                      "locationLongitude": widget.longi
                    };

                    if (mounted) {
                      setState(() {
                        print("${body}bodydata1");
                      });

                      // Perform booking API call
                      await Provider.of<RentalBookingViewModel>(
                        context,
                        listen: false,
                      )
                          .rentalBookingViewModel(
                            context: context,
                            body: body,
                            userId: widget.bookerId,
                          )
                          .then((onValue) {});
                      //   .catchError((onError) {})
                      //   .whenComplete(() {
                      // setState(() {
                      //   isloading = false;
                      // });
                      // });
                    }
                  });
                }
              },
            )
          ],
        ),
      )),
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
