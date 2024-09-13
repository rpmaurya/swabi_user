import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class FormCommonSingleAlertSelector extends StatefulWidget {
  final String title;
  final String alertBoxTitle;
  final String initialValue;
  final bool border;
  final double? width;
  final double? elevation;
  final TextStyle? textStyle;
  final data;
  final bool iconReq;
  final Icon showIcon;
  final icon;
  final icons;
  final bool? numberOnly;
  final int? length;
  final TextEditingController controller;
  final onTap;

  const FormCommonSingleAlertSelector(
      {super.key,
      required this.title,
      this.icon,
      this.icons,
      this.numberOnly,
      this.width,
      this.elevation,
      this.textStyle,
      this.border = false,
      this.length,
      this.iconReq = false,
      required this.controller,
      required this.showIcon,
      this.onTap,
      required this.initialValue,
      required this.alertBoxTitle,
      required this.data});

  @override
  _FormCommonSingleAlertSelectorState createState() =>
      _FormCommonSingleAlertSelectorState();
}

class _FormCommonSingleAlertSelectorState
    extends State<FormCommonSingleAlertSelector> {
  String selectedValue = '';
  int sel = -1;

  @override
  void initState() {
    super.initState();
    widget.controller.text.isNotEmpty
        ? selectedValue = widget.controller.text
        : '';
    widget.controller.addListener(() {
      setState(() {
        selectedValue = widget.controller.text;
      });
    });
  }

  int receivedValue = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
            style: widget.textStyle ?? titleTextStyle,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            if (context.mounted) {
              _showCustomDialog(context, widget.controller, widget.data,
                  widget.alertBoxTitle);
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          child: Material(
            elevation: widget.elevation ?? 2,
            color: background,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 50,
              width: widget.width ?? AppDimension.getWidth(context) * .9,
              padding: const EdgeInsets.only(left: 12),
              decoration: ShapeDecoration(
                color: background,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: widget.border
                          ? naturalGreyColor.withOpacity(0.3)
                          : naturalGreyColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  widget.icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child:
                              Image.asset(widget.icon!, height: 25, width: 25),
                        )
                      : Container(),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicWidth(
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: AppDimension.getWidth(context) * .8,
                          ),
                          child: Row(
                            children: [
                              widget.controller.text.isEmpty
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: widget.iconReq
                                          ? widget.showIcon
                                          : const SizedBox.shrink(),
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Text(
                                  widget.controller.text.isEmpty
                                      ? widget.initialValue
                                      : widget.controller.text,
                                  style: GoogleFonts.lato(
                                    color: selectedValue.isEmpty
                                        ? greyColor1
                                        : textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: greyColor1,
                      )
                      // Image.asset(arrow_down,
                      //     height: 15.h,
                      //     width: 15.h,
                      //     fit: BoxFit.fill,
                      //     color: secondary),
                      )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCustomDialog(BuildContext context, TextEditingController controller,
      List<String> data, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: ContentBox(
                controller: controller,
                data: data,
                title: title,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContentBox extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final List<String> data;

  const ContentBox({
    Key? key,
    required this.controller,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  int selectedValue = -1;

  @override
  void initState() {
    super.initState();
    // Initialize selectedValue based on the controller's text
    if (widget.controller.text.isNotEmpty) {
      selectedValue = widget.data.indexOf(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: GoogleFonts.lato(
                    color: btnColor, // Replace with your desired color
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "X",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: widget.data.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedValue = index;
                    widget.controller.text = widget.data[selectedValue];
                    Navigator.pop(context, selectedValue);
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                child: RadioField(
                  title: widget.data[index],
                  isSelected: index == selectedValue,
                ),
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5)),
        ],
      ),
    );
  }
}

class RadioField extends StatefulWidget {
  final String title;
  final bool isSelected;

  const RadioField({
    Key? key,
    required this.title,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<RadioField> createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: widget.isSelected ? btnColor : greyColor,
                width: 2,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.isSelected ? btnColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                color: widget.isSelected ? textColor : cancelButtonTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
