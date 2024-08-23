import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/color.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgGreyColor,
      appBar: CustomAppBar(
        heading: "My Cards",
      ),
      body:PageLayout_Page(
          child: Column(
            children: [

            ],
          )),
    );
  }
}
