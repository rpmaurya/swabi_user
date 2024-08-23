import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:go_router/go_router.dart';

class HappyBookingScreen extends StatefulWidget {
  final String userId;
  const HappyBookingScreen({super.key,
    required this.userId
  });

  @override
  State<HappyBookingScreen> createState() => _HappyBookingScreenState();
}

class _HappyBookingScreenState extends State<HappyBookingScreen> {

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              height: AppDimension.getHeight(context) * .25,
              width: AppDimension.getWidth(context) * .4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: greenColor.withOpacity(.15)),
              child:const Icon(
                Icons.check,
                color: greenColor,
                size: 70,
              ),
            ),
            const CustomText(
                content: "Booking Success",
                fontSize: 30,
                fontWeight: FontWeight.w700,
                textColor: textColor),
            const SizedBox(height: 10),
            const CustomText(
                content: "Your Booking has been successfully\nBooked!",
                fontSize: 18,
                maxline: 2,
                fontWeight: FontWeight.w500,
                textColor: textColor),
            const SizedBox(height: 10),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonBig(btnHeading: "Go To History Page",
                  loading: loader,
                  onTap: (){
                  loader = true;
                  // Future.delayed(const Duration(seconds: 2));
                  // context.go("/");
                    context.replace("/rentalForm/rentalHistory",extra: {"myIdNo": widget.userId});
                  }),
                      // context.go("/"),),
              ],
            ),
            const SizedBox(height: 20),
          ],
        )
      ),
    );
  }
}
