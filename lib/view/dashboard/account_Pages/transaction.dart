import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTransaction extends StatefulWidget {
  final String userId;
  const MyTransaction({super.key, required this.userId});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  @override
  Widget build(BuildContext context) {
    debugPrint('userId....${widget.userId}');
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(heading: "My Transaction"),
      body: PageLayout_Page(
          child: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFeild(
                  headingReq: false,
                  prefixIcon: true,
                  img: search,
                  controller: TextEditingController(),
                ),
                Material(
                  elevation: 0,
                  color: lightBrownColor,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(filter),
                      ),
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: const [
                TransContainer(),
                TransContainer(),
                TransContainer(),
                TransContainer(),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class TransContainer extends StatelessWidget {
  const TransContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: background,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            // height: AppDimension.getHeight(context)*.23,
            width: AppDimension.getWidth(context) * .9,
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: curvePageColor)),
            child: Column(
              children: [
                ///First Line of Design
                Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: curvePageColor))),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              car,
                              fit: BoxFit.cover,
                            )),
                      ),
                      title: Text(
                        "Mini Cooper SE",
                        style: GoogleFonts.lato(
                            color: greyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "5 Seats",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "03-18-2022",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),

                ///Second Line Design
                Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: curvePageColor))),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          )),
                    ),
                    title: Text(
                      "Floyd Miles",
                      style: GoogleFonts.lato(
                          color: greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "⭐ 4.8",
                          style: GoogleFonts.lato(
                              color: greyColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 5.0,right: 5),
                        //   child: InkWell(
                        //       borderRadius: BorderRadius.circular(50),
                        //       onTap: () {}, child: Image.asset(chat,height: 25,) ),
                        // ),
                        // Padding(
                        //   padding:const EdgeInsets.only(bottom: 5.0),
                        //   child: InkWell(onTap: () {}, child: const Icon(Icons.call) ),
                        // ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {},
                              child: Image.asset(
                                chat,
                                height: 25,
                              )),
                          InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {},
                              child: const Icon(Icons.call)),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Second Line Design
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: greenColor.withOpacity(.1),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Paid - ",
                          style: GoogleFonts.lato(
                              color: greenColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$1122',
                          style: GoogleFonts.lato(
                              color: greenColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
