import 'package:flutter/material.dart';

class RentalPackageScreen extends StatefulWidget {
  const RentalPackageScreen({super.key});

  @override
  State<RentalPackageScreen> createState() => _RentalPackageScreenState();
}

class _RentalPackageScreenState extends State<RentalPackageScreen> {
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
        title: const Text('Rental Package'),
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
              Container(
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
                                      'Add Rental Package',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.close_rounded)),
                                    )
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                      // height: 350,
                                      child: Form(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                labelText: 'Rental Name',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                labelText: 'Rental Hours',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                labelText: 'Rental Km',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                labelText: 'KM/Price',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                labelText: 'Min/Fare',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(),
                                                labelText: 'Base Location',
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
                                        'ADD RENTAL PACKAGE',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                      child: const Text(
                        'ADD RENTAL PACKAGE',
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
