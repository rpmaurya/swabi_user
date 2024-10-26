import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/utils/color.dart';

class CustomModalbottomsheet extends StatefulWidget {
  final String title;
  final Widget child;
  const CustomModalbottomsheet(
      {super.key, required this.title, required this.child});

  @override
  State<CustomModalbottomsheet> createState() => _CustomModalbottomsheetState();
}

class _CustomModalbottomsheetState extends State<CustomModalbottomsheet> {
  @override
  Widget build(BuildContext context) {
    return CustomButtonSmall(
        btnHeading: widget.title, onTap: _showModalBottomSheet);
  }

  Future<void> _showModalBottomSheet() {
    print('chxzbcbxnzc xzbnmxbmn nbmnc xkjchnxmc x');
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: background,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setstate) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: widget.child,
              ),
            );
          });
        });
  }
}
