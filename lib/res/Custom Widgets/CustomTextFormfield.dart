import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';

class Customtextformfield extends StatefulWidget {
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
  final bool? enabled;
  final Widget? suffixIcons;
  final Color? fillColor;
  final FocusNode? focusNode;
  final String? errorText;
  final double? width;
  final double? hieght;
  const Customtextformfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.obscureText,
      this.maxLines,
      this.minLines = 1,
      this.textLength,
      this.obscuringCharacter,
      this.keyboardType,
      this.suffixIcons,
      this.fillColor,
      this.onChanged,
      this.enabled,
      this.focusNode,
      this.errorText,
      this.width,
      this.hieght});

  @override
  State<Customtextformfield> createState() => _CustomtextformfieldState();
}

class _CustomtextformfieldState extends State<Customtextformfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.hieght,
      width: widget.width,
      child: TextFormField(
        focusNode: widget.focusNode,
        obscureText: widget.obscureText ?? false,
        controller: widget.controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.textLength),
        ],
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        decoration: InputDecoration(
            errorText: widget.errorText,
            suffixIcon: widget.suffixIcons,
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
                color: redColor,
                // width: 2.0,
              ),
            )

            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(12),
            //     borderSide: BorderSide(color: Color(0xFFCDCDCD))),
            ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
