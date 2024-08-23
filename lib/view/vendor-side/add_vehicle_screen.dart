import 'package:flutter/material.dart';
import 'package:flutter_cab/view/vendor-side/add_new_vehicle_screen.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final List<String> options = ['Car Type', 'Option 2', 'Option 3'];
  final List<String> options1 = ['Seat', 'Option 2', 'Option 3'];
  final List<String> options2 = ['Fuel Type', 'Option 2', 'Option 3'];

  String selectedOption = 'Car Type';
  String selectedOption1 = 'Seat';
  String selectedOption2 = 'Fuel Type';
  // final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: ListView(children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                height: 35,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.filter_alt_outlined),
                    ),
                    Text(
                      'AVAILABLE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
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
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddNewVehicleScreen())),
                          },
                      child: const Text(
                        'ADD VEHICLE',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            // padding: EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width,
                            // height: 250,
                            // child: PaginatedDataTable(
                            //   headingRowColor: MaterialStatePropertyAll(
                            //     Color.fromRGBO(194, 226, 236, 0.925),
                            //   ),
                            //   columns: [
                            //     DataColumn(label: Text('NAME')),
                            //     DataColumn(label: Text('HOUR')),
                            //     DataColumn(label: Text('KM')),
                            //     DataColumn(label: Text('CREATED DATE')),
                            //     DataColumn(label: Text('STATUS')),
                            //     DataColumn(label: Text('Action')),
                            //   ],
                            //   source: _data,
                            //   columnSpacing: 50,
                            //   horizontalMargin: 40,
                            //   rowsPerPage: 5,
                            //   showCheckboxColumn: true,
                            // ),
                          ),
                        ),
                      ]),
                    )),
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
