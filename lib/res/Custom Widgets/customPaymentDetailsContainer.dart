import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';

class Custompaymentdetailscontainer extends StatelessWidget {
  final String paymentId;
  final String paymentDate;
  final String amount;
  final String paymentTime;
  const Custompaymentdetailscontainer(
      {super.key,
      required this.paymentId,
      required this.paymentDate,
      required this.amount,
      required this.paymentTime});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: naturalGreyColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(10),
            color: background),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: const Center(
                  child: Text(
                'Payment Details',
                style: TextStyle(
                    color: background,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )),
            ),
            textItem(lable: 'Payment Id', value: paymentId),
            textItem(lable: 'Amount', value: 'AED ${amount}'),
            textItem(lable: 'PaymentDate', value: paymentDate),
            textItem(lable: 'PaymentTime', value: paymentTime),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  textItem({required String lable, required String value}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              lable,
              style: titleTextStyle,
            ),
          ),
          Text(
            ':',
            style: titleTextStyle,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: titleTextStyle1,
            ),
          )
        ],
      ),
    );
  }
}
