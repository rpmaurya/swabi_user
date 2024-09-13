import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/utils/color.dart';

class Customtabbar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> viewchildren;
  final TabController? controller;
  final void Function(int)? onTap;
  const Customtabbar(
      {super.key,
      required this.tabs,
      required this.viewchildren,
      this.controller,
      this.onTap});

  @override
  State<Customtabbar> createState() => _CustomtabbarState();
}

class _CustomtabbarState extends State<Customtabbar> {
  @override
  Widget build(BuildContext context) {
    return PageLayout_Page(
        child: Column(
      children: [
        Container(
            // width: AppDimension.getWidth(context) * .9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: background,
                border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
            child: TabBar(
              // isScrollable: true,
              controller: widget.controller,
              onTap: widget.onTap,
              indicatorSize: TabBarIndicatorSize.tab,
              // indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: btnColor),
                  color: btnColor),
              tabAlignment: TabAlignment.fill,
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              // indicatorPadding: EdgeInsets.zero,
              labelColor: background,
              dividerColor: Colors.transparent,
              unselectedLabelColor: blackColor,
              tabs: List.generate(widget.tabs.length, (index) {
                return Tab(
                  child: Text(
                    widget.tabs[index].toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                );
              }),
            )),
        SizedBox(height: 10),
        Expanded(
            child: TabBarView(
                controller: widget.controller, children: widget.viewchildren))
      ],
    ));
  }
}
