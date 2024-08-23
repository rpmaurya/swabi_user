import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';

import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout_Page(appHeading: "Notification",
        child: Column(
          children: [
            NotificationContainer(),
            NotificationContainer(),
            NotificationContainer(),
            NotificationContainer(),
          ],
        ));
  }
}

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {

          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            height: 70,
            width: AppDimension.getWidth(context)*.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              border: Border.all(color: curvePageColor,)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Stack(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(img1),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 10,
                        child:  SizedBox(
                          width: 15,
                          height:15,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 20,
                          width: 120,
                          child: Text("Good Burger",
                            style: GoogleFonts.lato(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,)),
                      const SizedBox(height: 5),
                      SizedBox(
                          height: 20,
                          width: 200,
                          child:  Text("Lorem Ipsum is simply dummy ",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                            ),
                          overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text("3.12 pm",style: GoogleFonts.lato(
                        color: greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600
                    ),)),
              ])
          ),
        ),
      ),
    );
  }
}
