import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/custom_datePicker/common_textfield.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/assets.dart';

class TourPackage extends StatefulWidget {
  const TourPackage({super.key});

  @override
  State<TourPackage> createState() => _TourPackageState();
}

class _TourPackageState extends State<TourPackage> {
  List<TextEditingController> textcontroller =
      List.generate(10, (index) => TextEditingController());

  List<String> country = [
    "Abu Dhabi",
    "America",
    "United Kingdom",
    "India",
    "Australia"
  ];

  GoogleMapController? googleMapController;

  int days = 0;
  int people = 0;

  @override
  Widget build(BuildContext context) {
    return PageLayout_Page(
      appHeading: "Tour Package",
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          DropDownTourButton(
            width: AppDimension.getWidth(context) * .9,
            heading: "Select Country ",
            countryName: country,
            hint: "Select Country",
            headingReq: true,
          ),
          const SizedBox(height: 10),
          DropDownTourButton(
            width: AppDimension.getWidth(context) * .9,
            heading: "Select State",
            hint: "Select State",
            countryName: country,
            headingReq: true,
          ),
          const SizedBox(height: 10),
          DropDownTourButton(
            width: AppDimension.getWidth(context) * .9,
            heading: "Select City",
            hint: "Select City",
            countryName: country,
            headingReq: true,
          ),
          const SizedBox(height: 10),
          CantainerNumberPlusMinus(
            headingReq: true,
            initialValue: 0,
            onChanged: (value1) {
              print(value1);
              days = value1;
            },
            heading: "Number of Days",
            hint: "0",
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Calender",
                  style: loginTextStyle,
                )),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePickerForm(
                    width: AppDimension.getWidth(context) * .4,
                    hint: "20-2-2024",
                    controller: textcontroller[0]),
                SizedBox(
                  width: 30,
                  child: Center(
                      child: Text(
                    "To",
                    style: titleTextStyle,
                  )),
                ),
                DatePickerForm(
                    width: AppDimension.getWidth(context) * .4,
                    hint: "20-2-2024",
                    controller: textcontroller[1])
              ],
            ),
          ),
          const SizedBox(height: 10),
          CantainerNumberPlusMinus(
            headingReq: true,
            initialValue: 0,
            onChanged: (value2) {
              print(value2);
              people = value2;
            },
            heading: "Number of People",
            hint: "0",
          ),
          const SizedBox(height: 10),
          DropDownTourButton(
            width: AppDimension.getWidth(context) * .9,
            heading: "Package Type",
            countryName: country,
            hint: "Select State",
            headingReq: true,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownTourButton(
                  width: AppDimension.getWidth(context) * .42,
                  heading: "Transfer",
                  countryName: country,
                  hint: "Select State",
                  headingReq: true,
                ),
                DropDownTourButton(
                  width: AppDimension.getWidth(context) * .42,
                  heading: "Transfer Type",
                  hint: "Select State",
                  countryName: country,
                  headingReq: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomButtonBig(
              btnHeading: "Search",
              onTap: () {
                print("Days $days" "People  $people");
                context.push("/package/tourPackage");
              }),
        ],
      ),
      // GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     zoom: 14,
      //     target: LatLng(28.6282346,77.3898596),
      //   ),
      //   onMapCreated: (controller) {
      //     setState(() {
      //       googleMapController = controller;
      //     });
      //   }),
    );
  }
}

///Drop Down Function
class DropDownTourButton extends StatefulWidget {
  final String heading;
  final double width;
  final String hint;
  final bool headingReq;
  final List<String> countryName;

  const DropDownTourButton(
      {required this.width,
      this.hint = "",
      this.headingReq = false,
      this.heading = "",
      super.key,
      required this.countryName});

  @override
  State<DropDownTourButton> createState() => _DropDownTourButtonState();
}

class _DropDownTourButtonState extends State<DropDownTourButton> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.headingReq
            ? Text(
                widget.heading,
                style: loginTextStyle,
              )
            : const SizedBox.shrink(),
        widget.headingReq ? const SizedBox(height: 5) : const SizedBox.shrink(),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 50,
            width: widget.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: curvePageColor)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down), iconSize: 30),
                isExpanded: true,
                hint: Text(
                  widget.hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: widget.countryName
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CantainerNumberPlusMinus extends StatefulWidget {
  final String heading;
  final String hint;
  final bool headingReq;
  final int initialValue;
  final void Function(int) onChanged;

  const CantainerNumberPlusMinus(
      {super.key,
      required this.heading,
      required this.initialValue,
      required this.onChanged,
      required this.hint,
      required this.headingReq});

  @override
  State<CantainerNumberPlusMinus> createState() =>
      _CantainerNumberPlusMinusState();
}

class _CantainerNumberPlusMinusState extends State<CantainerNumberPlusMinus> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void increment() {
    setState(() {
      _value++;
      widget.onChanged(_value);
    });
  }

  void decrement() {
    setState(() {
      _value--;
      widget.onChanged(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.headingReq
            ? Text(
                widget.heading,
                style: loginTextStyle,
              )
            : const SizedBox.shrink(),
        widget.headingReq ? const SizedBox(height: 5) : const SizedBox.shrink(),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: AppDimension.getWidth(context) * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: redColor,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: decrement,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(minus),
                      ),
                    ),
                  ),
                ),
                Text(
                  _value.toString(),
                  style: titleTextStyle,
                ),
                Material(
                  color: redColor,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: increment,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
