import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentalCarBooking extends StatefulWidget {
  final String data;
  // final String logi;
  // final String lati;
  const RentalCarBooking({
    super.key,
    required this.data,
    // required this.logi, required this.lati
  });

  @override
  State<RentalCarBooking> createState() => _RentalCarBookingState();
}

class _RentalCarBookingState extends State<RentalCarBooking> {
  List<TextEditingController> controller =
      List.generate(1, (index) => TextEditingController());
  var data1, vehicleData;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    var status = context
        .watch<RentalBookingCancelViewModel>()
        .cancelldataList
        .status
        .toString();

    // if(status == "Status.completed"){
    data1 = context.watch<RentalBookingViewModel>().DataList.data?.data ?? "";

    return Scaffold(
      appBar: CustomAppBar(
        heading: "Booked Ride",
        rightIconImage: history,
        rightIconOnTapReq: true,
        rightIconOnTapOnTap: () => context
            .push('/rentalForm/rentalHistory', extra: {'myIdNo': widget.data}),
      ),
      body: PageLayout_Page(
          addtionalIconReq: true,
          addtionalIcon: history,
          // iconOnTap: () => ,
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BookingContainer(
                    carName: data1.carType,
                    pickDate: data1.date,
                    hour: data1.totalRentTime,
                    pickTime: data1.pickupTime,
                    seats: "",
                    id: data1.id,
                    kilometer: data1.kilometers,
                    status: data1.bookingStatus,
                    rentalCharge: data1.rentalCharge,
                    bookingId: data1.rentalBookingId,
                    // scheduleTap: () {
                    //
                    // },
                    cancelTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => CancelContainerDialog(
                                loading: status == "Status.loading" && load,
                                controllerCancel: controller[0],
                                onTap: () {
                                  load = true;
                                  if (controller[0].text.isEmpty ||
                                      controller[0].text == 'null') {
                                    Utils.toastMessage(
                                        "Please enter the reason");
                                  } else {
                                    // Provider.of<RentalBookingCancelViewModel>(
                                    //         context,
                                    //         listen: false)
                                    //     .fetchRentalBookingCancelViewModelApi(
                                    //         context,
                                    //         {
                                    //           "id": data1.id,
                                    //           "reason": controller[0].text
                                    //         },
                                    //         data1.carType);
                                    // context.pop();
                                    // context.pop();
                                  }
                                },
                              ));
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class BookingContainer extends StatelessWidget {
  final String carName;
  final String pickDate;
  final String pickTime;
  final String hour;
  final String seats;
  final String id;
  final String kilometer;
  final String status;
  final String rentalCharge;
  final String bookingId;
  final String pessfirstName;
  final String pesslastName;
  final String email;
  final String mobile;
  final VoidCallback cancelTap;

  const BookingContainer({
    super.key,
    required this.carName,
    required this.pickDate,
    required this.pickTime,
    required this.hour,
    required this.seats,
    required this.id,
    required this.kilometer,
    required this.status,
    required this.rentalCharge,
    required this.bookingId,
    this.pessfirstName = "",
    this.pesslastName = "",
    this.email = "",
    this.mobile = "",
    required this.cancelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: AppDimension.getHeight(context) * .5,
        width: AppDimension.getWidth(context) * .9,
        // padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: btnColor,
                  border: Border(bottom: BorderSide(color: greyColor))),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Review Booking",
                    style: GoogleFonts.lato(
                        color: background,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            // Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       "",
            //       style: titleTextStyle,
            //     )),
            Container(
              // height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: greyColor))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Car : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: carName,
                              style: loginTextStyle,
                            ),
                          ])),
                      const SizedBox(height: 5),
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Hour : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: "$hour Hr",
                              style: loginTextStyle,
                            ),
                          ])),
                      const SizedBox(height: 5),
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Seats : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: seats,
                              style: loginTextStyle,
                            ),
                          ])),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Date : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: pickDate,
                              style: loginTextStyle,
                            ),
                          ])),
                      const SizedBox(height: 5),
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Time : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: pickTime,
                              style: loginTextStyle,
                            ),
                          ])),
                      const SizedBox(height: 5),
                      RichText(
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Kilometer : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: "$kilometer/KM",
                              style: loginTextStyle,
                            ),
                          ])),
                    ],
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Booking Details",
                  style: titleTextStyle,
                )),

            ///3rd Container
            Container(
              // height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: greyColor))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Id : ",
                                  style: titleTextStyle,
                                ),
                                TextSpan(
                                  text: id,
                                  style: loginTextStyle,
                                ),
                              ])),
                          const SizedBox(height: 5),
                          RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Status : ",
                                  style: titleTextStyle,
                                ),
                                TextSpan(
                                  text: status,
                                  style: loginTextStyle,
                                ),
                              ])),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Rental Charge : ",
                                  style: titleTextStyle,
                                ),
                                TextSpan(
                                  text: rentalCharge,
                                  style: loginTextStyle,
                                ),
                              ])),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Booking ID : ",
                          style: titleTextStyle,
                        ),
                        TextSpan(
                          text: bookingId,
                          style: loginTextStyle,
                        ),
                      ])),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Passenger Name : ",
                          style: titleTextStyle,
                        ),
                        TextSpan(
                          text: "$pessfirstName $pesslastName",
                          style: loginTextStyle,
                        ),
                      ])),
                  const SizedBox(height: 5),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Contact : ",
                          style: titleTextStyle,
                        ),
                        TextSpan(
                          text: mobile,
                          style: loginTextStyle,
                        ),
                      ])),
                  const SizedBox(height: 5),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "Email : ",
                          style: titleTextStyle,
                        ),
                        TextSpan(
                          text: email,
                          style: loginTextStyle,
                        ),
                      ])),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonSmall(
                    width: AppDimension.getWidth(context) * .85,
                    btnHeading: "Cancel",
                    onTap: cancelTap),
                // CustomButtonSmall(
                //   width: AppDimension.getWidth(context)*.42,
                //   btnHeading: "Schedule",
                //   onTap: scheduleTap)
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

class CancelContainerDialog extends StatefulWidget {
  final TextEditingController controllerCancel;

  final VoidCallback onTap;
  final bool loading;
  const CancelContainerDialog(
      {required this.controllerCancel,
      this.loading = false,
      required this.onTap,
      super.key});

  @override
  State<CancelContainerDialog> createState() => _CancelContainerDialogState();
}

class _CancelContainerDialogState extends State<CancelContainerDialog> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // return StatefulBuilder(
    //   builder: (BuildContext context, StateSetter setState) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        decoration: const BoxDecoration(
            color: background,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // height: AppDimension.getHeight(context)*.4,
        padding: const EdgeInsets.only(bottom: 10),
        width: AppDimension.getWidth(context) * .9,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 30,
                        width: 30,
                      ),
                      const CustomTextWidget(
                        content: "Cancel Booking",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: background,
                      ),
                      Material(
                        color: btnColor,
                        child: InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(2),
                              height: 30,
                              width: 30,
                              child: const Icon(
                                Icons.close,
                                color: background,
                              )),
                        ),
                      ),
                    ],
                  )
                  // const Center(
                  //   child:
                  // ),
                  ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CustomTextWidget(
                          content: "Reason for cancel booking",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: greyColor,
                        ),
                        Text(
                          ' *',
                          style: TextStyle(color: redColor),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Customtextformfield(
                      minLines: 4,
                      maxLines: 4,
                      textLength: 120,
                      controller: widget.controllerCancel,
                      hintText: 'Reason for cancellation',
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Please enter your reason';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButtonSmall(
                            loading: widget.loading,
                            height: 40,
                            width: 120,
                            // widht: AppDimension.getWidth(context) * .25,
                            btnHeading: "Submit",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                print('bncbjcxbcmnnc');
                                widget.onTap();
                              }
                            }),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // },
    // );
  }
}
