import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/text_styles.dart';

class RentalCarListingContainer extends StatelessWidget {
  final String carName;
  final String date;
  final String rentalCharge;
  final String status;
  final String time;
  final String bookingID;
  final String pickUplocation;
  final VoidCallback? onTapContainer;
  const RentalCarListingContainer(
      {super.key,
        this.onTapContainer,
      required this.carName,
      required this.date,
      required this.time,
      required this.bookingID,
      required this.pickUplocation,
      required this.rentalCharge,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap:onTapContainer,
          child: Container(
            // width: AppDimension.getWidth(context) * .9,
            decoration: BoxDecoration(
              color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
            child: Column(
              children: [
                ///First Line of Design
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: naturalGreyColor.withOpacity(0.3)))),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80,
                        height: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              rentalCar1,
                              fit: BoxFit.fill,
                            )),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            carName,
                            style:titleTextStyle,
                          ),
                          Text(
                            "⭐ 4.8",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    size: 18),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  date,
                                  style: titleTextStyle
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.watch_later_outlined,
                                        size: 18),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      time,
                                      style: titleTextStyle
                                    ),
                                  ],
                                ),
                               Container(
                                 child: Row(
                                   children: [
                                     Text(
                                         "Booking Id : ",
                                       style: titleTextStyle,
                                     ),
                                     Text(
                                         bookingID,
                                         style: titleTextStyle
                                     ),
                                   ],
                                 ),
                               )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),

                ///Second Line Design
                Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: curvePageColor))),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(location),
                          )),
                    ),
                    title: Text(
                      "PickUp Location",
                      style: titleTextStyle,
                    ),
                    subtitle: Row(
                      children: [
                        SizedBox(
                          width: 145,
                          child: Text(
                            pickUplocation,
                            style: titleTextStyle1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),

                          // CustomText(
                          //   content: ,
                          //  fontSize: 16,
                          //   align: TextAlign.start,
                          //   textColor: blackColor,
                          // ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    trailing: Container(

                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 40,
                          //   height: 40,
                          //   child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Image.asset(""),
                          //       )),
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Charges",
                                style: titleTextStyle,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "AED $rentalCharge",
                                style: titleTextStyle1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Second Line Design
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: status == "CANCELLED"?redColor.withOpacity(.1):greenColor.withOpacity(.1),
                        // color: status == "BOOKED"?greenColor.withOpacity(.1):status == "CANCELLED"?redColor.withOpacity(.1):status == "ON_RUNNING"?Colors.yellowAccent.withOpacity(.1):Colors.blue.withOpacity(.1),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          status,
                          style: GoogleFonts.lato(
                              color: status == "CANCELLED"?redColor :greenColor,
                              // color: status == "BOOKED"?greenColor:status == "CANCELLED"?redColor:status == "ON_RUNNING"?Colors.yellowAccent:Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// class CancelledRentalCar extends StatelessWidget {
//   final String carName;
//   final String date;
//   final String rentalCharge;
//   final String status;
//   final bool loading;
//   final String time;
//   final String pickUpLocation;
//   final VoidCallback? onTapContainer;
//   const CancelledRentalCar({super.key,
//     this.loading = false,
//     this.onTapContainer,
//     required this.time,
//     required this.pickUpLocation,
//     required this.carName, required this.date, required this.rentalCharge, required this.status});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
//       child: Material(
//         borderRadius: BorderRadius.circular(10),
//
//         child: InkWell(
//           borderRadius: BorderRadius.circular(10),
//           onTap: onTapContainer,
//           child: loading != true ? Container(
//             // height: AppDimension.getHeight(context)*.23,
//             width: AppDimension.getWidth(context)*.9,
//             decoration: BoxDecoration(
//
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: btnColor)
//             ),
//             child: Column(
//               children: [
//                 ///First Line of Design
//                 Container(
//                     decoration: const BoxDecoration(
//                         border: Border(bottom: BorderSide(color: curvePageColor))
//                     ),
//                     child: ListTile(
//                       leading: SizedBox(
//                         width: 60,
//                         height: 60,
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.asset(car,fit: BoxFit.cover,)),
//                       ),
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(carName,style: GoogleFonts.lato(
//                               color: greyColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600
//                           ),),
//                           Text("⭐ 4.8",style: GoogleFonts.lato(
//                               color: greyColor,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w700
//                           ),),
//                         ],
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               children: [
//                                 const Icon(Icons.calendar_month_outlined,size: 18),
//                                 const SizedBox(width: 5,),
//                                 Text(date,style: GoogleFonts.lato(
//                                     color: greyColor1,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600
//                                 ),),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Row(
//                               children: [
//                                 const Icon(Icons.watch_later_outlined,size: 18),
//                                 const SizedBox(width: 5,),
//                                 Text(time,style: GoogleFonts.lato(
//                                     color: greyColor1,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600
//                                 ),),
//                               ],
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     )
//                 ),
//                 ///Second Line Design
//                 Container(
//                   decoration: const BoxDecoration(
//                       border: Border(bottom: BorderSide(color: curvePageColor))
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                     leading: SizedBox(
//                       width: 40,
//                       height: 40,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Image.asset(location),
//                           )),
//                     ),
//                     title:  Text("PickUp Location",style: GoogleFonts.lato(
//                         color: greyColor1,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700
//                     ),),
//                     subtitle:  Row(
//                       children: [
//                         Text(pickUpLocation,style: GoogleFonts.lato(
//                             color: greyColor,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w700
//                         ),),
//                         const Spacer(),
//                       ],
//                     ),
//                     trailing: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       width: 100,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Image.asset(rupee),
//                                 )),
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Charges",style: GoogleFonts.lato(
//                                   color: greyColor1,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700
//                               ),),
//                               const SizedBox(height: 5),
//                               Text(rentalCharge,style: GoogleFonts.lato(
//                                   color: greyColor,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w700
//                               ),),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 ///Second Line Design
//                 Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: redColor.withOpacity(.1),
//                         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(status,style: GoogleFonts.lato(
//                             color: redColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600
//                         ),),
//                       ],
//                     )
//                 ),
//               ],
//             ),
//           ) : const Center(
//               child: SizedBox(
//                   width: 30,
//                   height: 30,
//                   child: CircularProgressIndicator(color: greenColor,))),
//         ),
//       ),
//     );
//   }
// }