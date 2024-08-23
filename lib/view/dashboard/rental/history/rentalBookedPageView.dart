import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/multi_imageSlider_ContainerWidget.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view/dashboard/rental/carBooking.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../utils/text_styles.dart';

class RentalBookedPageView extends StatefulWidget {
  final String bookedId;
  final String useriD;

  const RentalBookedPageView(
      {super.key, required this.bookedId, required this.useriD});

  @override
  State<RentalBookedPageView> createState() => _RentalBookedPageViewState();
}

class _RentalBookedPageViewState extends State<RentalBookedPageView> {
  TextEditingController controller = TextEditingController();
  var fulldata, userData, vehicleDetails, driverDetails, guestDetails;
  bool loading = false;

  // List<String> vehicleImage = [];
  @override
  Widget build(BuildContext context) {
    String cancelledStatus = context
        .watch<RentalBookingCancelViewModel>()
        .DataList
        .status
        .toString();
    String status = context
        .watch<RentalBookingListViewModel>()
        .rentalBookingList
        .status
        .toString();
    fulldata =
        context.watch<RentalViewDetailViewModel>().DataList.data?.data ?? "";
    userData =
        context.watch<RentalViewDetailViewModel>().DataList.data?.data.user ??
            "";
    guestDetails =
        context.watch<RentalViewDetailViewModel>().DataList.data?.data.guest ??
            "";
    vehicleDetails = context.watch<RentalViewDetailViewModel>().DataList.data?.data.vehicle ?? "";
    driverDetails =
        context.watch<RentalViewDetailViewModel>().DataList.data?.data.driver ??
            "";
    print("${driverDetails.firstName}Name");
    print("${vehicleDetails.carName}Name");
    // vehicleImage = context.watch<RentalViewDetailViewModel>().DataList.data?.data.driver ?? "";
    // debugPrint("$fulldata FUll Data");
    // debugPrint("${widget.bookedId}Data of IDD h ye");
    ///Vehicle Details Sub Data
    // String vehicleString = vehicleDetails.replaceAll('{', '').replaceAll('}', '');
    // List<String> vehicleAttributes = vehicleString.split(", ");
    // Map<String, dynamic> vehicleMap = {};
    // for (String attribute in vehicleAttributes) {
    //   List<String> keyValue = attribute.split(":");
    //   if (keyValue.length == 2) {
    //     String key = keyValue[0].trim();
    //     String value = keyValue[1].trim();
    //     if (key.isNotEmpty && value.isNotEmpty) {
    //       vehicleMap[key] = value;
    //     }
    //   }
    // }
    ///User Details Sub Data
    // String userString = userData.replaceAll('{', '').replaceAll('}', '');
    // List<String> userAttributes = userString.split(", ");
    // Map<String, dynamic> userMap = {};
    // for (String attribute in userAttributes) {
    //   List<String> keyValue = attribute.split(":");
    //   if (keyValue.length == 2) {
    //     String key = keyValue[0].trim();
    //     String value = keyValue[1].trim();
    //     if (key.isNotEmpty && value.isNotEmpty) {
    //       userMap[key] = value;
    //     }
    //   }
    // }
    ///Guest Details Sub Data
    // String guestString = guestDetails.replaceAll('{', '').replaceAll('}', '');
    // List<String> guestAttributes = guestString.split(", ");
    // Map<String, dynamic> guestMap = {};
    // for (String attribute in guestAttributes) {
    //   List<String> keyValue = attribute.split(":");
    //   if (keyValue.length == 2) {
    //     String key = keyValue[0].trim();
    //     String value = keyValue[1].trim();
    //     if (key.isNotEmpty && value.isNotEmpty) {
    //       guestMap[key] = value;
    //     }
    //   }
    // }

    ///Driver Details Sub Data
    // String driverString = driverDetails.replaceAll('{', '').replaceAll('}', '');
    // List<String> driverAttributes = driverString.split(", ");
    // Map<String, dynamic> driverMap = {};
    // for (String attribute in driverAttributes) {
    //   List<String> keyValue = attribute.split(":");
    //   if (keyValue.length == 2) {
    //     String key = keyValue[0].trim();
    //     String value = keyValue[1].trim();
    //     if (key.isNotEmpty && value.isNotEmpty) {
    //       driverMap[key] = value;
    //     }
    //   }
    // }
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Ride Details",
      ),
      body: PageLayout_Page(
        child: ListView(
          children: [
            RentalBookingContainer(
              bookingId: fulldata.rentalBookingId,
              // carName: vehicleMap['carName'] ?? 'N/A',
              hour: fulldata.totalRentTime,
              id: widget.bookedId,
              kilometer: fulldata.kilometers,
              pickDate: fulldata.date,
              pickTime: fulldata.pickupTime,
              rentalCharge: fulldata.rentalCharge,
              status: fulldata.bookingStatus,
              fuel: fulldata.vehicle!.fuelType?.toString() ?? '',
              pickUpLocation: fulldata.pickupLocation != 'null'
                  ? fulldata.pickupLocation
                  : 'N/A',
              paid: fulldata.paidStatus,
              vehicleNo: fulldata.vehicle!.vehicleNumber?.toString() ?? '',
              color: fulldata.vehicle!.color?.toString() ?? '',
              // seats: vehicleMap['seats'] ?? 'N/A',
              carType: fulldata.carType,
              brandName: fulldata.vehicle!.brandName?.toString() ?? '',
              /////////////////Guest Detail////////////////////////
              guestId: fulldata.guest!.guestId?.toString() ?? '' ,
              firstName: fulldata.guest!.guestName?.toString() ?? '',
              lastName: guestDetails.toString().isEmpty || guestDetails != "null"
                      ? ""
                      : "",
              contact: fulldata.guest!.guestMobile?.toString() ?? '',
              gender: fulldata.guest!.gender?.toString() ?? '',
              btn: fulldata.bookingStatus == "BOOKED"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomButtonSmall(
                            width: AppDimension.getWidth(context) * .35,
                            height: 40,
                            btnHeading: "Cancel Booking",
                            // loading: cancelledStatus == "Status.loading" && loading,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    controller.clear();
                                    return SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                          top: AppDimension.getHeight(
                                                  context) *
                                              .2),
                                      child: CancelContainerDialog(
                                        loading: cancelledStatus ==
                                                "Status.loading" &&
                                            loading,
                                        controllerCancel: controller,
                                        onTap: () async {
                                          if (controller.text.isEmpty ||
                                              controller.text == 'null') {
                                            Utils.flushBarErrorMessage(
                                                "Please enter the reason",
                                                context);
                                          } else {
                                            loading = true;
                                            await Provider.of<
                                                        RentalBookingCancelViewModel>(
                                                    context,
                                                    listen: false)
                                                .fetchRentalBookingCancelViewModelApi(
                                                    context,
                                                    {
                                                      "id": widget.bookedId,
                                                      "reason":
                                                          controller.text,
                                                      "cancelledBy": "USER"
                                                    },
                                                    widget.useriD)
                                                .then((value) {
                                              if (context.mounted) {
                                                Provider.of<RentalBookingListViewModel>(
                                                        context,
                                                        listen: false)
                                                    .fetchRentalBookingListBookedViewModelApi(
                                                        context, {
                                                  'userId': widget.useriD,
                                                  'pageNumber': '0',
                                                  'pageSize': '20',
                                                  'bookingStatus':
                                                      'CANCELLED',
                                                });
                                                controller.clear();
                                                // context.pop();
                                              }
                                            });
                                            // controller.dispose();
                                          }
                                        },
                                      ),
                                    );
                                  });
                              // context.pop();
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
            const SizedBox(height: 10),
            vehicleDetails != null &&
                vehicleDetails.carName != null &&
                vehicleDetails.carName!.isNotEmpty
                ? VechicleDetailsContainer(
              color: vehicleDetails.color ?? '',
              vehicleName: vehicleDetails.carName ?? '',
              brandName: vehicleDetails.brandName ?? '',
              vehicleNo: vehicleDetails.vehicleNumber ?? '',
              fuelType: vehicleDetails.fuelType ?? '',
              seats: vehicleDetails.seats ?? '',
              vehicleImage: vehicleDetails.images,
            )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            driverDetails != null &&
                driverDetails.firstName != null &&
                driverDetails.firstName!.isNotEmpty
                ? DriverDetailsContainer(
              firstName: fulldata.driver.firstName?.toString() ?? '',
              lastName: fulldata.driver.lastName?.toString() ?? '',
              gender: fulldata.driver.gender?.toString() ?? '',
              mobile: fulldata.driver.mobile?.toString() ?? '',
              email: fulldata.driver.email?.toString() ?? '',
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class RentalBookingContainer extends StatelessWidget {
  // final String carName;
  final String pickDate;
  final String pickTime;
  final String hour;
  final String vehicleNo;
  final String fuel;
  final String id;
  final String firstName;
  final String guestId;
  final String lastName;
  final String contact;
  final String gender;
  final String kilometer;
  final String status;
  final String rentalCharge;
  final String bookingId;
  final String pickUpLocation;
  final String paid;
  final String carType;
  final String brandName;
  final String seats;
  final String color;

  // final VoidCallback confirmTap;
  final Widget btn;

  const RentalBookingContainer({
    super.key,
    // required this.carName,
    required this.pickDate,
    required this.pickTime,
    required this.hour,
    required this.id,
    required this.kilometer,
    required this.status,
    required this.rentalCharge,
    required this.bookingId,
    required this.pickUpLocation,
    required this.paid,
    this.seats = '',
    // required this.confirmTap,
    required this.btn,
    required this.firstName,
    required this.lastName,
    required this.guestId,
    required this.contact,
    required this.gender,
    required this.vehicleNo,
    required this.fuel,
    required this.carType,
    required this.brandName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: AppDimension.getHeight(context) * .5,
        width: AppDimension.getWidth(context) * .9,
        // padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: background,
            border: Border.all(
              color: naturalGreyColor.withOpacity(0.3),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(9),
                    topLeft: Radius.circular(9),
                  ),
                  color: btnColor,
                  border: Border(
                      bottom: BorderSide(
                          color: naturalGreyColor.withOpacity(0.3)))),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Booking Details",
                    style: GoogleFonts.lato(
                        color: background,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            // Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Car Details",
            //       style: titleTextStyle,
            //     )),
            // Container(
            //   // height: 50,
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   decoration: const BoxDecoration(
            //       border: Border(bottom: BorderSide(color: greyColor))),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               RichText(
            //                   overflow: TextOverflow.ellipsis,
            //                   text: TextSpan(children: [
            //                     TextSpan(
            //                       text: "Car Type : ",
            //                       style: titleTextStyle,
            //                     ),
            //                     TextSpan(
            //                       text: carType,
            //                       style: textTextStyle,
            //                     ),
            //                   ])),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Booking Details",
            //       style: titleTextStyle,
            //     )),

            ///3rd Container
            Container(
              // height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              // decoration: const BoxDecoration(
              //     border: Border(bottom: BorderSide(color: greyColor))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Id : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(id, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Status : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(status, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(pickDate, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hour : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(hour, style: titleTextStyle1),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Kilometer : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(kilometer, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rental Charge : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child:
                                    Text(rentalCharge, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(pickTime, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PickUp Location : ", style: titleTextStyle),
                        SizedBox(
                          width: 210,
                          child: Text(pickUpLocation,
                              style: titleTextStyle1,
                              textAlign: TextAlign.start),
                        ),
                      ]),
                  const SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking ID : ", style: titleTextStyle),
                        SizedBox(
                          width: 220,
                          child: Text(
                            bookingId,
                            style: titleTextStyle1,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                        ),
                      ])
                ],
              ),
            ),

            guestId.isNotEmpty
                ? Container(
                    decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: greyColor))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Guest Details",
                                style: titleTextStyle,
                              )),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Guest Id : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(guestId, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Guest Name : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text('$firstName $lastName',
                                    style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Contact : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(contact, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(gender, style: titleTextStyle1),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  ),

            ///Cancel Button Widget
            SizedBox(
              child: btn,
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

class VechicleDetailsContainer extends StatelessWidget {
  final String vehicleName;
  final String vehicleNo;
  final String fuelType;
  final String brandName;
  final String seats;
  final String color;
  final List<String> vehicleImage;

  const VechicleDetailsContainer({
    super.key,
    required this.vehicleName,
    this.seats = '',
    required this.vehicleNo,
    required this.fuelType,
    required this.brandName,
    required this.vehicleImage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: AppDimension.getHeight(context) * .5,
        width: AppDimension.getWidth(context) * .9,
        // padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: background,
            border: Border.all(
              color: naturalGreyColor.withOpacity(0.3),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(9),
                    topLeft: Radius.circular(9),
                  ),
                  color: btnColor,
                  border: Border(
                      bottom: BorderSide(
                          color: naturalGreyColor.withOpacity(0.3)))),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Vehicle Details",
                    style: GoogleFonts.lato(
                        color: background,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: 200,
              child: MultiImageSlider(images: vehicleImage),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppDimension.getWidth(context) * .5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name : ", style: titleTextStyle),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    vehicleName,
                                    style: titleTextStyle1,
                                    maxLines: 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: AppDimension.getWidth(context) * .5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Brand : ", style: titleTextStyle),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    brandName,
                                    style: titleTextStyle1,
                                    maxLines: 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vehicle No. : ", style: titleTextStyle),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  vehicleNo,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Color : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  color,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Fuel Type : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  fuelType,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Seats : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  seats,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

class DriverDetailsContainer extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String gender;

  const DriverDetailsContainer({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // height: AppDimension.getHeight(context) * .5,
        width: AppDimension.getWidth(context) * .9,
        // padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: background,
            border: Border.all(
              color: naturalGreyColor.withOpacity(0.3),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(9),
                    topLeft: Radius.circular(9),
                  ),
                  color: btnColor,
                  border: Border(
                      bottom: BorderSide(
                          color: naturalGreyColor.withOpacity(0.3)))),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Driver Details",
                    style: GoogleFonts.lato(
                        color: background,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name : ", style: titleTextStyle),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "$firstName $lastName",
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mobile No. : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  mobile,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  email,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text( "Last Name : ",
                          //         style: titleTextStyle),
                          //     SizedBox(
                          //       width: 70,
                          //       child: Text(,
                          //         style: titleTextStyle1,maxLines: 3,),
                          //     )
                          //   ],
                          // ),
                          // const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender : ", style: titleTextStyle),
                              SizedBox(
                                // width: 100,
                                child: Text(
                                  gender,
                                  style: titleTextStyle1,
                                  maxLines: 3,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
