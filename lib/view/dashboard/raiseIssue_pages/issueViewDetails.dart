import 'package:flutter/material.dart';
import 'package:flutter_cab/model/IssueDetailModel.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/raiseIssue_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Issueviewdetails extends StatefulWidget {
  const Issueviewdetails({super.key});

  @override
  State<Issueviewdetails> createState() => _IssueviewdetailsState();
}

class _IssueviewdetailsState extends State<Issueviewdetails> {
  Data? issueData;
  @override
  Widget build(BuildContext context) {
    issueData = context.watch<RaiseissueViewModel>().issueDetail.data?.data;
    return Scaffold(
      appBar: const CustomAppBar(
        heading: 'Issue Details',
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        itemtile(
                            lable: 'Issue Id',
                            vale: issueData?.issueId.toString() ?? ''),
                        itemtile(
                            lable: 'Booking Id',
                            vale: issueData?.bookingId.toString() ?? '')
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Status',
                              style: titleTextStyle,
                            ),
                            const SizedBox(width: 5),
                            Text(':'),
                            const SizedBox(width: 5),
                            Container(
                              height: 30,
                              // width: 120,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: issueData?.issueStatus.toString() ==
                                          'OPEN'
                                      ? redColor
                                      : issueData?.issueStatus.toString() ==
                                              'IN_PROGRESS'
                                          ? Colors.yellow[300]
                                          : Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                issueData?.issueStatus.toString() ==
                                        'IN_PROGRESS'
                                    ? 'INPROGRESS'
                                    : issueData?.issueStatus.toString() ?? '',
                                style: TextStyle(color: background),
                              )),
                            )
                          ],
                        ),
                        itemtile(
                            lable: 'Customer Id',
                            vale: issueData?.user?.userId.toString() ?? '')
                      ],
                    ),
                  ],
                ),
                itemText(
                    lable: 'Created Date',
                    value: DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            issueData?.createdDate ?? 0))),
                itemText(
                    lable: 'Booking Type',
                    value: issueData?.bookingType.toString() ?? ''),
                itemText(
                    lable: 'Issue Description',
                    value: issueData?.issueDescription.toString() ?? ''),
                issueData?.resolutionDescription == null
                    ? const SizedBox()
                    : Text(
                        'Resolution Description :-',
                        style: titleTextStyle,
                      ),
                Text(
                  issueData?.resolutionDescription ?? '',
                  style: titleTextStyle1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  itemText({required String lable, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            lable,
            style: titleTextStyle,
          ),
        ),
        const SizedBox(width: 5),
        Text(':'),
        const SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: titleTextStyle1,
          ),
        )
      ],
    );
  }

  itemtile({required String lable, required String vale}) {
    return Row(children: [
      Text(
        lable,
        style: titleTextStyle,
      ),
      const SizedBox(width: 5),
      Text(':'),
      const SizedBox(width: 5),
      Text(
        vale,
        style: titleTextStyle1,
      )
    ]);
  }
}
