import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';

// ignore: must_be_immutable
class CustomDropdownButton extends StatefulWidget {
  String? selecteValue;
  final String? hintText;
  final List<String> itemsList;
  final Function(dynamic)? onChanged;
  final FocusNode? focusNode;
  TextEditingController? controller;
  final List Function(BuildContext)? selectedItemBuilder;
  CustomDropdownButton(
      {super.key,
      required this.itemsList,
      required this.onChanged,
      required this.hintText,
      this.selecteValue,
      this.focusNode,
      this.controller,
      this.selectedItemBuilder});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      // alignment: Alignment.center,
      focusNode: widget.focusNode,

      // style: textTitleHint,
      menuMaxHeight: 300,
      decoration: InputDecoration(
        fillColor: background,
        filled: true,
        contentPadding:
            const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xFFCDCDCD))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xFFCDCDCD))),
        // hintText: widget.hintText,
        // alignLabelWithHint: true,
        enabled: true,
        // hintStyle: TextStyle(),
      ),
      hint: Text(
        '${widget.hintText}',
        textAlign: TextAlign.center,
        style: textTitleHint,
      ),
      isDense: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      items: widget.itemsList.toSet().map((String item) {
        return DropdownMenuItem(
            value: item,
            child: Container(
              // mar: const EdgeInsets.all(20.0),
              child: Text(item, style: titleTextStyle),
            ));
      }).toList(),
      onChanged: (value) {
        widget.selecteValue = value;
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        print(widget.selecteValue);
      },
      value: widget.selecteValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select Item';
        }
        return null;
      },
    );
  }
}
