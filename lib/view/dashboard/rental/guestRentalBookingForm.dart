import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20%20Button/customdropdown_button.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customPhoneField.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/custom_mobileNumber.dart';
import 'package:flutter_cab/res/validationTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:flutter_cab/view_model/services/paymentService.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  final String offerCode;
  final double discountAmount;
  final double taxAmount;
  final double taxPercentage;
  final double payableAmount;

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
      required this.lati,
      required this.offerCode,
      required this.discountAmount,
      required this.taxAmount,
      required this.taxPercentage,
      required this.payableAmount});

  @override
  State<GuestRentalBookingForm> createState() => _GuestRentalBookingFormState();
}

class _GuestRentalBookingFormState extends State<GuestRentalBookingForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> controller =
      List.generate(3, (index) => TextEditingController());
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();

  // String countryCode = 'AE';
  String countryCode = '971';

  bool loader = false;
  bool isloading = false;
  var profileUser;
  @override
  void dispose() {
    // TODO: implement dispose
    controller[0].dispose();
    controller[1].dispose();
    controller[2].dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();

    super.dispose();
  }

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
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Guest Name', style: titleTextStyle),
              const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: redColor,
                  ))
            ])),
            const SizedBox(
              height: 5,
            ),
            Customtextformfield(
              focusNode: focusNode1,
              controller: controller[0],
              fillColor: background,
              hintText: 'Enter your name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Gender', style: titleTextStyle),
              const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: redColor,
                  ))
            ])),
            const SizedBox(
              height: 5,
            ),
            CustomDropdownButton(
              focusNode: focusNode2,
              itemsList: ['Male', 'Female'],
              hintText: 'Select gender',
              controller: controller[2],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }
                return null;
              },
            ),
            // ValidationTextField(
            //     focusNode: focusNode1,
            //     headingReq: true,
            //     prefixIcon: true,
            //     width: double.infinity,
            //     validation: true,
            //     img: user,
            //     hint: "Enter your name",
            //     heading: "Guest Name",
            //     controller: controller[0]),
            // const SizedBox(height: 5),
            // FormCommonSingleAlertSelector(
            //   title: "Gender",
            //   controller: controller[2],
            //   elevation: 0,
            //   width: double.infinity,
            //   textStyle: titleTextStyle,
            //   showIcon: const Icon(
            //     Icons.event_seat,
            //     color: naturalGreyColor,
            //   ),
            //   iconReq: false,
            //   data: const ["Male", "Female"],
            //   // icons: gender,
            //   icon: genderImg,
            //   border: false,

            //   ///Hint Color
            //   initialValue: "Select Gender",
            //   alertBoxTitle: "Select Gender",
            // ),
            const SizedBox(
              height: 5,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Contact No', style: titleTextStyle),
              const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: redColor,
                  ))
            ])),
            const SizedBox(
              height: 5,
            ),
            CustomMobilenumber(
                focusNode: focusNode3,
                textLength: 9,
                controller: controller[1],
                hintText: 'Enter phone number',
                fillColor: background,
                countryCode: countryCode),
            // Customphonefield(
            //   initalCountryCode: countryCode,
            //   controller: controller[1],
            //   focusNode: focusNode3,
            //   onChanged: (phoneNumber) {
            //     countryCode =
            //         phoneNumber.countryCode.replaceFirst("+", '').trim();
            //     debugPrint('phone number$countryCode');
            //     // primaryNoController.text = phoneNumber.number;
            //   },
            //   onCountryChanged: (country) {
            //     countryCode = country.dialCode;
            //   },
            //   validator: (p0) {
            //     return null;
            //   },
            // ),
            const Spacer(),
            CustomButtonBig(
              btnHeading: "Book Now",
              loading: status == "Status.loading" && loader,
              onTap: () async {
                // if (controller[0].text.isEmpty) {
                //   Utils.toastMessage("Kindly Enter Name");
                // } else if (controller[1].text.isEmpty) {
                //   Utils.toastMessage("Kindly Enter Mobile No.");
                // } else if (int.tryParse(controller[1].text) == 0) {
                //   Utils.toastMessage("Kindly Enter Valid Mobile No.");
                // } else if (controller[2].text.isEmpty) {
                //   Utils.toastMessage("Kindly Select Gender");
                // } else

                if (_formKey.currentState!.validate()) {
                  setState(() {
                    loader = true;
                  });
                  FocusScope.of(context).unfocus();
                  focusNode1.unfocus();
                  focusNode2.unfocus();
                  focusNode3.unfocus();
                  double amt = double.parse(widget.price);
                  PaymentService paymentService = PaymentService(
                    context: context,
                    onPaymentError: () {
                      setState(() {
                        loader = false;
                      });
                    },
                    onPaymentSuccess: (PaymentSuccessResponse response) {
                      print('paymentResponse#${response.orderId}');

                      Provider.of<PaymentVerifyViewModel>(context,
                              listen: false)
                          .paymentVerifyViewModelApi(
                              context: context,
                              userId: widget.bookerId.toString(),
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
                            //   // Prepare API request body
                            Map<String, dynamic> body = {
                              "date": widget.date,
                              "pickupTime": widget.pickUpTime,
                              "bookerId": widget.bookerId,
                              "carType": widget.carType,
                              "kilometers": widget.kilometer,
                              "hours": widget.hour,
                              "price": widget.price,
                              "transactionId": value?.data.transactionId,
                              "pickUpLocation": widget.pickUpLocation,
                              "guestName": controller[0].text,
                              "countryCode": countryCode,
                              "guestMobile": controller[1].text,
                              "gender": controller[2].text,
                              "locationLatitude": widget.lati,
                              "locationLongitude": widget.longi,
                              "offerCode": widget.offerCode,
                              "discountAmount": widget.discountAmount,
                              "taxAmount": widget.taxAmount,
                              "taxPercentage": widget.taxPercentage,
                              "totalPayableAmount":
                                  widget.payableAmount.toInt(),
                            };
                            Provider.of<RentalBookingViewModel>(
                              context,
                              listen: false,
                            )
                                .rentalBookingViewModel(
                                  context: context,
                                  body: body,
                                  userId: widget.bookerId,
                                )
                                .then((onValue) {})
                                .catchError((error) {
                              print('error....$error');
                            });
                            // .whenComplete(() {
                            //   setState(() {
                            //     isloading = false;
                            //   });
                            // });
                          }
                        },
                      );
                      // Call verify payment function after successful payment
                      // _verifyPayment(context, response);
                    },
                  );

                  paymentService.openCheckout(
                      amount: widget.discountAmount == 0
                          ? widget.payableAmount
                          : widget.discountAmount,
                      userId: widget.bookerId.toString(),
                      coutryCode: profileUser?.countryCode,
                      mobileNo: profileUser?.mobile,
                      email: profileUser?.email);
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
