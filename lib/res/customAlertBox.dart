import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:go_router/go_router.dart';

class CustomAlertBox extends StatefulWidget {
  final double? height;
  final double? btnWidthRight;
  final double? width;
  final double? btnWidthLeft;
  final String heading;
  final bool widgetReq;
  final bool crossIcon;
  final Widget? child;
  final String rightBtnHeading;
  final String leftBtnHeading;
  final bool rightBtnReq;
  final VoidCallback? rightOnTap;
  final VoidCallback? crossOnTap;
  // final VoidCallback? btnRightOnTap;
  final bool leftBtnReq;
  final VoidCallback? leftOnTap;
  // final VoidCallback? btnLeftOnTap;
  final String content;

  const CustomAlertBox(
      {super.key,
      this.height,
      this.btnWidthRight,
      this.width,
      this.btnWidthLeft,
      this.heading = "",
      this.rightBtnHeading = "",
      this.leftBtnHeading = "",
        this.widgetReq = false,
        this.crossIcon = false,
        this.child,
      this.rightBtnReq = false,
        this.rightOnTap,
        this.crossOnTap,
        // this.btnRightOnTap,
        // this.btnLeftOnTap,
      this.leftBtnReq = false,
       this.leftOnTap, this.content = ""});

  @override
  State<CustomAlertBox> createState() => _CustomAlertBoxState();
}

class _CustomAlertBoxState extends State<CustomAlertBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
      backgroundColor: background,
      surfaceTintColor: background,
      child: SizedBox(
        height: widget.height ?? AppDimension.getHeight(context)/3.5,
        width: widget.width ?? double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5))
              ),
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  CustomTextWidget(
                      content: widget.heading,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: background),
                  SizedBox(
                    width: 30,
                    height: 40,
                    child: widget.crossIcon ? IconButton(
                      icon: const Icon(Icons.cancel,color: background,),
                      onPressed: widget.crossOnTap ?? ()=> context.pop(),
                    ) : null,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: widget.widgetReq ? widget.child :
                        CustomText(
                           content:widget.content,
                          fontSize: 16,
                          maxline: 3,
                          fontWeight: FontWeight.w600,
                          textColor: textColor
                      ),

                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.leftBtnReq? CustomButtonSmall(
                          width: widget.btnWidthLeft,
                          btnHeading: widget.leftBtnHeading,
                          onTap: widget.leftOnTap ?? ()=> print("No Press"),
                        ):const SizedBox.shrink(),
                        widget.rightBtnReq ? CustomButtonSmall(
                          width: widget.btnWidthRight,
                          btnHeading: widget.rightBtnHeading,
                          onTap: widget.rightOnTap ?? ()=> print("Yes Press"),
                        ): const SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioButtonWithText extends StatefulWidget {
  final int value;
  final String text;
  final int groupValue;
  final ValueChanged<int> onChanged;

  const RadioButtonWithText({
    Key? key,
    required this.value,
    required this.text,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RadioButtonWithTextState createState() => _RadioButtonWithTextState();
}

class _RadioButtonWithTextState extends State<RadioButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: btnColor,
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: (int? value) {
            if (value != null) {
              widget.onChanged(value);
            }
          },
        ),
        Text(
          widget.text,
          style: titleTextStyle1,

        ),
      ],
    );
  }
}