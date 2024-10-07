// import 'package:country_currency_pickers/utils/utils.dart';
// import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/model/getIssueByBookingIdModel.dart';
import 'package:flutter_cab/model/paymentDetailsModel.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customPaymentDetailsContainer.dart';
import 'package:flutter_cab/res/Custom%20Widgets/multi_imageSlider_ContainerWidget.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customRaiseIssueForm.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view/dashboard/rental/carBooking.dart';
import 'package:flutter_cab/view_model/raiseIssue_view_model.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../utils/text_styles.dart';

class RentalBookedPageView extends StatefulWidget {
  final String bookedId;
  final String useriD;
  final String paymentId;

  const RentalBookedPageView(
      {super.key,
      required this.bookedId,
      required this.useriD,
      required this.paymentId});

  @override
  State<RentalBookedPageView> createState() => _RentalBookedPageViewState();
}

class _RentalBookedPageViewState extends State<RentalBookedPageView> {
  TextEditingController controller = TextEditingController();
  RentalDetailsSingleData? fulldata;
  PaymentData? paymentDetails;
  GetIssueByBookingIdModel? getIssueByBookingId;
  bool loading = false;
  String? currency;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPaymentDetail();
      Provider.of<RaiseissueViewModel>(context, listen: false)
          .getIssueByBookingId(
              context: context,
              bookingId: widget.bookedId,
              userId: widget.useriD,
              bookingType: 'RENTAL_BOOKING');
    });
    // currency = getCurrencyByCountryCode('IN');
    // print('Currency for IN: ${currency} - ${currency}');
    super.initState();
  }

  Future<void> getPaymentDetail() async {
    setState(() {
      loading = true;
    });

    print('paymentid:...${widget.paymentId}');

    await Provider.of<RentalPaymentDetailsViewModel>(context, listen: false)
        .rentalPaymentDetail(context: context, paymentId: widget.paymentId)
        .then((onValue) {
      if (onValue?.status?.httpCode == '200') {
        setState(() {
          paymentDetails = onValue?.data;
          loading = false;
        });
      }
    });
  }

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
    fulldata = context.watch<RentalViewDetailViewModel>().dataList.data?.data;
    getIssueByBookingId =
        context.watch<RaiseissueViewModel>().getIssueBybookingId.data;
    // userData =
    //     context.watch<RentalViewDetailViewModel>().DataList.data?.data.user ??
    //         "";
    // guestDetails =
    //     context.watch<RentalViewDetailViewModel>().DataList.data?.data.guest ??
    //         "";
    // vehicleDetails = context
    //         .watch<RentalViewDetailViewModel>()
    //         .DataList
    //         .data
    //         ?.data
    //         .vehicle ??
    //     "";
    // driverDetails =
    //     context.watch<RentalViewDetailViewModel>().DataList.data?.data.driver ??
    //
    //      "";
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(
      (int.tryParse(fulldata?.createdDate ?? '')) ?? 0 * 1000,
    );

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        (paymentDetails?.createdAt ?? 0) * 1000,
        isUtc: true);
    Duration offset = Duration(hours: 5, minutes: 30);
    DateTime adjustedTime = dateTime.add(offset);

    String formattedTime =
        '${DateFormat('HH:mm').format(adjustedTime)} GMT (+05:30)';
    print('paymentdewatil.......${paymentDetails?.amount}');

    debugPrint('hjkhkkjkjjkjk$formattedTime');

    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Booking Preview",
      ),
      body: PageLayout_Page(
        child: Stack(
          children: [
            ListView(
              children: [
                RentalBookingContainer(
                  // bookingId: fulldata.bookerId,
                  // carName: vehicleMap['carName'] ?? 'N/A',
                  getIssueByBookingId: getIssueByBookingId,
                  createdDate: DateFormat('dd-MM-yyyy').format(dateTime1),
                  rideStartTime: fulldata?.rideStartTime ?? '',
                  extraRideDistance: fulldata?.extraKilometers ?? '',
                  extraRideTime: fulldata?.extraMinutes ?? '',
                  totalRideTime: fulldata?.totalRentTime ?? '',
                  vehicleType: fulldata?.vehicle.carType ?? '',
                  id: widget.bookedId,
                  kilometer: fulldata?.kilometers ?? '',
                  pickDate: fulldata?.date ?? '',
                  pickTime: fulldata?.pickupTime ?? '',
                  rentalCharge: (fulldata?.discountAmount ?? '').isEmpty ||
                          fulldata?.discountAmount == '0'
                      ? fulldata?.rentalCharge ?? ''
                      : fulldata?.discountAmount ?? '',
                  status: fulldata?.bookingStatus ?? '',
                  fuel: fulldata?.vehicle.fuelType?.toString() ?? '',
                  pickUpLocation: fulldata?.pickupLocation != null
                      ? fulldata?.pickupLocation ?? ''
                      : 'N/A',
                  paid: fulldata?.paidStatus ?? '',
                  vehicleNo: fulldata?.vehicle.vehicleNumber?.toString() ?? '',
                  color: fulldata?.vehicle.color?.toString() ?? '',
                  // seats: vehicleMap['seats'] ?? 'N/A',
                  carType: fulldata?.carType ?? "",
                  brandName: fulldata?.vehicle.brandName?.toString() ?? '',
                  /////////////////Guest Detail////////////////////////
                  guestId: fulldata?.guest.guestId?.toString() ?? '',
                  firstName: fulldata?.guest.guestName?.toString() ?? '',
                  lastName: fulldata!.guest.guestName!.isEmpty ||
                          fulldata?.guest.guestName != null
                      ? ""
                      : "",
                  contact:
                      '+ ${fulldata?.guest.countryCode?.toString() ?? '971'} ${fulldata?.guest.guestMobile?.toString()}' ??
                          '',
                  gender: fulldata?.guest.gender?.toString() ?? '',
                  btn: Container(),
                ),
                const SizedBox(height: 10),
                paymentDetails != null
                    ? Custompaymentdetailscontainer(
                        paymentId: paymentDetails?.id ?? '',
                        paymentDate: DateFormat('dd-MM-yyyy').format(dateTime),
                        amount:
                            '${(double.tryParse(paymentDetails?.amount.toString() ?? '') ?? 0) / 100}',
                        paymentTime: formattedTime)
                    : Container(),
                const SizedBox(height: 10),
                fulldata?.vehicle != null &&
                        fulldata?.vehicle.carName != null &&
                        fulldata!.vehicle.carName!.isNotEmpty
                    ? VechicleDetailsContainer(
                        color: fulldata?.vehicle.color ?? '',
                        vehicleName: fulldata?.vehicle.carName ?? '',
                        brandName: fulldata?.vehicle.brandName ?? '',
                        vehicleNo: fulldata?.vehicle.vehicleNumber ?? '',
                        fuelType: fulldata?.vehicle.fuelType ?? '',
                        seats: fulldata?.vehicle.seats ?? '',
                        vehicleImage: fulldata?.vehicle.images ?? [],
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                fulldata?.driver != null &&
                        fulldata?.driver.firstName != null &&
                        fulldata!.driver.firstName!.isNotEmpty
                    ? DriverDetailsContainer(
                        firstName: fulldata?.driver.firstName?.toString() ?? '',
                        lastName: fulldata?.driver.lastName?.toString() ?? '',
                        gender: fulldata?.driver.gender?.toString() ?? '',
                        countryCode:
                            fulldata?.driver.countryCode?.toString() ?? '',
                        mobile: fulldata?.driver.mobile?.toString() ?? '',
                        email: fulldata?.driver.email?.toString() ?? '',
                        address:
                            fulldata?.driver.driverAddress.toString() ?? '',
                      )
                    : Container(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (getIssueByBookingId?.data ?? []).isEmpty
                        ? CustomButtonSmall(
                            height: 40,
                            width: 120,
                            btnHeading: 'Create Issue',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return RaiseIssueDialog(
                                    bookingId: widget.bookedId,
                                    bookingType: 'RENTAL_BOOKING',
                                  );
                                },
                              );
                            })
                        : Container(),
                    fulldata?.bookingStatus == "BOOKED"
                        ? Padding(
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
                                              Utils.toastMessage(
                                                  "Please enter the reason");
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
                          )
                        : Container(),
                  ],
                )
              ],
            ),
            if (loading)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.green,
                    ))),
              )
          ],
        ),
      ),
    );
  }
}

class RentalBookingContainer extends StatelessWidget {
  // final String carName;
  final String createdDate;
  final String rideStartTime;
  final String extraRideDistance;
  final String extraRideTime;
  final String totalRideTime;
  final String pickDate;
  final String pickTime;
  final String vehicleType;
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
  // final String bookingId;
  final String pickUpLocation;
  final String paid;
  final String carType;
  final String brandName;
  final String seats;
  final String color;
  final GetIssueByBookingIdModel? getIssueByBookingId;
  // final VoidCallback confirmTap;
  final Widget btn;

  const RentalBookingContainer({
    super.key,
    required this.getIssueByBookingId,
    // required this.carName,
    required this.createdDate,
    required this.rideStartTime,
    required this.extraRideDistance,
    required this.extraRideTime,
    required this.totalRideTime,
    required this.pickDate,
    required this.pickTime,
    required this.vehicleType,
    required this.id,
    required this.kilometer,
    required this.status,
    required this.rentalCharge,
    // required this.bookingId,
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
                  bookingItem(lable: 'Booking ID', value: id),
                  const SizedBox(height: 5),
                  bookingItem(lable: 'Booking Status', value: status),
                  const SizedBox(height: 5),

                  bookingItem(lable: 'Created Date', value: createdDate),
                  const SizedBox(height: 5),

                  bookingItem(lable: 'Ride Date', value: pickDate),
                  const SizedBox(height: 5),

                  bookingItem(lable: 'PickUpTime', value: pickTime),
                  const SizedBox(height: 5),

                  bookingItem(
                      lable: 'Ride Start Time',
                      value: rideStartTime.isNotEmpty
                          ? rideStartTime
                          : 'Ride not started'),
                  const SizedBox(height: 5),

                  bookingItem(lable: 'Ride Distance', value: '$kilometer KM'),
                  const SizedBox(height: 5),

                  bookingItem(
                      lable: 'Extra Ride Distance',
                      value: extraRideDistance.isNotEmpty
                          ? extraRideDistance
                          : 'N/A'),
                  const SizedBox(height: 5),

                  bookingItem(
                      lable: 'Extra Ride Time',
                      value:
                          '0 Hour : ${extraRideTime.isNotEmpty ? extraRideTime : '0'} Min'),
                  const SizedBox(height: 5),

                  bookingItem(
                      lable: 'Total Ride Time', value: '$totalRideTime Hour'),
                  const SizedBox(height: 5),

                  bookingItem(
                      lable: 'Car Type',
                      value: vehicleType.isEmpty ? carType : vehicleType),
                  const SizedBox(height: 5),

                  bookingItem(
                      lable: 'Booking Price', value: 'AED $rentalCharge'),
                  const SizedBox(height: 5),

                  (getIssueByBookingId?.data ?? []).isEmpty
                      ? Container()
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Created Issue',
                                style: titleTextStyle,
                              ),
                            ),
                            Text(':', style: titleTextStyle),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomButtonSmall(
                                  height: 35,
                                  btnHeading: 'Show IssueDetails',
                                  onTap: () {
                                    context.push("/raiseIssueDetail");
                                  }),
                            )
                          ],
                        ),
                  bookingItem(lable: 'Pickup Location', value: pickUpLocation),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("BookingId : ", style: titleTextStyle),
                  //             SizedBox(
                  //               // width: 100,
                  //               child: Text(id, style: titleTextStyle1),
                  //             )
                  //           ],
                  //         ),
                  //         const SizedBox(height: 5),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Kilometer : ", style: titleTextStyle),
                  //             SizedBox(
                  //               // width: 100,
                  //               child: Text(kilometer, style: titleTextStyle1),
                  //             )
                  //           ],
                  //         ),
                  //         const SizedBox(height: 5),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Date : ", style: titleTextStyle),
                  //             SizedBox(
                  //               // width: 100,
                  //               child: Text(pickDate, style: titleTextStyle1),
                  //             )
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Status : ", style: titleTextStyle),
                  //             SizedBox(
                  //               // width: 100,
                  //               child: Text(status, style: titleTextStyle1),
                  //             )
                  //           ],
                  //         ),
                  //         const SizedBox(height: 5),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Price : ", style: titleTextStyle),
                  //             SizedBox(
                  //               // width: 100,
                  //               child: Text('AED ${rentalCharge}',
                  //                   style: titleTextStyle1),
                  //             )
                  //           ],
                  //         ),
                  //         const SizedBox(height: 5),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text("Pick-Up Time : ", style: titleTextStyle),
                  //             SizedBox(
                  //               // width: 100,
                  //               child: Text(pickTime, style: titleTextStyle1),
                  //             )
                  //           ],
                  //         ),
                  //         const SizedBox(height: 5),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // vehicleType.isNotEmpty
                  //     ? Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("Vehicle Type : ", style: titleTextStyle),
                  //           SizedBox(
                  //             // width: 100,
                  //             child: Text(vehicleType, style: titleTextStyle1),
                  //           )
                  //         ],
                  //       )
                  //     : SizedBox(),
                  // const SizedBox(height: 5),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("PickUp Location : ", style: titleTextStyle),
                  //       SizedBox(
                  //         width: 210,
                  //         child: Text(pickUpLocation,
                  //             style: titleTextStyle1,
                  //             textAlign: TextAlign.start),
                  //       ),
                  //     ]),
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

  bookingItem({required String lable, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(lable, style: titleTextStyle)),
        Text(':', style: titleTextStyle),
        const SizedBox(width: 10),
        Expanded(flex: 2, child: Text(value, style: titleTextStyle1))
      ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vehicle Name : ", style: titleTextStyle),
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
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Brand Name : ", style: titleTextStyle),
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
                              Text("Colors : ", style: titleTextStyle),
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
  final String countryCode;
  final String address;

  final String email;
  final String gender;

  const DriverDetailsContainer({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.countryCode,
    required this.address,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name : ", style: titleTextStyle),
                      SizedBox(
                        // width: 100,
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
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact No. : ", style: titleTextStyle),
                      SizedBox(
                        // width: 100,
                        child: Text(
                          '+${countryCode} ${mobile}',
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
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address : ", style: titleTextStyle),
                      SizedBox(
                        // width: 100,
                        child: Text(
                          address,
                          style: titleTextStyle1,
                          maxLines: 3,
                        ),
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
