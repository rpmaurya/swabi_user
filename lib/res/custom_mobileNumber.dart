import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';

class CustomMobilenumber extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final int? textLength;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;
  final bool? enabled;
  final Widget? suffixIcons;
  final Color? fillColor;
  final String? countryCode;
  final FocusNode? focusNode;

  final double? width;
  final double? hieght;
  const CustomMobilenumber(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.countryCode,
      this.validator,
      this.obscureText,
      this.maxLines,
      this.minLines = 1,
      this.textLength,
      this.obscuringCharacter,
      this.textAlignVertical,
      this.keyboardType,
      this.suffixIcons,
      this.fillColor,
      this.onChanged,
      this.enabled,
      this.focusNode,
      this.width,
      this.hieght});

  @override
  State<CustomMobilenumber> createState() => _CustomMobilenumberState();
}

class _CustomMobilenumberState extends State<CustomMobilenumber> {
  String? errorText;
  final String uaePattern = r'^[569]\d{8}$';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.hieght,
      width: widget.width,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText ?? false,
        obscuringCharacter: widget.obscuringCharacter ?? '•',
        controller: widget.controller,
        style: titleTextStyle,
        textAlignVertical: widget.textAlignVertical,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.textLength),
        ],
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType ?? TextInputType.phone,
        enabled: widget.enabled,
        decoration: InputDecoration(
            errorText: errorText,
            suffixIcon: widget.suffixIcons,
            prefixIconConstraints: BoxConstraints(maxHeight: 25, maxWidth: 85),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/flag-AE.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '+${widget.countryCode ?? '971'}',
                    style: titleTextStyle,
                  ),
                ],
              ),
            ),
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            hintText: widget.hintText,
            hintStyle: textTitleHint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // border: InputBorder.none,
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
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                // color: redColor,
                color: Color(0xFFCDCDCD),
                // width: 2.0,
              ),
            )

            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(12),
            //     borderSide: BorderSide(color: Color(0xFFCDCDCD))),
            ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter phone number';
          } else if (value.length != widget.textLength) {
            return 'Enter Valid Phone Number';
          } else if (!RegExp(uaePattern).hasMatch(value)) {
            return 'Enter Valid Phone Number';
          }
          return null;
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}
