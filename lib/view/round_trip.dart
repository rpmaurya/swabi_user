// // ignore_for_file: unnecessary_null_comparison, camel_case_types, constant_identifier_names, depend_on_referenced_packages, non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// // import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// enum Destination { one_way_trip, round_trip }

// class round_trip_screen extends StatefulWidget {
//   const round_trip_screen({super.key});

//   @override
//   State<round_trip_screen> createState() => _round_trip_screenState();
// }

// class _round_trip_screenState extends State<round_trip_screen> {
//   Destination? _destination = Destination.round_trip;
//   DateTime selectedDate = DateTime.now();
//   DateTime selectedDate2 = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SafeArea(
//             child: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 20,
//                 ),
//                 child: Column(children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: ListTile(
//                       leading: const Icon(
//                         Icons.arrow_back,
//                         size: 20,
//                       ),
//                       title: Text(
//                         'Destination',
//                         style: GoogleFonts.lato(
//                             color: const Color.fromRGBO(0, 0, 0, 1),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                           child: ListTile(
//                         title: const Text('One way Trip'),
//                         leading: Radio<Destination>(
//                           value: Destination.one_way_trip,
//                           groupValue: _destination,
//                           onChanged: (Destination? value) {
//                             setState(() {
//                               _destination = value;
//                             });
//                           },
//                         ),
//                       )),
//                       Expanded(
//                           child: ListTile(
//                         title: const Text('Round Trip'),
//                         leading: Radio<Destination>(
//                           value: Destination.round_trip,
//                           groupValue: _destination,
//                           onChanged: (Destination? value) {
//                             setState(() {
//                               _destination = value;
//                             });
//                           },
//                         ),
//                       ))
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Column(children: [
//                     ListTile(
//                       minVerticalPadding: 0,
//                       dense: true,
//                       leading: Padding(
//                         padding: const EdgeInsets.only(left: 3),
//                         child: const Icon(Icons.radio_button_checked),
//                       ),
//                       title: Transform.translate(
//                         offset: Offset(0, 15),
//                         child: TextField(
//                           decoration: InputDecoration(
//                               focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide.none),
//                               enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                               ),
//                               hintText: 'Current Location',
//                               hintStyle: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color:
//                                       const Color.fromRGBO(59, 65, 86, 0.7))),
//                         ),
//                       ),
//                       subtitle: const Divider(),
//                     ),
//                     Transform.translate(
//                       offset: const Offset(0, -25),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 30),
//                         child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Image.asset(
//                                 'assets/images/icons/dotted-line.png')),
//                       ),
//                     ),
//                     Transform.translate(
//                       offset: const Offset(0, -25),
//                       child: ListTile(
//                         minVerticalPadding: 0,
//                         dense: true,
//                         leading: Transform.translate(
//                           offset: const Offset(0, -20),
//                           child: Container(
//                             width: 28,
//                             decoration: BoxDecoration(
//                                 border: Border.all(width: 1),
//                                 shape: BoxShape.circle),
//                             child: const Center(child: Text('1')),
//                           ),
//                         ),
//                         title: Transform.translate(
//                           offset: const Offset(0, -15),
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide.none),
//                                 enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 hintText: 'Burj Khalifa',
//                                 hintStyle: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         const Color.fromRGBO(59, 65, 86, 0.7))),
//                           ),
//                         ),
//                         subtitle: Transform.translate(
//                             offset: const Offset(0, -10),
//                             child: const Divider()),
//                         trailing: Transform.translate(
//                           offset: const Offset(0, 18),
//                           child: Container(
//                             width: 40,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color.fromRGBO(234, 232, 232, 1)),
//                             child: const Center(
//                                 child: Icon(
//                               Icons.add,
//                               size: 30,
//                             )),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Transform.translate(
//                       offset: const Offset(0, -66),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 30),
//                         child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Image.asset(
//                                 'assets/images/icons/dotted-line.png')),
//                       ),
//                     ),
//                     Transform.translate(
//                       offset: const Offset(0, -80),
//                       child: ListTile(
//                         minVerticalPadding: 0,
//                         dense: true,
//                         leading: const Icon(
//                           Icons.add_location,
//                           size: 30,
//                         ),
//                         title: Transform.translate(
//                           offset: Offset(0, -5),
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide.none),
//                                 enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 hintText: 'Dubai Mall',
//                                 hintStyle: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         const Color.fromRGBO(59, 65, 86, 0.7))),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Transform.translate(
//                       offset: const Offset(0, -60),
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 18, left: 18),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Text(
//                                       'Departure Date',
//                                       style: GoogleFonts.lato(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 15,
//                                           color: const Color.fromRGBO(
//                                               0, 0, 0, 0.4)),
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () async {
//                                             DateTime? datePicked =
//                                                 await showDatePicker(
//                                                     context: context,
//                                                     initialDate: selectedDate,
//                                                     firstDate: DateTime(2024),
//                                                     lastDate: DateTime(2030));

//                                             if (datePicked != null) {
//                                               setState(() {
//                                                 selectedDate = datePicked;
//                                               });
//                                             }
//                                           },
//                                           child: const Icon(
//                                             Icons.calendar_month,
//                                             color: Color.fromRGBO(0, 0, 0, 0.4),
//                                             size: 20,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 8,
//                                         ),
//                                         Text(
//                                           selectedDate != null
//                                               ? DateFormat('dd MMMM, yyyy')
//                                                   .format(selectedDate)
//                                               : 'Select a date',
//                                           style: GoogleFonts.lato(
//                                             color: const Color.fromRGBO(
//                                                 0, 0, 0, 1),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Image.asset(
//                                     'assets/images/icons/vertical-line.png'),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       'Return Date',
//                                       style: GoogleFonts.lato(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 15,
//                                           color: const Color.fromRGBO(
//                                               0, 0, 0, 0.4)),
//                                     ),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Row(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () async {
//                                             DateTime? datePicked2 =
//                                                 await showDatePicker(
//                                                     context: context,
//                                                     initialDate: selectedDate2,
//                                                     firstDate: DateTime(2024),
//                                                     lastDate: DateTime(2030));

//                                             if (datePicked2 != null) {
//                                               setState(() {
//                                                 selectedDate2 = datePicked2;
//                                               });
//                                             }
//                                           },
//                                           child: const Icon(
//                                             Icons.calendar_month,
//                                             color: Color.fromRGBO(0, 0, 0, 0.4),
//                                             size: 20,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 8,
//                                         ),
//                                         Text(
//                                           selectedDate2 != null
//                                               ? DateFormat('dd MMMM, yyyy')
//                                                   .format(selectedDate2)
//                                               : 'Select a date',
//                                           style: GoogleFonts.lato(
//                                               color: const Color.fromRGBO(
//                                                   0, 0, 0, 1),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 25),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                       'assets/images/icons/search-places.png'),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     'Search Near by Places',
//                                     style: GoogleFonts.lato(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 15,
//                                         color: const Color.fromRGBO(
//                                             217, 115, 122, 1)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             _shoppix_mall(),
//                             const Divider(),
//                             _shoppix_mall(),
//                             const SizedBox(
//                               height: 25,
//                             ),
//                             Text(
//                               'Popular Places',
//                               style: GoogleFonts.lato(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                   color:
//                                       const Color.fromRGBO(217, 115, 122, 1)),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             _shoppix_mall(),
//                             const Divider(),
//                             _shoppix_mall(),
//                             const Divider(),
//                             _shoppix_mall(),
//                             const Divider(),
//                             _shoppix_mall(),
//                             const Divider(),
//                             _shoppix_mall(),
//                             GestureDetector(
//                               onTap: () {
//                                 HapticFeedback.heavyImpact();
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.only(top: 35),
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: BoxDecoration(
//                                     color: const Color.fromRGBO(123, 30, 52, 1),
//                                     borderRadius: BorderRadius.circular(12)),
//                                 child: Center(
//                                     child: Text(
//                                   'Search',
//                                   style: GoogleFonts.poppins(
//                                       color: const Color.fromRGBO(
//                                           255, 255, 255, 1),
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ]),
//                 ])),
//           ),
//         ));
//   }

//   _shoppix_mall() {
//     return ListTile(
//       contentPadding: const EdgeInsets.only(left: 0),
//       leading: const Icon(
//         Icons.add_location,
//         size: 30,
//       ),
//       title: Text(
//         'Shoppix Mall',
//         style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
//       ),
//       subtitle: Text(
//         'Surya Place Colony, Meerut,Uttar Pradesh 25...',
//         style: GoogleFonts.poppins(
//             fontSize: 12, color: const Color.fromRGBO(59, 65, 86, 0.7)),
//       ),
//       trailing: Container(
//         width: 30,
//         decoration: const BoxDecoration(
//             color: Color.fromRGBO(194, 33, 44, 1), shape: BoxShape.circle),
//         child: const Center(
//             child: Icon(
//           Icons.add,
//           size: 20,
//           color: Colors.white,
//         )),
//       ),
//     );
//   }
// }
