// import 'dart:math';

import 'package:flutter/material.dart';

class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "name": "Name ",
            "hour": index,
            "km": index,
            "created_date": DateTime.now(),
            "status": 'true',
            "action": const Icon(Icons.abc),
          });

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(onSelectChanged: (selected) {}, cells: [
      const DataCell(Text('ramkewal')),
      const DataCell(Text('1')),
      const DataCell(Text('10')),
      const DataCell(Text('23-1-2024')),
      DataCell(Container(
          width: 45,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.green),
          child: const Center(
              child: Text(
            'true',
            style: TextStyle(color: Colors.white),
          )))),
      DataCell(
        Center(
          child: PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: const Text('View'),
                      leading: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Edit Rental Package'),
                                      Container(
                                        padding: const EdgeInsets.only(left: 22),
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
                                      width: MediaQuery.of(context).size.width,
                                      // height: 400,
                                      child: Form(
                                          child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Rental Name',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Rental Hours',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Rental KM',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'KM/Price',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Min/Fare',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Base Location',
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border:
                                                        OutlineInputBorder()),
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 56,
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
                                                // if (_formKey.currentState!.validate()) {
                                                //   ScaffoldMessenger.of(context).showSnackBar(
                                                //       SnackBar(content: Text('Login secusess')));
                                                //   Navigator.pushReplacement(
                                                //       context,
                                                //       MaterialPageRoute(
                                                //           builder: (context) =>
                                                //               VendorDashboardScreen()));
                                                // }
                                              },
                                              child: const Text(
                                                'Edit Rental Package',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ));
                      },
                      title: const Text('edit'),
                      leading: const Icon(Icons.edit_document),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: const Text('delete'),
                      leading: const Icon(Icons.delete),
                    ),
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
      ),
    ]);
  }
}
