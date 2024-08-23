import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class RentalManagementScreen extends StatefulWidget {
  const RentalManagementScreen({super.key});

  @override
  State<RentalManagementScreen> createState() => _RentalManagementScreenState();
}

class _RentalManagementScreenState extends State<RentalManagementScreen> {
  final List<String> options = ['Car Type', 'Option 2', 'Option 3'];
  final List<String> options1 = ['Seat', 'Option 2', 'Option 3'];
  final List<String> options2 = ['Fuel Type', 'Option 2', 'Option 3'];

  String selectedOption = 'Car Type';
  String selectedOption1 = 'Seat';
  String selectedOption2 = 'Fuel Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      appBar: AppBar(
        title: Text(
          'Rental Management',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: BorderSide.strokeAlignCenter,
        shadowColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: ListView(children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 80,
                    height: 35,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.filter_alt_outlined),
                        ),
                        Text(
                          'ALL',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromRGBO(123, 30, 52, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(11)))),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                titlePadding: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                ),
                                backgroundColor: Colors.white,
                                title: Row(
                                  children: [
                                    const Text(
                                      'Add Rental',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 110),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.close_rounded)),
                                    )
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: SizedBox(
                                      height: 350,
                                      child: Form(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Card Details',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromRGBO(
                                                      123, 30, 52, 1)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 110,
                                                  height: 40,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: selectedOption,
                                                    items: options
                                                        .map((String option) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: option,
                                                        child: Text(
                                                          option,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedOption = value!;
                                                      });
                                                    },
                                                    decoration: const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      filled: true,
                                                      fillColor: Colors.white,

                                                      // labelText: 'Select an option',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 110,
                                                  height: 40,
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: selectedOption1,
                                                    items: options1
                                                        .map((String option) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedOption1 =
                                                            value!;
                                                      });
                                                    },
                                                    decoration: const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      // labelText: 'Select an option',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: selectedOption2,
                                                items: options2
                                                    .map((String option) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: option,
                                                    child: Text(option),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    selectedOption2 = value!;
                                                  });
                                                },
                                                decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  // labelText: 'Select an option',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(),
                                            const Text(
                                              'Car Charges',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromRGBO(
                                                      123, 30, 52, 1)),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 110,
                                                  height: 40,
                                                  child: TextFormField(
                                                    decoration: const InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: 'Daily',
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 110,
                                                  height: 40,
                                                  child: TextFormField(
                                                    decoration: const InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: 'Hourly',
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 40,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Per Km',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 40,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Base Location',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                actions: <Widget>[
                                  Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Color.fromRGBO(
                                                      123, 30, 52, 1)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11)))),
                                      onPressed: () {},
                                      child: const Text(
                                        'ADD RENTAL',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                      child: const Text(
                        'ADD RENTAL',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                            width: 1, color: Color.fromRGBO(0, 0, 0, 0.4)),
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        1: FixedColumnWidth(100),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(100),
                        4: FixedColumnWidth(400),
                        5: FixedColumnWidth(100),
                      },
                      children: [
                        TableRow(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(194, 226, 236, 0.925),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            children: [
                              const Column(children: [
                                Icon(Icons.check_box_outline_blank)
                              ]),
                              const Column(children: [
                                Text(
                                  'CAR TYPE',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]),
                              const Column(children: [
                                Text(
                                  'SEAT',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]),
                              const Column(children: [
                                Text(
                                  'FUEL TYPE',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]),
                              Column(children: [
                                const Center(
                                    child: Text(
                                  'CAR CHARGES',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                                Table(
                                  border: TableBorder.all(color: Colors.white),
                                  children: const [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(194, 226, 236, 1),
                                        ),
                                        children: [
                                          Center(
                                              child: Text(
                                            'Day',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )),
                                          Center(
                                              child: Text(
                                            'Hourly',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )),
                                          Center(
                                              child: Text(
                                            'Per Km',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )),
                                          Center(
                                              child: Text(
                                            'Extra Km',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ))
                                        ])
                                  ],
                                ),
                              ]),
                              const Column(children: [
                                Text(
                                  'ACTION',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ]),
                            ]),
                        TableRow(children: [
                          const Center(child: Icon(Icons.check_box_outline_blank)),
                          const Center(child: Text('SEDAN')),
                          const Center(child: Text('4')),
                          const Center(child: Text('Diesel')),
                          Table(
                            children: const [
                              TableRow(children: [
                                Center(child: Text('700')),
                                Center(child: Text('80')),
                                Center(child: Text('15')),
                                Center(child: Text('0'))
                              ])
                            ],
                          ),
                          Center(
                            child: PopupMenuButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text("View"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ];
                                },
                                onSelected: (value) {
                                  if (value == 0) {
                                    print("My account menu is selected.");
                                  } else if (value == 1) {
                                    print("Settings menu is selected.");
                                  } else if (value == 2) {
                                    print("Logout menu is selected.");
                                  }
                                }),
                          ),
                        ]),
                        TableRow(children: [
                          const Center(child: Icon(Icons.check_box_outline_blank)),
                          const Center(child: Text('SEDAN')),
                          const Center(child: Text('4')),
                          const Center(child: Text('Diesel')),
                          Table(
                            children: const [
                              TableRow(children: [
                                Center(child: Text('700')),
                                Center(child: Text('80')),
                                Center(child: Text('15')),
                                Center(child: Text('0'))
                              ])
                            ],
                          ),
                          Center(
                            child: PopupMenuButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text("View"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ];
                                },
                                onSelected: (value) {
                                  if (value == 0) {
                                    print("My account menu is selected.");
                                  } else if (value == 1) {
                                    print("Settings menu is selected.");
                                  } else if (value == 2) {
                                    print("Logout menu is selected.");
                                  }
                                }),
                          ),
                        ]),
                        TableRow(children: [
                          const Center(child: Icon(Icons.check_box_outline_blank)),
                          const Center(child: Text('SEDAN')),
                          const Center(child: Text('4')),
                          const Center(child: Text('Diesel')),
                          Table(
                            children: const [
                              TableRow(children: [
                                Center(child: Text('700')),
                                Center(child: Text('80')),
                                Center(child: Text('15')),
                                Center(child: Text('0'))
                              ])
                            ],
                          ),
                          Center(
                            child: PopupMenuButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text("View"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 2,
                                      child: Text("Delete"),
                                    ),
                                  ];
                                },
                                onSelected: (value) {
                                  if (value == 0) {
                                    print("My account menu is selected.");
                                  } else if (value == 1) {
                                    print("Settings menu is selected.");
                                  } else if (value == 2) {
                                    print("Logout menu is selected.");
                                  }
                                }),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ])),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 35,
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(123, 30, 52, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            // showGeneralDialog(
            //   context: context,
            //   barrierColor: Colors.black54,
            //   // barrierDismissible: true,
            //   barrierLabel: 'Label',
            //   pageBuilder: (_, __, ___) {
            //     return Align(
            //       alignment: Alignment.bottomRight,
            //       child: Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Container(
            //           width: MediaQuery.of(context).size.width * 0.9,
            //           height: 500,
            //           color: Color.fromRGBO(234, 233, 226, 1),
            //           child: Container(
            //             child: Column(
            //               children: <Widget>[
            //                 Padding(
            //                   padding: const EdgeInsets.only(bottom: 20.0),
            //                   child: AppBar(
            //                     // toolbarHeight: 30.0,
            //                     automaticallyImplyLeading: false,
            //                     title: Text('Driver Charges'),
            //                     actions: [
            //                       Padding(
            //                         padding: const EdgeInsets.only(right: 10),
            //                         child: IconButton(
            //                             onPressed: () {
            //                               Navigator.pop(context);
            //                             },
            //                             icon: Icon(Icons.close_rounded)),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 Row(
            //                   children: [
            //                     Container(
            //                       width: 120,
            //                       child: Column(
            //                         children: [Text('data'), Text('dfgfghfgh')],
            //                       ),
            //                     ),
            //                     Container(
            //                       width: 120,
            //                       child: Column(
            //                         children: [Text('data'), Text('dfgfghfgh')],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //                 Row(),
            //                 Row(),
            //                 Row()
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
            //
            // showModalBottomSheet<void>(
            //   barrierColor: Colors.black54,
            //   isDismissible: true,
            //   // backgroundColor: Colors.white,
            //   context: context,
            //   builder: (BuildContext context) {
            //     return DriverChargesScreen();
            //   },
            // );
          },
          child: const Text(
            'DRIVER CHARGES',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
