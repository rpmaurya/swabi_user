import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';

class TimePickerDropdown extends StatefulWidget {
  final TextEditingController controller;
  const TimePickerDropdown({super.key, required this.controller});

  @override
  _TimePickerDropdownState createState() => _TimePickerDropdownState();
}

class _TimePickerDropdownState extends State<TimePickerDropdown> {
  int? selectedHour;
  int? selectedMinute;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTime);
    widget.controller.text = formatTimeAsJson(selectedHour, selectedMinute);
     reset;
  }

  void reset() {
    setState(() {
      selectedHour = null;
      selectedMinute = null;
      widget.controller.text = formatTimeAsJson(selectedHour, selectedMinute);
    });
  }

  void _updateTime() {
    print("Time updated: ${widget.controller.text}");
  }

  String formatTimeAsJson(int? hour, int? minute) {
    final formattedHour = hour != null ? hour.toString().padLeft(2, '0') : '00';
    final formattedMinute = minute != null ? minute.toString().padLeft(2, '0') : '00';
    return "$formattedHour:$formattedMinute";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: CustomText(
            content: "Time",
            textColor: blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: naturalGreyColor.withOpacity(0.3)
                    )),
                width: 170,
                child: DropdownButton2<int>(
                  isExpanded: true,
                  hint: const CustomText(
                    content: 'Select Hour',
                    fontSize: 16,
                    textColor: greyColor1,
                    fontWeight: FontWeight.w600,
                  ),
                  value: selectedHour,
                  style: titleTextStyle,
                  dropdownStyleData: const DropdownStyleData(
                      decoration: BoxDecoration(
                          color: background
                      ),
                      maxHeight: 250),
                  underline: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide.none)
                    ),
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedHour = newValue!;
                      widget.controller.text = formatTimeAsJson(selectedHour, selectedMinute);
                    });
                    // print("Selected time: ${widget.controller.text}");
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    24,
                        (int index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text('$index', style: titleTextStyle,),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const CustomText(content: ":", fontSize: 30,),
              Container(
                decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: naturalGreyColor.withOpacity(0.3)
                    )),
                width: 170,
                child: DropdownButton2<int>(
                  hint: const CustomText(
                    content: 'Select Min',
                    fontSize: 16,
                    textColor: greyColor1,
                    fontWeight: FontWeight.w600,
                  ),
                  underline: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide.none)
                    ),
                  ),
                  dropdownStyleData: const DropdownStyleData(
                      decoration: BoxDecoration(
                          color: background
                      ),
                      maxHeight: 250),
                  value: selectedMinute,
                  isExpanded: true,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMinute = newValue!;
                      widget.controller.text = formatTimeAsJson(selectedHour, selectedMinute);
                    });
                    print("Selected time: ${widget.controller.text}");
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    4,
                        (int index) {
                      int value = index * 15;
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(value == 0 ? '00' : '$value', style: titleTextStyle,),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class TimePickerDropdown extends StatefulWidget {
//   final TextEditingController controller;
//   const TimePickerDropdown({super.key, required this.controller});
//
//   @override
//   _TimePickerDropdownState createState() => _TimePickerDropdownState();
// }
//
// class _TimePickerDropdownState extends State<TimePickerDropdown> {
//   int? selectedHour;
//   int? selectedMinute;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     widget.controller.text = formatTimeAsJson(selectedHour, selectedMinute);
//   }
//
//   String formatTimeAsJson(int? hour, int? minute) {
//     final formattedHour = hour != null ? hour.toString().padLeft(2, '0') : '00';
//     final formattedMinute = minute != null ? minute.toString().padLeft(2, '0') : '00';
//     return '{"pickupTime": "$formattedHour:$formattedMinute"}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(padding: EdgeInsets.only(left: 10,bottom: 5),
//         child: CustomText(
//           content: "Time",
//           textColor: blackColor,
//           fontSize: 16,
//           fontWeight: FontWeight.w600,
//         ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: background,
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                   color: naturalGreyColor.withOpacity(0.3)
//                 )),
//                 width: 170,
//                 child: DropdownButton2<int>(
//                   isExpanded: true,
//                   hint: const CustomText(
//                     content: 'Select Hour',
//                     fontSize: 16,
//                     textColor: greyColor1,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   value: selectedHour,
//                   style: titleTextStyle,
//                   dropdownStyleData: const DropdownStyleData(
//                     decoration: BoxDecoration(
//                       color: background
//                     ),
//                     maxHeight: 250),
//                   underline: Container(
//                     decoration: const BoxDecoration(
//                         border: Border(bottom: BorderSide.none)
//                     ),
//                   ),
//                   onChanged: (int? newValue) {
//                     setState(() {
//                       selectedHour = newValue!;
//                     });
//                   },
//                   items: List<DropdownMenuItem<int>>.generate(
//                     25,
//                         (int index) {
//                       return DropdownMenuItem<int>(
//                         value: index,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 30),
//                           child: Text('$index',style: titleTextStyle,),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//              const CustomText(content: ":",fontSize: 30,),
//               Container(
//                 decoration: BoxDecoration(
//                     color: background,
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                     color: naturalGreyColor.withOpacity(0.3)
//                 )),
//                 width: 170,
//                 child: DropdownButton2<int>(
//                   hint: const CustomText(
//                     content: 'Select Min',
//                     fontSize: 16,
//                     textColor: greyColor1,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   underline: Container(
//                     decoration: const BoxDecoration(
//                       border: Border(bottom: BorderSide.none)
//                     ),
//                   ),
//                   dropdownStyleData: const DropdownStyleData(
//                       decoration: BoxDecoration(
//                           color: background
//                       ),
//                     maxHeight: 250),
//                   value: selectedMinute,
//                   isExpanded: true,
//                   onChanged: (int? newValue) {
//                     setState(() {
//                       selectedMinute = newValue!;
//                     });
//                   },
//                   items: List<DropdownMenuItem<int>>.generate(
//                     4,
//                         (int index) {
//                       int value = index * 15;
//                       return DropdownMenuItem<int>(
//                         value: value,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 30),
//                           child: Text(value == 0 ? '00' : '$value',style: titleTextStyle,),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
