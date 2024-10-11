import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_cab/view/vendor-side/add_vehicle_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

class AddNewVehicleScreen extends StatefulWidget {
  const AddNewVehicleScreen({super.key});

  @override
  State<AddNewVehicleScreen> createState() => _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<AddNewVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      // Replace 'https://your-upload-endpoint' with your actual upload endpoint
      var url = Uri.parse('https://your-upload-endpoint');

      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(234, 233, 226, 1),
      appBar: AppBar(
        title: const Text('Add New Vehicle'),
        backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Owner Name',
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Owner Name';
                        }
                        return null;
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Car Name',
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Car Name';
                        }
                        return null;
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Brand Name',
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Brazil",
                    "Italia (Disabled)",
                    "Tunisia",
                    'Canada'
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Select Brand",
                      hintText: "Select Brand",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Seats',
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Brazil",
                    "Italia (Disabled)",
                    "Tunisia",
                    'Canada'
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Select Seats",
                      hintText: "Select Seats",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Car Type',
                ),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Brazil",
                    "Italia (Disabled)",
                    "Tunisia",
                    'Canada'
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Car Type",
                      hintText: "Select Car Type",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Fuel Type'),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Brazil",
                    "Italia (Disabled)",
                    "Tunisia",
                    'Canada'
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Select Fuel",
                      hintText: "Select Fuel",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Year'),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Brazil",
                    "Italia (Disabled)",
                    "Tunisia",
                    'Canada'
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Select Year",
                      hintText: "Select Year",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Trim'),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Brazil",
                    "Italia (Disabled)",
                    "Tunisia",
                    'Canada'
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Select Trim",
                      hintText: "Select Trim",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Model No'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Vehicle No.'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Colors'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Doors'),
                const SizedBox(
                  height: 5,
                ),
                DropdownSearch<String>(
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const ["Select Doors", "Italia", "Tunisia", 'Canada'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Select Doors",
                      hintText: "Select Doors",
                    ),
                  ),
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Driving Licence'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Owner Phon No.'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: IntlPhoneField(
                    flagsButtonPadding: const EdgeInsets.all(8.0),
                    keyboardType: TextInputType.phone,
                    dropdownIconPosition: IconPosition.trailing,
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Address '),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Base Location'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder()),
                    )),
                // Container(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       _image == null
                //           ? Text('No image selected.')
                //           : Image.file(_image!),
                //       SizedBox(height: 20),
                //       ElevatedButton(
                //         onPressed: () => _pickImage(ImageSource.camera),
                //         child: Text('Take Picture'),
                //       ),
                //       ElevatedButton(
                //         onPressed: () => _pickImage(ImageSource.gallery),
                //         child: Text('Pick from Gallery'),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Upload Photo'),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(196, 195, 192, 1),
                            ),
                            width: 200,
                            height: 200,
                            child: Icon(
                              Icons.add,
                              size: 80,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(123, 30, 52, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Add Vehicle secusess')));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddVehicleScreen()));
                      }
                    },
                    child: const Text(
                      'ADD VEHICLE',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
