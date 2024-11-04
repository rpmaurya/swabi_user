import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/offer_view_model.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:provider/provider.dart';

class OfferdetailsScreen extends StatefulWidget {
  const OfferdetailsScreen({super.key});

  @override
  State<OfferdetailsScreen> createState() => _OfferdetailsScreenState();
}

class _OfferdetailsScreenState extends State<OfferdetailsScreen> {
  bool isCopied = false;
  // Function to copy the text to the clipboard
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      setState(() {
        isCopied = true;
      });
      // Optionally reset "Copied" text after a few seconds
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isCopied = false;
        });
      });
    });
  }

  final List<String> terms = [
    "ffgffjgfjf",
    "gfhghdbmnbjhkdjjhnmdbjk nmkjkjbnhjkjkjh hkjjdjkdjkjdkj nkjkkjdjkj bjdkj",
    "gfg",
    "jagrthewr",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<OfferViewModel>(
      builder: (context, viewModel, child) {
        String termConditions =
            """${viewModel.offerDetailByIdModel?.data?.termsAndConditions}""";
        final document = html_parser.parse(termConditions);
        final List<String> termsList = [
          ...document.getElementsByTagName('p').map((p) => p.text.trim()),
          ...document.getElementsByTagName('li').map((li) => li.text.trim()),
        ];
        // final List<String> termsList = document
        //     .getElementsByTagName('li')
        //     .map((li) => li.text.trim())
        //     .toList();
        // if (termsList.isEmpty) {
        //   termsList.addAll(document
        //       .getElementsByTagName('p')
        //       .map((p) => p.text.trim())
        //       .toList());
        // }
        return Scaffold(
          appBar: const CustomAppBar(
            heading: 'Offer Details',
          ),
          body: PageLayout_Page(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          viewModel.offerDetailByIdModel?.data?.imageUrl ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23qSvFQm2bH4nUAwxBk7ZzBQm5Qi__4imxg&s',
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${viewModel.offerDetailByIdModel?.data?.offerName}',
                        style: textTitleHeading,
                      ),

                      Text(
                        'Save up to AED ${viewModel.offerDetailByIdModel?.data?.maxDiscountAmount?.toInt()} on ${viewModel.offerDetailByIdModel?.data?.bookingType == 'RENTAL_BOOKING' ? 'RENTAL BOOKING' : "PACKAGE BOOKING"}',
                        style: titleTextStyle1,
                      ),
                      Text(
                        viewModel.offerDetailByIdModel?.data?.description ?? '',
                        // style: titleTextStyle1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),

                      // const CustomTextWidget(
                      //     sideLogo: true,
                      //     content: "Offer Details",
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w700,
                      //     textColor: textColor),
                      // const SizedBox(height: 10),
                      // offerTile(
                      //     lable: 'Offer Name',
                      //     value:
                      //         viewModel.offerDetailByIdModel?.data?.offerName ??
                      //             ''),
                      // const SizedBox(height: 5),
                      // offerTile(
                      //     lable: 'Offer Code',
                      //     value:
                      //         viewModel.offerDetailByIdModel?.data?.offerCode ??
                      //             ''),
                      // offerTile(
                      //     lable: 'Minimum Booking Amount',
                      //     value:
                      //         'AED ${viewModel.offerDetailByIdModel?.data?.minimumBookingAmount}'),
                      // const SizedBox(height: 5),
                      // offerTile(
                      //     lable: 'Discount Percentage',
                      //     value:
                      //         '${viewModel.offerDetailByIdModel?.data?.discountPercentage} %'),
                      // const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(
                          //   child: offerTile(
                          //       lable: 'Start Date',
                          //       value:
                          //           '${viewModel.offerDetailByIdModel?.data?.startDate}'),
                          // ),
                          Expanded(
                            child: offerTile(
                                lable: 'End Date',
                                value:
                                    '${viewModel.offerDetailByIdModel?.data?.endDate}'),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              viewModel.offerDetailByIdModel?.data?.offerCode ??
                                  '',
                              style: titleTextStyle,
                            ),
                            GestureDetector(
                              onTap: () {
                                copyToClipboard(viewModel.offerDetailByIdModel
                                        ?.data?.offerCode ??
                                    '');
                              },
                              child: Row(
                                children: [
                                  isCopied
                                      ? const Text(
                                          'Copied',
                                          style: TextStyle(color: Colors.green),
                                        )
                                      : Text('CopyCodes'),
                                  const SizedBox(width: 5),
                                  isCopied
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Icon(Icons.copy)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Terms & Conditions :-',
                        style: titleTextStyle,
                      ),
                      Column(
                        children: termsList.map((e) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  e,
                                  style: titleTextStyle1,
                                ),
                              ))
                            ],
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  offerTile({required String lable, required String value}) {
    return Row(
      children: [
        Text(
          lable,
          style: titleTextStyle,
        ),
        Text(
          ':',
          style: titleTextStyle,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: titleTextStyle1,
        )
      ],
    );
  }
}
