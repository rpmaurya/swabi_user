import 'package:flutter/material.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarsDetailsAvailable extends StatefulWidget {
  // final Datum data;
  final String id;
  final double longitude;
  final double latitude;

  const CarsDetailsAvailable({
    super.key,
    required this.id,
    required this.longitude,
    required this.latitude,
  });

  @override
  State<CarsDetailsAvailable> createState() => _CarsDetailsAvailableState();
}

class _CarsDetailsAvailableState extends State<CarsDetailsAvailable> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool load = false;
  List<Body> rentalData = [];

  String message = "";
  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    print("${widget.latitude}Latii");
    print("${widget.longitude}Logii");
    var status = context.watch<RentalViewModel>().DataList.status.toString();
    if (status == "Status.completed") {
      rentalData =
          context.watch<RentalViewModel>().DataList.data?.data.body ?? [];
    }
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Cars Available",
      ),
      body: PageLayout_Page(
          child: ListView.builder(
              itemCount: rentalData.length,
              itemBuilder: (context, index) {
                return TransContainer(
                    carName: rentalData[index].carType,
                    carImage: rentalData[index].carImage,
                    pickTime: rentalData[index].pickupTime,
                    price: rentalData[index].price,
                    pickDate: rentalData[index].date,
                    totalPrice: rentalData[index].totalPrice,
                    hour: rentalData[index].hours,
                    seats: rentalData[index].seats,
                    kilometers: rentalData[index].kilometers,
                    pickUpLocation: rentalData[index].pickUpLocation,
                    loading: load && selectIndex == index,
                    onTap: () {
                      setState(() {
                        load = true;
                        selectIndex = index;
                      });
                      double amount =
                          double.parse(rentalData[index].totalPrice);
                      // int intAmoutns
                      // Provider.of<PaymentCreateOrderIdViewModel>(context,
                      //     listen: false)
                      //     .fetchPaymentCreateOrderIdViewModelApi(context, {
                      //   "amount": amount.toInt(),
                      //   "userId": widget.id.toString(),
                      // },rentalData[index].carType,widget.id.toString(),rentalData[index].date,rentalData[index].longitude,rentalData[index].latitude);
                      context.push('/rentalForm/bookYourCab', extra: {
                        "carType": rentalData[index].carType,
                        "userId": widget.id.toString(),
                        "bookdate": rentalData[index].date,
                        "totalAmt": rentalData[index].totalPrice,
                        "longitude": rentalData[index].longitude,
                        "latitude": rentalData[index].latitude
                      });
                      setState(() {
                        load = false;
                      });
                    });
              })),
    );
  }
}

class TransContainer extends StatelessWidget {
  final String carName;
  final String carImage;

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

  const TransContainer(
      {this.carName = "",
      this.carImage = "",
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 0,
        color: background,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // height: AppDimension.getHeight(context)*.25,
          width: AppDimension.getWidth(context) * .9,
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: naturalGreyColor.withOpacity(.3))),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            child: carImage.isNotEmpty
                                ? Image.network(
                                    carImage,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    rentalCar1,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  carName,
                                  style: GoogleFonts.lato(
                                      color: greyColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Seats : ${seats}",
                                  style: GoogleFonts.lato(
                                      color: greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hour : ${hour}",
                                  style: GoogleFonts.lato(
                                      color: greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Date : ${pickDate}",
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
                    border: Border(bottom: BorderSide(color: curvePageColor))),
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
                        subtitle: Text('${kilometers}/KM', style: titleText),
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
                          pickTime,
                          style: titleText,
                        ),
                      ),
                    )
                  ],
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
                        style: titleText,
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          pickUpLocation,
                          style: titleText,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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

              // ///First Line of Design
              // Container(
              //     padding: EdgeInsets.all(10),
              //     decoration: const BoxDecoration(
              //         border:
              //             Border(bottom: BorderSide(color: curvePageColor))),
              //     child: Row(
              //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         SizedBox(
              //           width: 80,
              //           height: 60,
              //           child: ClipRRect(
              //               borderRadius: BorderRadius.circular(10),
              //               child: carImage.isNotEmpty
              //                   ? Image.network(carImage)
              //                   : Image.asset(
              //                       rentalCar1,
              //                       fit: BoxFit.cover,
              //                     )),
              //         ),
              //         const SizedBox(width: 10),
              //         Expanded(
              //           child: Column(
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     carName,
              //                     style: GoogleFonts.lato(
              //                         color: greyColor,
              //                         fontSize: 17,
              //                         fontWeight: FontWeight.w700),
              //                   ),
              //                   Text(
              //                     // "⭐ 4.8",
              //                     '',
              //                     style: GoogleFonts.lato(
              //                         color: greyColor,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     "Hour : $hour",
              //                     style: GoogleFonts.lato(
              //                         color: greyColor,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                   Text(
              //                     "Time : $pickTime",
              //                     style: GoogleFonts.lato(
              //                         color: greyColor,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     "Seats : $seats",
              //                     style: GoogleFonts.lato(
              //                         color: greyColor,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w700),
              //                   ),
              //                   Text(
              //                     "Date : $pickDate",
              //                     style: GoogleFonts.lato(
              //                         color: greyColor,
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     )),

              // ///Second Line Design
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       RichText(
              //           text: TextSpan(children: [
              //         TextSpan(
              //           text: "Kilometers : ",
              //           style: titleTextStyle,
              //         ),
              //         TextSpan(
              //           text: '$kilometers/KM',
              //           style: titleTextStyle,
              //         ),
              //       ])),
              //       const SizedBox(height: 10),
              //       // Spacer(),
              //       Expanded(
              //         child: Row(
              //           children: [
              //             Text(
              //               'Location :',
              //               style: titleTextStyle,
              //             ),
              //             Expanded(
              //               child: Text(
              //                 pickUpLocation,
              //                 style: titleTextStyle,
              //                 maxLines: 3,
              //                 overflow: TextOverflow.ellipsis,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: greyColor1.withOpacity(.1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "AED", style: appbarTextStyle),
                      TextSpan(
                          text: " ${totalPrice}".toUpperCase(),
                          style: appbarTextStyle),
                    ])),
                    CustomButtonSmall(
                      width: 120,
                      height: 40,
                      loading: loading,
                      btnHeading: "View Details",
                      onTap: onTap,
                    ),
                  ],
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: CustomButtonSmall(
              //         loading: loading,
              //         height: 40,
              //         width: 80,
              //         btnHeading: 'View',
              //         onTap: onTap),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
