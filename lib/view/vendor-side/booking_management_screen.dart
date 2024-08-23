import 'package:flutter/material.dart';
// import 'package:flutter_cab/custom_widget/booking_management_data.dart';

class BookingManagementScreen extends StatefulWidget {
  const BookingManagementScreen({super.key});

  @override
  State<BookingManagementScreen> createState() =>
      _BookingManagementScreenState();
}

class _BookingManagementScreenState extends State<BookingManagementScreen> {
  // final DataTableSource data = BookinMyData();
  final List<String> options = [
    'UP Comming Rides',
    'On-going Rides',
    'Completed Rides',
    'Cancell Rides',
    'Reschedules Rides'
  ];

  String selectedOption = 'UP Comming Rides';

  final TextEditingController _searchData = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      appBar: AppBar(
        title: const Text('Booking Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            child: ListView(children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Form(
                    child: TextFormField(
                      controller: _searchData,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                      ),
                      onChanged: (String searchData) {
                        setState(() {
                          searchData = searchData;
                        });
                      },
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 35,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Icons.filter_alt_outlined),
                        ),
                        Container(
                          // padding: EdgeInsets.only(left: 5),
                          child: DropdownButton<String>(
                              value: selectedOption,
                              hint: const Text('dsdsddsd'),
                              items: options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                              }),
                        ),
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
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 250,
                        // child: PaginatedDataTable(
                        //   dataRowMaxHeight: 70.0,
                        //   headingRowColor: MaterialStatePropertyAll(
                        //     Color.fromRGBO(194, 226, 236, 0.925),
                        //   ),
                        //   columns: [
                        //     DataColumn(
                        //         label: Container(
                        //             padding: EdgeInsets.only(left: 40),
                        //             child: Text('USER NAME'))),
                        //     DataColumn(label: Text('PACKAGE NAME')),
                        //     DataColumn(label: Text('PICK-UP LOCATION')),
                        //     DataColumn(label: Text('START TIME')),
                        //     DataColumn(label: Text('CAR TYPE')),
                        //     DataColumn(label: Text('SEAT')),
                        //     DataColumn(label: Text('FUEL TYPE')),
                        //     DataColumn(label: Text('CREATED DATE')),
                        //     DataColumn(label: Text('STATUS')),
                        //     DataColumn(label: Text('Action')),
                        //   ],
                        //   source: data,
                        //   columnSpacing: 20,
                        //   horizontalMargin: 10,
                        //   rowsPerPage: 5,
                        //   showCheckboxColumn: false,
                        // ),
                      ),
                    )),
              ],
            ),
          ),
        ])),
      ),
    );
  }
}
