import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/color.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgGreyColor,
      appBar: CustomAppBar(
        heading: "My Booking",
      ),
      body: PageLayout_Page(
          child: Column(
            children: [

            ],
          )),
    );
  }
}
