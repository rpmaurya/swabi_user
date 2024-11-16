// import 'package:flutter/material.dart';
// import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
// import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
// import 'package:flutter_cab/res/customCheckbox.dart';
// import 'package:flutter_cab/res/customTextWidget.dart';
// import 'package:flutter_cab/utils/assets.dart';
// import 'package:flutter_cab/utils/color.dart';
// import 'package:flutter_cab/utils/dimensions.dart';
// import 'package:flutter_cab/utils/text_styles.dart';
// import 'package:go_router/go_router.dart';

// class PackageDetailsOld extends StatefulWidget {
//   const PackageDetailsOld({super.key});

//   @override
//   State<PackageDetailsOld> createState() => _PackageDetailsOldState();
// }

// class _PackageDetailsOldState extends State<PackageDetailsOld> {
//   List<String> locationName = [
//     "Abu Dhabi",
//     "Dubai",
//     "Sharjah",
//     "Al Ain",
//     "Ajman"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return PageLayout_Page(
//         appHeading: "Package Details",
//         child: Scaffold(
//           backgroundColor: background,
//           body: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 40,
//                   child: ListTile(
//                     leading: Image.asset(
//                       location,
//                       height: 20,
//                     ),
//                     title: Text(
//                       "Abu Dhabi",
//                       style: titleTextStyle1,
//                     ),
//                     subtitle: Text(
//                       "Inside Burj al Arab",
//                       style: titleTextStyle1,
//                     ),
//                     trailing: SizedBox(
//                       width: 80,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "765 AED",
//                             style: titleTextStyle1,
//                           ),
//                           const Text("Per Person"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const CustomTextWidget(
//                     content: "Activities",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     textColor: redColor),
//                 const SizedBox(height: 10),
//                 const CustomTextWidget(
//                     content: "Day 1",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     textColor: redColor),
//                 const SizedBox(height: 5),
//                 SizedBox(
//                   // color: curvePageColor,
//                   height: AppDimension.getHeight(context) * .3,
//                   child: ListView.separated(
//                     itemCount: locationName.length,
//                     itemBuilder: (context, index) => LocationContainer(
//                       hour: "7",
//                       locationName: locationName[index],
//                       price: "56",
//                       subLocation: "Inside Burj al Arab",
//                       onTap: () {
//                         setState(() {
//                           locationName.removeAt(index);
//                         });
//                         print("Data Delete Success");
//                       },
//                     ),
//                     separatorBuilder: (context, index) => const Divider(),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       child: Material(
//                         color: redColor,
//                         borderRadius: BorderRadius.circular(50),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: const Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                           onTap: () {
//                             showModalBottomSheet(
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(25),
//                                       topRight: Radius.circular(25))),
//                               isScrollControlled: true,
//                               context: context,
//                               builder: (context) => const ActivityBottomSheet(),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 // const SizedBox(height: 5),
//                 const CustomTextWidget(
//                     content: "Day 2",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     textColor: redColor),
//                 const SizedBox(height: 5),
//                 SizedBox(
//                   // color: curvePageColor,
//                   height: AppDimension.getHeight(context) * .3,
//                   child: ListView.separated(
//                     itemCount: locationName.length,
//                     itemBuilder: (context, index) => LocationContainer(
//                       hour: "7",
//                       locationName: locationName[index],
//                       price: "56",
//                       subLocation: "Inside Burj al Arab",
//                       onTap: () {
//                         setState(() {
//                           locationName.removeAt(index);
//                         });
//                         print("Data Delete Success");
//                       },
//                     ),
//                     separatorBuilder: (context, index) => const Divider(),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       child: Material(
//                         color: redColor,
//                         borderRadius: BorderRadius.circular(50),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: const Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                           onTap: () {
//                             showModalBottomSheet(
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(25),
//                                       topRight: Radius.circular(25))),
//                               isScrollControlled: true,
//                               context: context,
//                               builder: (context) => const ActivityBottomSheet(),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const CustomTextWidget(
//                     content: "Day 3",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     textColor: redColor),
//                 const SizedBox(height: 5),
//                 SizedBox(
//                   // color: curvePageColor,
//                   height: AppDimension.getHeight(context) * .3,
//                   child: ListView.separated(
//                     itemCount: locationName.length,
//                     itemBuilder: (context, index) => LocationContainer(
//                       hour: "7",
//                       locationName: locationName[index],
//                       price: "56",
//                       subLocation: "Inside Burj al Arab",
//                       onTap: () {
//                         setState(() {
//                           locationName.removeAt(index);
//                         });
//                         print("Data Delete Success");
//                       },
//                     ),
//                     separatorBuilder: (context, index) => const Divider(),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       child: Material(
//                         color: redColor,
//                         borderRadius: BorderRadius.circular(50),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Container(
//                             width: 30,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: const Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                           onTap: () {
//                             showModalBottomSheet(
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(25),
//                                       topRight: Radius.circular(25))),
//                               isScrollControlled: true,
//                               context: context,
//                               builder: (context) => const ActivityBottomSheet(),
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomButtonBig(
//                   btnHeading: "Book Your Package",
//                   onTap: () {},
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// ///Showing Location Listtile container
// class LocationContainer extends StatelessWidget {
//   final String locationName;
//   final String subLocation;
//   final String price;
//   final String hour;
//   final VoidCallback onTap;

//   const LocationContainer({
//     required this.onTap,
//     required this.locationName,
//     required this.subLocation,
//     required this.price,
//     required this.hour,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: ListTile(
//         contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
//         leading: Image.asset(
//           location,
//           height: 20,
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   locationName,
//                   style: titleTextStyle1,
//                 ),
//                 Text(
//                   subLocation,
//                   style: loginTextStyle,
//                 ),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Price: $price AED",
//                   style: loginTextStyle,
//                 ),
//                 Text(
//                   "Hours: $hour Hours",
//                   style: loginTextStyle,
//                 ),
//               ],
//             )
//           ],
//         ),
//         trailing: Material(
//           color: redColor,
//           borderRadius: BorderRadius.circular(50),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(50),
//             onTap: onTap,
//             child: Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image.asset(minus),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ///Add Activity Container BottomSheet
// class ActivityBottomSheet extends StatefulWidget {
//   const ActivityBottomSheet({super.key});

//   @override
//   State<ActivityBottomSheet> createState() => _ActivityBottomSheetState();
// }

// class _ActivityBottomSheetState extends State<ActivityBottomSheet> {
//   bool value = false;

//   bool selectAll = false;
//   List<bool> isSelectedList = [false, false, false, false, false];

//   toggleSelectAll(bool value) {
//     setState(() {
//       selectAll = value;
//       for (int i = 0; i < isSelectedList.length; i++) {
//         isSelectedList[i] = value;
//       }
//     });
//   }

//   void toggleSingleContainer(int index, bool value) {
//     setState(() {
//       isSelectedList[index] = value;
//       if (!value) {
//         selectAll = false;
//       } else {
//         selectAll = isSelectedList.every((isSelected) => isSelected);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: const BoxDecoration(
//           color: background,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(25), topLeft: Radius.circular(25))),
//       height: AppDimension.getHeight(context) * .85,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Activity",
//                 style: titleTextStyle,
//               )
//             ],
//           ),
//           CustomCheckBox(
//             onTap: () {
//               setState(() {
//                 value = !value;
//               });
//             },
//             value: value,
//             contect: "Select All",
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             height: AppDimension.getHeight(context) * .68,
//             child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) => ActicityContainer(
//                       onTap: () {
//                         setState(() {
//                           value = !value;
//                         });
//                         print(value);
//                       },
//                       checkBoxValue: value,
//                       onTapContainer: () {
//                         ///Close previous bottomsheet
//                         context.pop();

//                         ///Open New Bottom Sheet
//                         showModalBottomSheet(
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(25),
//                                   topRight: Radius.circular(25))),
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (context) {
//                             return const ActivityDetailsContainer();
//                           },
//                         );
//                       },
//                     )),
//           ),
//           CustomButtonBig(
//             btnHeading: "Select  activities",
//             onTap: () {},
//           )
//         ],
//       ),
//     );
//   }
// }

// class ActicityContainer extends StatelessWidget {
//   final VoidCallback onTap;
//   final VoidCallback onTapContainer;
//   final bool checkBoxValue;

//   const ActicityContainer(
//       {super.key,
//       required this.onTap,
//       required this.onTapContainer,
//       required this.checkBoxValue});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CustomCheckBox(onTap: onTap, contect: "Select", value: checkBoxValue),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: Material(
//               borderRadius: BorderRadius.circular(10),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(10),
//                 onTap: onTapContainer,
//                 child: Container(
//                   height: AppDimension.getHeight(context) * .27,
//                   // width: AppDimension.getWidth(context)*.9,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: btnColor),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: AppDimension.getHeight(context) * .18,
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 5),
//                         decoration: BoxDecoration(
//                             image: const DecorationImage(
//                                 image: AssetImage(viewImg), fit: BoxFit.fill),
//                             color: curvePageColor,
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "Activity Name : ",
//                                       style: titleTextStyle),
//                                   TextSpan(
//                                       text: "Inside Burj al Arab",
//                                       style: titleTextStyle1),
//                                 ])),
//                                 const SizedBox(height: 10),
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "Opening Time  : ",
//                                       style: titleTextStyle),
//                                   TextSpan(
//                                       text: "10:00 AM - 06:00 PM",
//                                       style: titleTextStyle1),
//                                 ])),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "Activity Hours : ",
//                                       style: titleTextStyle),
//                                   TextSpan(
//                                       text: "7 Hours", style: titleTextStyle1),
//                                 ])),
//                                 const SizedBox(height: 10),
//                                 RichText(
//                                     text: TextSpan(children: [
//                                   TextSpan(
//                                       text: "Price : ", style: titleTextStyle),
//                                   TextSpan(
//                                       text: "67 AED / Person",
//                                       style: titleTextStyle1),
//                                 ]))
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ActivityDetailsContainer extends StatelessWidget {
//   const ActivityDetailsContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: const BoxDecoration(
//           color: background,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(25), topLeft: Radius.circular(25))),
//       height: AppDimension.getHeight(context) * .85,
//       width: double.infinity,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(children: [
//                     TextSpan(
//                       text: "Inside Burj al Arab\n",
//                       style: pageSubHeadingTextStyle,
//                     ),
//                     TextSpan(text: "Activities", style: infoTextStyle),
//                   ])),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Container(
//             height: AppDimension.getHeight(context) * .72,
//             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: btnColor)),
//             child: Column(
//               children: [
//                 Container(
//                   // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(viewImg), fit: BoxFit.fill)),
//                   height: AppDimension.getHeight(context) * .2,
//                 ),
//                 const SizedBox(height: 10),

//                 ///Details
//                 Container(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Country",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "Abu Dhabi",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "State",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "Abu Dhabi",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "City",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "Dhabi",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Activity Name",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "Inside Burj al Arab",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Opening Time",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "10:00 AM - 06:00 PM",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Activity Hours",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "7 Hours",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Price",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "67 AED / Person",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Suitable",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: Text(
//                               "Adult, Child, Infant, Teens, Senior",
//                               style: titleTextStyle1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 30,
//                             child: Text(
//                               "Term & Condition",
//                               style: titleTextStyle,
//                             ),
//                           ),
//                           SizedBox(
//                             // height: 30,
//                             width: 205,
//                             child: Text(
//                               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                               style: titleTextStyle1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
