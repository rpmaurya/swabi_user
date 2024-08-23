import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewBookingscreen extends StatefulWidget {
  const ViewBookingscreen({super.key});

  @override
  State<ViewBookingscreen> createState() => _ViewBookingscreenState();
}

class _ViewBookingscreenState extends State<ViewBookingscreen> {
  bool isExpanded = false;
  bool isVisible = false;
  bool isVisible1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      appBar: AppBar(title: const Text('View Booking')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  shadowColor: Colors.red,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/th.jpeg',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                              height: 200,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Container(
                                child: const Center(
                                    child: Text(
                                  'User Information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                )),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: Text(
                                      isExpanded ? 'Read Less' : 'Read More',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // ListView.builder(
                        //   scrollDirection: Axis.vertical,
                        //   shrinkWrap: true,
                        //   itemCount: isExpanded ? 1 : 1,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     if (isExpanded) {
                        //       return Container(
                        //         child: Column(
                        //           children: [
                        //             ListTile(
                        //               title: Text('Status'),
                        //               trailing: Container(
                        //                   width: 60,
                        //                   height: 25,
                        //                   decoration: BoxDecoration(
                        //                       color: Colors.red,
                        //                       borderRadius:
                        //                           BorderRadius.circular(10)),
                        //                   child: Center(
                        //                     child: Text(
                        //                       'Active',
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 12),
                        //                     ),
                        //                   )),
                        //             ),
                        //             Divider(
                        //               height: 1,
                        //             ),
                        //             ListTile(
                        //               title: Text('First Name'),
                        //               trailing: Text(
                        //                 'Ramesh',
                        //                 style: TextStyle(fontSize: 14),
                        //               ),
                        //             ),
                        //             Divider(
                        //               height: 1,
                        //             ),
                        //             ListTile(
                        //               title: Text('Last Name'),
                        //               trailing: Text(
                        //                 'Kumar',
                        //                 style: TextStyle(fontSize: 14),
                        //               ),
                        //             ),
                        //             Divider(
                        //               height: 1,
                        //             ),
                        //             ListTile(
                        //               title: Text('Email'),
                        //               trailing: Text(
                        //                 'ramesh@gmail.com',
                        //                 style: TextStyle(fontSize: 14),
                        //               ),
                        //             ),
                        //             Divider(
                        //               height: 1,
                        //             ),
                        //             ListTile(
                        //               title: Text('Phone No'),
                        //               trailing: Text(
                        //                 '9878667768',
                        //                 style: TextStyle(fontSize: 14),
                        //               ),
                        //             ),
                        //             Divider(
                        //               height: 1,
                        //             ),
                        //             ListTile(
                        //               title: Text('Gender'),
                        //               trailing: Text(
                        //                 'male',
                        //                 style: TextStyle(fontSize: 14),
                        //               ),
                        //             ),
                        //             Divider(
                        //               height: 1,
                        //             ),
                        //             ListTile(
                        //               title: Text('Address'),
                        //               trailing: Text(
                        //                 'noida up ',
                        //                 style: TextStyle(fontSize: 14),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     } else {
                        //       return ListTile(
                        //         title: Text('Status'),
                        //         trailing: Container(
                        //             width: 60,
                        //             height: 25,
                        //             decoration: BoxDecoration(
                        //                 color: Colors.red,
                        //                 borderRadius:
                        //                     BorderRadius.circular(10)),
                        //             child: Center(
                        //               child: Text(
                        //                 'Active',
                        //                 style: TextStyle(
                        //                     color: Colors.white, fontSize: 12),
                        //               ),
                        //             )),
                        //       );
                        //     }
                        //   },
                        // ),
                        ListTile(
                          title: const Text('Status'),
                          trailing: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  'Active',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )),
                        ),
                        Visibility(
                          visible: isExpanded,
                          child: Container(
                            child: const Column(
                              children: [
                                Divider(
                                  height: 1,
                                ),
                                ListTile(
                                  title: Text('First Name'),
                                  trailing: Text(
                                    'Ramesh',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                ListTile(
                                  title: Text('Last Name'),
                                  trailing: Text(
                                    'Kumar',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                ListTile(
                                  title: Text('Email'),
                                  trailing: Text(
                                    'ramesh@gmail.com',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                ListTile(
                                  title: Text('Phone No'),
                                  trailing: Text(
                                    '9878667768',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                ListTile(
                                  title: Text('Gender'),
                                  trailing: Text(
                                    'male',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                ListTile(
                                  title: Text('Address'),
                                  trailing: Text(
                                    'noida up ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 2,
                  // clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Booking Details',
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                            subtitle: Text(
                                'basic info, for a rental faster booking exprience',
                                style: GoogleFonts.lato(
                                    fontSize: 11,
                                    color: const Color.fromRGBO(0, 0, 0, 0.5))),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Text(isVisible ? 'Read Less' : 'Read More',
                                  style: GoogleFonts.lato(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue)),
                            ),
                          ),
                          Visibility(
                              visible: isVisible,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Created Date',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '25-01-2024',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pick-Up Point',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Delhi,India',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pick-Up Longitute',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '77.102789890',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Extra Time Fare',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '6 Rs for 4 hours',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Time',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '2:10',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pick Up latitute',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '28.708960',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Extra Km Fare',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '24rs after 40KMS',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Booking price',
                                            style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '950rs /-',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 0.5)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.red,
                  surfaceTintColor: Colors.white,
                  elevation: 2,
                  // clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            title: Text('Vehicle Details',
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                            subtitle: Text('basic info, for a rental vehicle',
                                style: GoogleFonts.lato(
                                    fontSize: 11,
                                    color: const Color.fromRGBO(0, 0, 0, 0.5))),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible1 = !isVisible1;
                                });
                              },
                              child: Text(
                                  isVisible1 ? 'Read Less' : 'Read More',
                                  style: GoogleFonts.lato(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue)),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isVisible1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 10),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Status',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.red,

                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            'BOOKED',
                                            style: GoogleFonts.lato(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Vehicle Type',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'SUV',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Vehicle Name',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Audi X8',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Vehicle No',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '72789890',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fuel Type ',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Petrol',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Model No',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '34652',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Owner Name',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Aman2',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Brand Name',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'BMW',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Seats',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '5',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Colors',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'red',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Year',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '2022',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Trim',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Base',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Owner Mobile No',
                                        style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '9899789098',
                                        style: GoogleFonts.lato(
                                            fontSize: 11,
                                            color:
                                                const Color.fromRGBO(0, 0, 0, 0.5)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vehicle Images',
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'basic images,for a rental vehicle',
                              style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(0, 0, 0, 0.5)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/images/th.jpeg')),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
