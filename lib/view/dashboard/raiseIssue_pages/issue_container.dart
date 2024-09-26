import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';

class IssueContainer extends StatelessWidget {
  final String issueId;
  final String bookingId;
  final String userId;
  final String status;
  final String issueDate;
  final String bookingType;
  final VoidCallback onTap;
  final bool loader;
  const IssueContainer(
      {super.key,
      required this.issueId,
      required this.bookingId,
      required this.userId,
      required this.status,
      required this.issueDate,
      required this.bookingType,
      required this.loader,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    print('loader..$loader');
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemtile(lable: 'Issue Id', vale: issueId),
                  itemtile(lable: 'Booking Id', vale: bookingId)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemtile(lable: 'User Id', vale: userId),
                  itemText(lable: 'Issue Date', value: issueDate),
                ],
              ),
            ],
          ),
          // itemText(lable: 'Issue Date', value: issueDate),
          itemText(lable: 'Booking Type', value: bookingType),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: status == 'OPEN'
                            ? redColor
                            : status == 'IN_PROGRESS'
                                ? Colors.yellow[400]
                                : Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      status == 'IN_PROGRESS' ? 'INPROGRESS' : status,
                      style: const TextStyle(
                          color: background, fontWeight: FontWeight.w500),
                    )),
                  )
                ],
              ),
              CustomButtonSmall(
                  loading: loader,
                  height: 40,
                  width: 80,
                  btnHeading: 'View',
                  onTap: onTap),
            ],
          )
        ],
      ),
    );
  }

  itemText({required String lable, required String value}) {
    return Row(
      children: [
        Text(
          lable,
          style: titleTextStyle,
        ),
        const SizedBox(width: 5),
        Text(':'),
        const SizedBox(width: 5),
        Text(
          value,
          style: titleTextStyle1,
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
