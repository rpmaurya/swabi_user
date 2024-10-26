import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Term & Condition",
      ),
      body: PageLayout_Page(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("TERMS AND CONDITIONS",
              style: pageHeadingTextStyle, textAlign: TextAlign.left),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: AppDimension.getHeight(context) * .9,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: background, borderRadius: BorderRadius.circular(5)),
            child: Text(
                "This agreement forms the basis of an enforceable legal relationship. It tells anyone browsing your website, whether they are a casual visitor or an active client, what their legal responsibilities and rights are."
                "It also gives you, as the business owner and service provider, authority over certain undesirable things that a consumer may do on your website. However, let's consider the specific reasons why business owners should always include a Terms and Conditions agreement on their website.",
                style: termCondition,
                textAlign: TextAlign.left),
          ),
          const SizedBox(
            height: 25,
          ),
          // Text("CONTACT US - CUSTOMER SERVICE",
          //     style: pageHeadingTextStyle, textAlign: TextAlign.left),
          // const SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          //   decoration: BoxDecoration(
          //       color: background, borderRadius: BorderRadius.circular(5)),
          //   width: AppDimension.getHeight(context) * .9,
          //   child: Text(
          //       "Lorem ipsum dolor sit amet consecrate disciplining elite Ut et "
          //       "mass mi. Aliquot in ditherer urn. Interpellates sit amet "
          //       "sapiens flavoring, mattes gulag consecrate, ult rices.",
          //       style: pageSubHeadingTextStyle,
          //       textAlign: TextAlign.left),
          // ),
        ],
      )),
    );
  }
}
