import 'package:flutter/material.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rentalListingContainer.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RentalHistoryManagment extends StatefulWidget {
  final String myId;

  const RentalHistoryManagment({super.key, required this.myId});

  @override
  State<RentalHistoryManagment> createState() => _RentalHistoryManagmentState();
}

class _RentalHistoryManagmentState extends State<RentalHistoryManagment> {
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<RentalBookingListViewModel>(context, listen: false)
            .fetchRentalBookingListBookedViewModelApi(context, {
          'userId': widget.myId,
          'pageNumber': '0',
          'pageSize': '100',
          'bookingStatus': 'ALL',
        });
        Provider.of<RentalBookingListViewModel>(context, listen: false)
            .fetchRentalBookingListUpcommingViewModelApi(context, {
          'userId': widget.myId,
          'pageNumber': '0',
          'pageSize': '100',
          'bookingStatus': 'BOOKED',
        });
        Provider.of<RentalBookingListViewModel>(context, listen: false)
            .fetchRentalBookingListOnRunningViewModelApi(context, {
          'userId': widget.myId,
          'pageNumber': '0',
          'pageSize': '100',
          'bookingStatus': 'ON_RUNNING',
        });
        Provider.of<RentalBookingListViewModel>(context, listen: false)
            .fetchRentalBookingListCompletedViewModelApi(context, {
          'userId': widget.myId,
          'pageNumber': '0',
          'pageSize': '100',
          'bookingStatus': 'COMPLETED',
        });
        Provider.of<RentalBookingListViewModel>(context, listen: false)
            .fetchRentalBookingListCancelledViewModelApi(context, {
          'userId': widget.myId,
          'pageNumber': '0',
          'pageSize': '100',
          'bookingStatus': 'CANCELLED',
        });
      },
    );
  }

  List<Content> booked = [];
  List<Content> cancelled = [];
  List<Content> upcomming = [];
  List<Content> onrunning = [];
  List<Content> completedList = [];

  var vehicleDetails;

  // Map<String,String> vehicleData = [];

  @override
  Widget build(BuildContext context) {
    String rentalBookingStatus = context
        .watch<RentalBookingListViewModel>()
        .rentalBookingList
        .status
        .toString();
    var status4 = context
        .watch<RentalBookingListViewModel>()
        .rentalBookingList
        .data
        ?.status
        .success;
    String rentalCancelStatus = context
        .watch<RentalBookingListViewModel>()
        .rentalCancelList
        .status
        .toString();
    String rentalOnRunningStatus = context
        .watch<RentalBookingListViewModel>()
        .rentalOnRunningList
        .status
        .toString();
    String rentalUpcommingStatus = context
        .watch<RentalBookingListViewModel>()
        .rentalUpcommingList
        .status
        .toString();
    String rentalCompletedStatus = context
        .watch<RentalBookingListViewModel>()
        .rentalCompletedList
        .status
        .toString();
    // vehicleDetails = context.watch<RentalBookingListViewModel>().rentalBookingList.data?.data.content ?? '';
    // debugPrint("My ID ${widget.myId}");
    if (rentalBookingStatus == "Status.completed") {
      booked = context
              .watch<RentalBookingListViewModel>()
              .rentalBookingList
              .data
              ?.data
              .content ??
          [];
    }
    if (rentalCancelStatus == "Status.completed") {
      cancelled = context
              .watch<RentalBookingListViewModel>()
              .rentalCancelList
              .data
              ?.data
              .content ??
          [];
    }
    if (rentalCompletedStatus == "Status.completed") {
      completedList = context
              .watch<RentalBookingListViewModel>()
              .rentalCompletedList
              .data
              ?.data
              .content ??
          [];
    }
    if (rentalOnRunningStatus == "Status.completed") {
      onrunning = context
              .watch<RentalBookingListViewModel>()
              .rentalOnRunningList
              .data
              ?.data
              .content ??
          [];
    }
    if (rentalUpcommingStatus == "Status.completed") {
      upcomming = context
              .watch<RentalBookingListViewModel>()
              .rentalUpcommingList
              .data
              ?.data
              .content ??
          [];
    }
    // debugPrint("${booked.length} Booked ");
    // debugPrint("${onrunning.length} On Running");
    // debugPrint("${completedList.length} Completed");
    // debugPrint("${cancelled.length} Cancelled");
    // debugPrint("$status4 ssdssjdsh ");
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: bgGreyColor,
        appBar: const CustomAppBar(
          heading: "My Trip History",
        ),
        body: PageLayout_Page(
            child: SizedBox(
          child: Column(
            children: [
              Material(
                elevation: 0,
                color: background,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  // width: AppDimension.getWidth(context) * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: naturalGreyColor.withOpacity(0.3))),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      // indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: btnColor),
                          color: btnColor),
                      tabAlignment: TabAlignment.fill,
                      labelPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      labelColor: background,
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: blackColor,
                      tabs: [
                        Tab(
                            child: Text("BOOKED",
                                style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))),
                        Tab(
                            child: Text(
                          "UP\nCOMMING",
                          style: GoogleFonts.lato(
                              fontSize: 12, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                        Tab(
                            child: Text(
                          "ON\nGOING",
                          style: GoogleFonts.lato(
                              fontSize: 12, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                        Tab(
                            child: Text("COMPLETED",
                                style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))),
                        Tab(
                            child: Text("CANCELLED",
                                style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))),
                      ]),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(children: [
                  ///Booked List
                  rentalBookingStatus == "Status.completed"
                      ? booked.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: booked.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return RentalCarListingContainer(
                                  onTapContainer: () {
                                    if (booked[index].id != index) {
                                      Provider.of<RentalViewDetailViewModel>(
                                              context,
                                              listen: false)
                                          .fetchRentalBookedViewDetialViewModelApi(
                                              context,
                                              {
                                                "id": booked[index].id,
                                              },
                                              booked[index].id.toString(),
                                              widget.myId);
                                    } else {
                                      const CircularProgressIndicator(
                                          color: Colors.green);
                                    }
                                  },
                                  time: booked[index].pickupTime,
                                  bookingID: booked[index].id,
                                  pickUplocation: booked[index].pickupLocation,
                                  carName: booked[index].carType,
                                  status: booked[index].bookingStatus,
                                  date: booked[index].date,
                                  rentalCharge: booked[index].rentalCharge,
                                );
                              })
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
                  rentalUpcommingStatus == "Status.completed"
                      ? upcomming.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: upcomming.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return RentalCarListingContainer(
                                  onTapContainer: () {
                                    if (upcomming[index].id != index) {
                                      Provider.of<RentalViewDetailViewModel>(
                                              context,
                                              listen: false)
                                          .fetchRentalBookedViewDetialViewModelApi(
                                              context,
                                              {
                                                "id": upcomming[index].id,
                                              },
                                              upcomming[index].id.toString(),
                                              widget.myId);
                                    } else {
                                      const CircularProgressIndicator(
                                          color: Colors.green);
                                    }
                                  },
                                  time: upcomming[index].pickupTime,
                                  bookingID: upcomming[index].id,
                                  pickUplocation:
                                      upcomming[index].pickupLocation,
                                  carName: upcomming[index].carType,
                                  status: upcomming[index].bookingStatus,
                                  date: upcomming[index].date,
                                  rentalCharge: upcomming[index].rentalCharge,
                                );
                              })
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
                  rentalOnRunningStatus == "Status.completed"
                      ? onrunning.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: onrunning.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return RentalCarListingContainer(
                                  onTapContainer: () {
                                    if (onrunning[index].id != index) {
                                      Provider.of<RentalViewDetailViewModel>(
                                              context,
                                              listen: false)
                                          .fetchRentalBookedViewDetialViewModelApi(
                                              context,
                                              {
                                                "id": onrunning[index].id,
                                              },
                                              onrunning[index].id.toString(),
                                              widget.myId);
                                    } else {
                                      const CircularProgressIndicator(
                                          color: Colors.green);
                                    }
                                  },
                                  time: onrunning[index].pickupTime,
                                  bookingID: onrunning[index].id,
                                  pickUplocation:
                                      onrunning[index].pickupLocation,
                                  carName: onrunning[index].carType,
                                  status: onrunning[index].bookingStatus,
                                  date: onrunning[index].date,
                                  rentalCharge: onrunning[index].rentalCharge,
                                );
                              })
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
                  rentalCompletedStatus == "Status.completed"
                      ? completedList.isNotEmpty
                          ? ListView.builder(
                              controller: scrollController,
                              itemCount: completedList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return RentalCarListingContainer(
                                  onTapContainer: () {
                                    if (completedList[index].id != index) {
                                      Provider.of<RentalViewDetailViewModel>(
                                              context,
                                              listen: false)
                                          .fetchRentalBookedViewDetialViewModelApi(
                                              context,
                                              {
                                                "id": completedList[index].id,
                                              },
                                              completedList[index]
                                                  .id
                                                  .toString(),
                                              widget.myId);
                                    } else {
                                      const CircularProgressIndicator(
                                          color: Colors.green);
                                    }
                                  },
                                  time: completedList[index].pickupTime,
                                  bookingID: completedList[index].id,
                                  pickUplocation:
                                      completedList[index].pickupLocation,
                                  carName: completedList[index].carType,
                                  status: completedList[index].bookingStatus,
                                  date: completedList[index].date,
                                  rentalCharge:
                                      completedList[index].rentalCharge,
                                );
                              })
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
                  rentalCancelStatus == "Status.completed"
                      ? cancelled.isNotEmpty
                          ? ListView.builder(
                              itemCount: cancelled.length,
                              controller: scrollController1,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return RentalCarListingContainer(
                                  onTapContainer: () {
                                    Provider.of<RentalViewDetailViewModel>(
                                            context,
                                            listen: false)
                                        .fetchRentalCancelledViewDetialViewModelApi(
                                            context,
                                            {
                                              "id": cancelled[index].id,
                                            },
                                            cancelled[index].id.toString());
                                  },
                                  bookingID: cancelled[index].id,
                                  pickUplocation:
                                      cancelled[index].pickupLocation,
                                  time: cancelled[index].pickupTime,
                                  carName: cancelled[index].carType,
                                  status: cancelled[index].bookingStatus,
                                  date: cancelled[index].date,
                                  rentalCharge: cancelled[index].rentalCharge,
                                );
                              })
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
                  // const Column(
                  //   children: [Text("Schedule")],
                  // ),
                ]),
              )
            ],
          ),
        )),
      ),
    );
  }
}
