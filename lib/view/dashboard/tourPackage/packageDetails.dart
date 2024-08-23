import 'package:flutter/material.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/multi_imageSlider_ContainerWidget.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/view_model/package_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class PackageDetails extends StatefulWidget {
  final String packageId;
  final String userId;
  final String bookDate;

  const PackageDetails(
      {super.key,
      required this.packageId,
      required this.userId,
      required this.bookDate});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  var packageActivity;

  List<String> imageList = [];
  List<PackageActivity> packageActivityList = [];

  @override
  Widget build(BuildContext context) {
    packageActivity = context
            .watch<GetPackageActivityByIdViewModel>()
            .getPackageActivityById
            .data
            ?.data ??
        "";
    packageActivityList = context
            .watch<GetPackageActivityByIdViewModel>()
            .getPackageActivityById
            .data
            ?.data
            .packageActivities ??
        [];
    imageList = context
            .watch<GetPackageActivityByIdViewModel>()
            .getPackageActivityById
            .data
            ?.data
            .packageImageUrl ??
        [];
    // ///Driver Details Sub Data
    // String packageActivityString = packageActivity.replaceAll('{', '').replaceAll('}', '');
    // List<String> packageActivityAttributes = packageActivityString.split(", ");
    // Map<String, dynamic> packageActivityMap = {};
    // for (String attribute in packageActivityAttributes) {
    //   List<String> keyValue = attribute.split(":");
    //   if (keyValue.length == 2) {
    //     String key = keyValue[0].trim();
    //     String value = keyValue[1].trim();
    //     if (key.isNotEmpty && value.isNotEmpty) {
    //       packageActivityMap[key] = value;
    //     }
    //   }
    // }
    // debugPrint(widget.packageId);
    // debugPrint(widget.userId);
    // debugPrint(packageActivityList.length.toString());
    // debugPrint(packageActivityList[0].packageActivityId.toString());
    // debugPrint("${widget.bookDate}Detail Page Booking");
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Page View",
      ),
      body: PageLayout_Page(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  children: [
                    const SizedBox(height: 10),
                    const CustomTextWidget(
                        sideLogo: true,
                        content: "Package Images",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textColor: textColor),
                    const SizedBox(height: 10),
                    CommonContainer(
                      elevation: 0,
                      borderReq: true,
                      color: naturalGreyColor.withOpacity(.4),
                      borderRadius: BorderRadius.circular(10),
                      height: AppDimension.getHeight(context) / 4,
                      child: MultiImageSlider(
                        images: List.generate(
                            imageList.length, (index) => imageList[index]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CustomTextWidget(
                        sideLogo: true,
                        content: "Package Details",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textColor: textColor),
                    const SizedBox(height: 10),
                    CommonContainer(
                      borderReq: true,
                      // height: AppDimension.getHeight(context) / 7,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      borderColor: naturalGreyColor.withOpacity(0.3),
                      elevation: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                const CustomText(
                                    content: "Name : ",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    textColor: textColor),
                                SizedBox(
                                  width: AppDimension.getWidth(context) * .7,
                                  child: CustomText(
                                      content: packageActivity.packageName,
                                      align: TextAlign.start,
                                      fontSize: 15,
                                      maxline: 3,
                                      fontWeight: FontWeight.w400,
                                      textColor: textColor),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                    content: "Location : ",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    textColor: textColor),
                                SizedBox(
                                  width: AppDimension.getWidth(context) * .7,
                                  child: CustomText(
                                      content:
                                          "${packageActivity.location} ${packageActivity.country} ${packageActivity.state}",
                                      align: TextAlign.start,
                                      fontSize: 15,
                                      maxline: 3,
                                      fontWeight: FontWeight.w400,
                                      textColor: textColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CustomText(
                                    content: "Activities : ",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    textColor: textColor),
                                SizedBox(
                                  width: AppDimension.getWidth(context) * .7,
                                  child: CustomText(
                                      content: "${packageActivityList.length}",
                                      align: TextAlign.start,
                                      fontSize: 15,
                                      maxline: 3,
                                      fontWeight: FontWeight.w400,
                                      textColor: textColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CustomText(
                                    content: "Days : ",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    textColor: textColor),
                                SizedBox(
                                  width: AppDimension.getWidth(context) * .7,
                                  child: CustomText(
                                      content:
                                          "${packageActivity.noOfDays} Day",
                                      align: TextAlign.start,
                                      fontSize: 15,
                                      maxline: 3,
                                      fontWeight: FontWeight.w400,
                                      textColor: textColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CustomText(
                                    content: "Nights : ",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    textColor: textColor),
                                SizedBox(
                                  width: AppDimension.getWidth(context) * .7,
                                  child: CustomText(
                                      content:
                                          "${int.parse(packageActivity.noOfDays) - 1} Night",
                                      align: TextAlign.start,
                                      fontSize: 15,
                                      maxline: 3,
                                      fontWeight: FontWeight.w400,
                                      textColor: textColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CommonContainer(
                      borderReq: false,
                      borderRadius: BorderRadius.circular(0),
                      color: bgGreyColor,
                      borderColor: btnColor,
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextWidget(
                              sideLogo: true,
                              content: "Activity Details",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              textColor: textColor),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: packageActivityList.length,
                            itemBuilder: (context, index) {
                              final acticityImage = packageActivityList[index]
                                  .activity
                                  .activityImageUrl;
                              return ActivityContainer(
                                days: packageActivityList[index].day == "null"
                                    ? "Activity ${index + 1}"
                                    : "Activity ${packageActivityList[index].day}",
                                actyImage: List.generate(acticityImage.length,
                                    (index) => acticityImage[index]),
                                activityName: packageActivityList[index]
                                    .activity
                                    .activityName,
                                description: packageActivityList[index]
                                    .activity
                                    .description,
                                activityHour: packageActivityList[index]
                                    .activity
                                    .activityHours
                                    .toString(),
                                activityVisit: packageActivityList[index]
                                    .activity
                                    .bestTimeToVisit,
                                openTime: packageActivityList[index]
                                    .activity
                                    .startTime,
                                closeTime:
                                    packageActivityList[index].activity.endTime,
                                address:
                                    packageActivityList[index].activity.address,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///Package Total Booking Container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "AED ",
                          style: GoogleFonts.lato(
                            color: background,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      //Total Amt
                      TextSpan(
                        text: "${packageActivity.totalPrice}\n",
                        style: GoogleFonts.lato(
                          color: background,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: "Per person",
                        style: GoogleFonts.lato(
                          color: background,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ])),
                    CustomButtonSmall(
                      width: 155,
                      height: 40,
                      borderRadius: BorderRadius.circular(5),
                      btnHeading: "BOOK PACKAGE",
                      onTap: () =>
                          // context.push('/package/packageMember')
                          context.push("/package/packageBookingMember", extra: {
                        "pkgID": widget.packageId,
                        "usrID": widget.userId,
                        "amt": packageActivity.totalPrice,
                        "bookDate": widget.bookDate
                      }),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ActivityContainer extends StatefulWidget {
  final List<String> actyImage;
  final String days;
  final String activityName;
  final String description;
  final String activityHour;
  final String activityVisit;
  final String openTime;
  final String closeTime;
  final String address;

  const ActivityContainer(
      {required this.actyImage,
      required this.days,
      required this.activityName,
      required this.description,
      required this.activityHour,
      required this.activityVisit,
      required this.openTime,
      required this.closeTime,
      required this.address,
      super.key});

  @override
  State<ActivityContainer> createState() => _ActivityContainerState();
}

class _ActivityContainerState extends State<ActivityContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CommonContainer(
        borderReq: true,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        borderColor: naturalGreyColor.withOpacity(.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CustomTextWidget(
              sideLogo: true,
              align: TextAlign.start,
              content: widget.days == "null" ? "" : widget.days,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textColor: blackColor,
            ),
            const SizedBox(height: 10),
            CommonContainer(
              elevation: 0,
              height: 150,
              borderRadius: BorderRadius.circular(10),
              child: MultiImageSlider(
                images: widget.actyImage,
              ),
            ),
            const SizedBox(height: 5),
            CustomText(
              align: TextAlign.start,
              content: widget.activityName,
              maxline: 3,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textColor: blackColor,
            ),
            const SizedBox(height: 5),
            // CustomTextWidget(
            //   align: TextAlign.start,
            //   content: words.take(isExpanded ? totalWords : 30).join(' '),
            //   fontSize: 12,
            //   maxline: 100,
            //   // textEllipsis: true,
            //   textColor: textColor,
            //   fontWeight: FontWeight.w200,
            // ),
            ReadMoreText(
              widget.description,
              style: GoogleFonts.lato(
                fontSize: 14,
                // textEllipsis: true,
                color: blackColor,
                fontWeight: FontWeight.w400,
              ),
              moreStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: redColor, fontSize: 15),
              lessStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: redColor, fontSize: 15),
            ),
            const SizedBox(height: 5),
            // words.length >= 30 ? Padding(
            //   padding: const EdgeInsets.only(bottom: 10),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child:InkWell(
            //       onTap: () {
            //         setState(() {
            //           isExpanded = !isExpanded;
            //         });
            //       },
            //       child: Text(isExpanded ? 'View Less' : 'View More',style: GoogleFonts.lato(
            //           fontSize: 14,
            //           color: redColor,
            //         fontWeight: FontWeight.w500
            //       ),),
            //     ),
            //   ),
            // ) : const SizedBox(),
            ///1st Row of Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Activity Hours : ",
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                  TextSpan(
                      text: widget.activityHour,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor))
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Time To Visit : ",
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                  TextSpan(
                      text: widget.activityVisit,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor))
                ]))
              ],
            ),
            const SizedBox(height: 10),

            ///2nd Row of Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Opening Time : ",
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                  TextSpan(
                      text: widget.openTime,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor))
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Closing Time : ",
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                  TextSpan(
                      text: widget.closeTime,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor))
                ]))
              ],
            ),
            const SizedBox(height: 10),
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Location : ",
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                  TextSpan(
                      text: widget.address,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor))
                ])),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
