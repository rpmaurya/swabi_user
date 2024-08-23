import 'package:flutter/material.dart';

class DriverChargesScreen extends StatefulWidget {
  const DriverChargesScreen({super.key});

  @override
  State<DriverChargesScreen> createState() => _DriverChargesScreenState();
}

class _DriverChargesScreenState extends State<DriverChargesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        // height: 1000,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
              automaticallyImplyLeading: false,
              title: const Text('Driver charges'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_rounded)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver Day Allowance',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Amount:40',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver Hourly Charge',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Amount:40',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver Night Charge',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Amount:40',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver Late Night Charge',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Amount:40',
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 4),
                          )
                        ]),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver Outstation Charge',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Amount:40',
                            style: TextStyle(fontSize: 11),
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(123, 30, 52, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)))),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        barrierColor: Colors.black54,
                        isDismissible: true,
                        // backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 560,
                              child: Column(
                                children: [
                                  AppBar(
                                    backgroundColor:
                                        const Color.fromRGBO(234, 233, 226, 1),
                                    automaticallyImplyLeading: false,
                                    title: const Text('Driver charges'),
                                    actions: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.close_rounded)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: Container(
                                      child: const Text(
                                        'Edit Driver Charges',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Driver Daily Charges'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.42,
                                                height: 40,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      label: const Text('Daily'),
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Driver Hourly Charges'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.42,
                                                height: 40,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      label: const Text('Hourly'),
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Driver Night Charges'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.42,
                                                height: 40,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      label: const Text('Night'),
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Driver Outstation Charges',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.42,
                                                height: 40,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      label: const Text('Outstation'),
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
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
                                                            BorderRadius
                                                                .circular(
                                                                    11)))),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'EDIT DRIVER DETAILS',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            padding: const EdgeInsets.only(right: 10),
                                            width: 100,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        const MaterialStatePropertyAll(
                                                            Color.fromRGBO(123,
                                                                30, 52, 1)),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        11)))),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'BACK',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                        style: ButtonStyle(
                            surfaceTintColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(123, 30, 52, 1)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(123, 30, 52, 1)),
                                    borderRadius: BorderRadius.circular(11)))),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Color.fromRGBO(123, 30, 52, 1),
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                  color: Color.fromRGBO(123, 30, 52, 1)),
                            )
                          ],
                        ),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
