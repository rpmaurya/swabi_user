import 'package:flutter/material.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/multi_imageSlider_ContainerWidget.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/view_model/package_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PackageHistoryManagement extends StatefulWidget {
  final String userID;

  const PackageHistoryManagement({super.key, required this.userID});

  @override
  State<PackageHistoryManagement> createState() =>
      _PackageHistoryManagementState();
}

class _PackageHistoryManagementState extends State<PackageHistoryManagement> {
  int pageLength = 40;
  ScrollController bookedPkgController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // bookedPkgController.addListener(() {
    //   if(bookedPkgController.position.pixels == bookedPkgController.position.maxScrollExtent){
    //     fetchPackageHistoryBookedList();
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryBookedViewModelApi(context, {
        "userId": widget.userID,
        "bookingStatus": "ALL",
        "pageNumber": "0",
        "pageSize": "100",
      });
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryUpCommingViewModelApi(context, {
        "userId": widget.userID,
        "bookingStatus": "BOOKED",
        "pageNumber": "0",
        "pageSize": "100",
      });
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryCompletedViewModelApi(context, {
        "userId": widget.userID,
        "bookingStatus": "COMPLETED",
        "pageNumber": "0",
        "pageSize": "100",
      });
      Provider.of<GetPackageHistoryViewModel>(context, listen: false)
          .fetchGetPackageHistoryCancelledViewModelApi(context, {
        "userId": widget.userID,
        "bookingStatus": "CANCELLED",
        "pageNumber": "0",
        "pageSize": "100",
      });
    });
    pageLength += 5;
  }

  // void fetchPackageHistoryBookedList(){
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //
  //   });
  //   pageLength +=20;
  // }

  List<PackageHistoryContent> bookedHistory = [];
  List<PackageHistoryContent> upcommingHistory = [];
  List<PackageHistoryContent> completedHistory = [];
  List<PackageHistoryContent> cancelledHistory = [];

  @override
  Widget build(BuildContext context) {
    String bookedStatus = context
        .watch<GetPackageHistoryViewModel>()
        .getBookedHistory
        .status
        .toString();
    String upcommingStatus = context
        .watch<GetPackageHistoryViewModel>()
        .getBookedHistory
        .status
        .toString();
    String completedStatus = context
        .watch<GetPackageHistoryViewModel>()
        .getCompletedHistory
        .status
        .toString();
    String cancelledStatus = context
        .watch<GetPackageHistoryViewModel>()
        .getCancelledHistory
        .status
        .toString();
    if (bookedStatus == "Status.completed") {
      bookedHistory = context
              .watch<GetPackageHistoryViewModel>()
              .getBookedHistory
              .data
              ?.data
              .content ??
          [];
    }
    if (upcommingStatus == "Status.completed") {
      upcommingHistory = context
              .watch<GetPackageHistoryViewModel>()
              .getUpcommingHistory
              .data
              ?.data
              .content ??
          [];
    }
    if (completedStatus == "Status.completed") {
      completedHistory = context
              .watch<GetPackageHistoryViewModel>()
              .getCompletedHistory
              .data
              ?.data
              .content ??
          [];
    }

    if (cancelledStatus == "Status.completed") {
      cancelledHistory = context
              .watch<GetPackageHistoryViewModel>()
              .getCancelledHistory
              .data
              ?.data
              .content ??
          [];
    }
    if (bookedPkgController.hasClients) {
      if (bookedStatus == "Status.loading" &&
          bookedPkgController.position.pixels ==
              bookedPkgController.position.maxScrollExtent) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          bookedPkgController.animateTo(
              bookedPkgController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceIn);
        });
      }
    }
    // debugPrint("${widget.userID}History Package UrID");
    // debugPrint("${bookedHistory.length} Booked History Package");
    // debugPrint("${completedHistory.length} Completed History Package");
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: bgGreyColor,
        appBar: const CustomAppBar(
          heading: "My Package History",
        ),
        body: PageLayout_Page(
            child: Column(
          children: [
            Container(
              // width: AppDimension.getWidth(context) * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: background,
                  border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  // indicatorPadding: EdgeInsets.symmetric(horizontal: -5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: btnColor),
                      color: btnColor),
                  tabAlignment: TabAlignment.fill,
                  labelPadding: const EdgeInsets.symmetric(vertical: 5),
                  labelColor: background,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: blackColor,
                  tabs: [
                    Tab(
                        child: Text("BOOKED",
                            style: GoogleFonts.lato(
                                fontSize: 13, fontWeight: FontWeight.w700))),
                    Tab(
                        child: Text("UPCOMMING",
                            style: GoogleFonts.lato(
                                fontSize: 13, fontWeight: FontWeight.w700))),
                    Tab(
                        child: Text("COMPLETED",
                            style: GoogleFonts.lato(
                                fontSize: 13, fontWeight: FontWeight.w700))),
                    Tab(
                        child: Text("CANCELLED",
                            style: GoogleFonts.lato(
                                fontSize: 13, fontWeight: FontWeight.w700))),
                  ]),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(children: [
                ///Booked List
                bookedStatus == "Status.completed"
                    ? bookedHistory.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            itemCount: bookedStatus == "Status.loading"
                                ? bookedHistory.length + 1
                                : bookedHistory.length,
                            // physics: const BouncingScrollPhysics(),
                            controller: bookedPkgController,
                            itemBuilder: (context, index) {
                              if (bookedHistory.length == index) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: btnColor,
                                        )),
                                  ),
                                );
                              } else {
                                return PackageHistoryContainer(
                                  status: bookedHistory[index].bookingStatus,
                                  pkgID: bookedHistory[index].packageBookingId,
                                  bookingDate: bookedHistory[index].bookingDate,
                                  members: bookedHistory[index]
                                      .memberList
                                      .length
                                      .toString(),
                                  price: bookedHistory[index].totalAmount,
                                  pkgName: bookedHistory[index].pkg.packageName,
                                  // pkgName: pkgMap['packageName'],
                                  location: bookedHistory[index].pkg.location,
                                  imageList:
                                      bookedHistory[index].pkg.packageImageUrl,
                                  onTap: () {
                                    Provider.of<GetPackageHistoryDetailByIdViewModel>(
                                            context,
                                            listen: false)
                                        .fetchGetPackageHistoryDetailByIdViewModelApi(
                                            context,
                                            {
                                              "packageBookingId":
                                                  bookedHistory[index]
                                                      .packageBookingId
                                            },
                                            widget.userID,
                                            bookedHistory[index]
                                                .packageBookingId);
                                  },
                                );
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ))
                        : Center(
                            child: Container(
                                decoration: const BoxDecoration(),
                                child: Image.asset(
                                  folder,
                                  height: 150,
                                )))
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                upcommingStatus == "Status.completed"
                    ? upcommingHistory.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            itemCount: upcommingStatus == "Status.loading"
                                ? upcommingHistory.length + 1
                                : upcommingHistory.length,
                            // physics: const BouncingScrollPhysics(),
                            controller: bookedPkgController,
                            itemBuilder: (context, index) {
                              if (upcommingHistory.length == index) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: btnColor,
                                        )),
                                  ),
                                );
                              } else {
                                return PackageHistoryContainer(
                                  status: upcommingHistory[index].bookingStatus,
                                  pkgID:
                                      upcommingHistory[index].packageBookingId,
                                  bookingDate:
                                      upcommingHistory[index].bookingDate,
                                  members: upcommingHistory[index]
                                      .memberList
                                      .length
                                      .toString(),
                                  price: upcommingHistory[index].totalAmount,
                                  pkgName:
                                      upcommingHistory[index].pkg.packageName,
                                  // pkgName: pkgMap['packageName'],
                                  location:
                                      upcommingHistory[index].pkg.location,
                                  imageList: upcommingHistory[index]
                                      .pkg
                                      .packageImageUrl,
                                  onTap: () {
                                    Provider.of<GetPackageHistoryDetailByIdViewModel>(
                                            context,
                                            listen: false)
                                        .fetchGetPackageHistoryDetailByIdViewModelApi(
                                            context,
                                            {
                                              "packageBookingId":
                                                  upcommingHistory[index]
                                                      .packageBookingId
                                            },
                                            widget.userID,
                                            upcommingHistory[index]
                                                .packageBookingId);
                                  },
                                );
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ))
                        : Center(
                            child: Container(
                                decoration: const BoxDecoration(),
                                child: Image.asset(
                                  folder,
                                  height: 150,
                                )))
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),

                ///Completed List
                completedStatus == "Status.completed"
                    ? completedHistory.isNotEmpty
                        ? ListView.separated(
                            itemCount: completedHistory.length,
                            // physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            itemBuilder: (context, index) {
                              return PackageHistoryContainer(
                                status: completedHistory[index].bookingStatus,
                                pkgID: completedHistory[index].packageBookingId,
                                bookingDate:
                                    completedHistory[index].bookingDate,
                                members: completedHistory[index]
                                    .memberList
                                    .length
                                    .toString(),
                                price: completedHistory[index].totalAmount,
                                pkgName:
                                    completedHistory[index].pkg.packageName,
                                location: completedHistory[index].pkg.location,
                                imageList:
                                    completedHistory[index].pkg.packageImageUrl,
                                onTap: () {
                                  Provider.of<GetPackageHistoryDetailByIdViewModel>(
                                          context,
                                          listen: false)
                                      .fetchGetPackageHistoryDetailByIdViewModelApi(
                                          context,
                                          {
                                            "packageBookingId":
                                                completedHistory[index]
                                                    .packageBookingId
                                          },
                                          widget.userID,
                                          completedHistory[index]
                                              .packageBookingId);
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ))
                        : Center(
                            child: Container(
                                decoration: const BoxDecoration(),
                                child: Image.asset(
                                  folder,
                                  height: 150,
                                )))
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),

                ///Cancelled List
                cancelledStatus == "Status.completed"
                    ? cancelledHistory.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            itemCount: cancelledHistory.length,
                            // physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PackageHistoryContainer(
                                status: cancelledHistory[index].bookingStatus,
                                pkgID: cancelledHistory[index].packageBookingId,
                                bookingDate:
                                    cancelledHistory[index].bookingDate,
                                members: cancelledHistory[index]
                                    .memberList
                                    .length
                                    .toString(),
                                price: cancelledHistory[index].totalAmount,
                                pkgName:
                                    cancelledHistory[index].pkg.packageName,
                                location: cancelledHistory[index].pkg.location,
                                imageList:
                                    cancelledHistory[index].pkg.packageImageUrl,
                                onTap: () {
                                  Provider.of<GetPackageHistoryDetailByIdViewModel>(
                                          context,
                                          listen: false)
                                      .fetchGetPackageHistoryDetailByIdViewModelApi(
                                          context,
                                          {
                                            "packageBookingId":
                                                cancelledHistory[index]
                                                    .packageBookingId
                                          },
                                          widget.userID,
                                          cancelledHistory[index]
                                              .packageBookingId);
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ))
                        : Center(
                            child: Container(
                                decoration: const BoxDecoration(),
                                child: Image.asset(
                                  folder,
                                  height: 150,
                                )))
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
              ]),
            )
          ],
        )),
      ),
    );
  }
}

class PackageHistoryContainer extends StatelessWidget {
  final String status;
  final String pkgID;
  final String bookingDate;
  final String members;
  final String price;
  final String pkgName;
  final String location;
  final List<String> imageList;
  final VoidCallback onTap;

  const PackageHistoryContainer(
      {super.key,
      required this.status,
      required this.pkgID,
      required this.bookingDate,
      required this.members,
      required this.pkgName,
      required this.location,
      required this.imageList,
      required this.onTap,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      borderRadius: BorderRadius.circular(5),
      elevation: 0,
      borderColor: naturalGreyColor.withOpacity(0.3),
      borderReq: true,
      child: Material(
        color: background,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: MultiImageSlider(
                  images: List.generate(
                      imageList.length, (index) => imageList[index]),
                ),
                // child: Image.asset(tour,width: double.infinity,fit: BoxFit.fill,),
              ),
              Container(
                height: 50,
                // width: AppDimension.getWidth(context)* .5,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: naturalGreyColor))),
                child: Row(
                  children: [
                    const CustomTextWidget(
                      content: "Package Name : ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .55,
                      child: CustomText(
                        content: pkgName,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        align: TextAlign.start,
                        textEllipsis: true,
                        maxline: 1,
                        textColor: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: naturalGreyColor))),
                child: Row(
                  children: [
                    const CustomTextWidget(
                      content: "Package ID : ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    CustomTextWidget(
                      content: pkgID,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      textColor: textColor,
                    ),
                    const Spacer(),
                    const CustomText(
                      content: "Location : ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    SizedBox(
                      width: 130,
                      child: CustomText(
                        content: location,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        align: TextAlign.start,
                        textEllipsis: true,
                        textColor: textColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: naturalGreyColor))),
                child: Row(
                  children: [
                    const CustomTextWidget(
                      content: "Date : ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    CustomTextWidget(
                      content: bookingDate,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    const Spacer(),
                    const CustomTextWidget(
                      content: "Member's : ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    CustomTextWidget(
                      content: members,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      textColor: textColor,
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    // border: Border(bottom: BorderSide(color: naturalGreyColor))
                    ),
                child: Row(
                  children: [
                    const CustomTextWidget(
                      content: "Status : ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    CustomTextWidget(
                      content: status,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    const Spacer(),
                    const CustomTextWidget(
                      content: "Price : AED ",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: textColor,
                    ),
                    CustomTextWidget(
                      content: price,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      textColor: textColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
