import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyTransaction extends StatefulWidget {
  final String userId;
  const MyTransaction({super.key, required this.userId});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTrasaction();
    });
    super.initState();
  }

  void getTrasaction() async {
    Map<String, dynamic> query = {
      "userId": widget.userId,
      "pageNumber": '0',
      "pageSize": '20',
      "search": '',
      "bookingType": 'ALL',
      "transactionStatus": 'ALL'
    };
    try {
      Provider.of<GetTranactionViewModel>(context, listen: false)
          .getTranactionApi(context: context, query: query);
    } catch (e) {
      debugPrint('error$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('userId....${widget.userId}');
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(heading: "My Transaction"),
      body: PageLayout_Page(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       CustomTextFeild(
            //         headingReq: false,
            //         prefixIcon: true,
            //         img: search,
            //         controller: TextEditingController(),
            //       ),
            //       Material(
            //         elevation: 0,
            //         color: lightBrownColor,
            //         borderRadius: BorderRadius.circular(10),
            //         child: InkWell(
            //           borderRadius: BorderRadius.circular(10),
            //           child: SizedBox(
            //             height: 50,
            //             width: 50,
            //             child: Padding(
            //               padding: const EdgeInsets.all(10.0),
            //               child: Image.asset(filter),
            //             ),
            //           ),
            //           onTap: () {},
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            Consumer<GetTranactionViewModel>(
              builder: (context, value, child) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: background),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data =
                            value.getTrasaction.data?.data?.content?[index];
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                            data?.createdDate ?? 0);
                        String formateDate =
                            DateFormat('MMM d, yyyy h:mm a').format(date);
                        return Container(
                          decoration: const BoxDecoration(color: background),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formateDate,
                                    style: titleTextStyle,
                                  ),
                                  Text(
                                    'AED ${data?.amountPaid.toString()}',
                                    style: titleTextStyle,
                                  )
                                ],
                              ),
                              Text(
                                data?.bookingType == 'PACKAGE_BOOKING'
                                    ? 'Package booking'
                                    : 'Rental booking',
                                style: titleTextStyle1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Payment Id',
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        data?.paymentId ?? '',
                                        style: titleTextStyle1,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Status',
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        data?.transactionStatus == 'Captured'
                                            ? 'Success'
                                            : data?.transactionStatus ==
                                                    'Created'
                                                ? 'Pending'
                                                : data?.transactionStatus
                                                        .toString() ??
                                                    '',
                                        style: TextStyle(
                                            color: data?.transactionStatus ==
                                                    'Captured'
                                                ? greenColor
                                                : data?.transactionStatus ==
                                                        'Created'
                                                    ? Colors.yellow
                                                    : data?.transactionStatus ==
                                                            'Refunded'
                                                        ? greenColor
                                                        : redColor),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 0,
                        );
                      },
                      itemCount: (value.getTrasaction.data?.data?.content ?? [])
                          .length),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
