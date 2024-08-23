import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/custom_ListTile.dart';
import 'package:flutter_cab/res/custom_Textfeild.dart';
import 'package:flutter_cab/res/custom_datePicker/common_textfield.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:go_router/go_router.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgGreyColor,
        appBar: const CustomAppBar(
          heading: "Edit Profile",
        ),
      body: PageLayout_Page(
        saveBtn: true,
        btnHeading: "Submit",
        onTap: () {
        },
        child: Column(
          children: [
            Custom_ListTile(
              img: profile,
              heading: "Profile",
              onTap: () => context.push("/registration"),
            ),
            const SizedBox(height: 10,),
            const CustomTextFeildWidget(),
            const SizedBox(height: 10,),
            // Custom_ListTileSwitch(),
            DatePickerForm(
              title: "Date Pick",
              controller: TextEditingController(),
            ),
            FormDatePicker(
              title: "Date Form",
              controller: TextEditingController(),
            ),
            TextFeildTiming(
              title: "Time Pick",
              controller: TextEditingController(),
            )
          ],
        ),
      ),
    );
  }
}
