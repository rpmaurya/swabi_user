import 'package:flutter/material.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customTabBar.dart';
import 'package:flutter_cab/res/Custom%20Widgets/multi_imageSlider_ContainerWidget.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
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

class _PackageHistoryManagementState extends State<PackageHistoryManagement>
    with SingleTickerProviderStateMixin {
  int pageLength = 40;
  ScrollController bookedPkgController = ScrollController();
  List<String> tabList = ['ALL', 'BOOKED', 'COMPLETED', 'CANCELLED'];
  TabController? _tabController;
  int initialIndex = 0;
  int currentPage = 0;
  bool isLoadingMore = false;
  bool isVisibleIcon = false;
  bool lastPage = false; // Assuming true at the start
  final int pageSize = 10; // Set your page size
  final ScrollController _scrollController = ScrollController();
  List<PackageHistoryContent> bookedHistory = [];

  Future<void> getPackageHistoryList() async {
    // Avoid fetching data if already loading or reached the last page
    if (isLoadingMore || lastPage) return;

    setState(() {
      isLoadingMore = true;
    });

    String status = tabList[initialIndex]; // Get current tab status

    try {
      // Fetch data using Provider
      final response =
          await Provider.of<GetPackageHistoryViewModel>(context, listen: false)
              .fetchGetPackageHistoryBookedViewModelApi(context, {
        "userId": widget.userID,
        "bookingStatus": status,
        "pageNumber": currentPage,
        "pageSize": pageSize,
        "search": '',
        "sortBy": 'packageBookingId',
        "sortDirection": isVisibleIcon ? 'asc' : 'desc'
      });

      // Update history with new data
      final data = response?.data.content ?? [];

      print('Fetched data: $data');

      if (data.isNotEmpty) {
        setState(() {
          bookedHistory.addAll(data); // Append new data to the existing list
          currentPage++; // Increment page number
          lastPage = data.length < pageSize; // Check if this is the last page
        });
      } else {
        setState(() {
          lastPage = true; // No more data available
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error, e.g., show a toast or error message
    }

    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabList.length, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPackageHistoryList();
    });

    _tabController?.addListener(() {
      initialIndex = _tabController?.index ?? 0;
      setState(() {
        currentPage = 0; // Reset pagination when tab changes
        bookedHistory.clear(); // Clear the history
        lastPage = false;
      });
      getPackageHistoryList();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list
        if (!isLoadingMore && !lastPage) {
          print('testing......');
          getPackageHistoryList();
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    var status = context
        .watch<GetPackageHistoryDetailByIdViewModel>()
        .getPackageHistoryDetailById
        .status
        .toString();
    debugPrint('status $status');
    return Scaffold(
      appBar: const CustomAppBar(
        heading: 'My Package History',
      ),
      body: Customtabbar(
          controller: _tabController,
          tabs: tabList,
          sortVisiblty: true,
          isVisible: isVisibleIcon,
          onTap: (p0) {
            setState(() {
              currentPage = 0; // Reset pagination when tab changes
              bookedHistory.clear(); // Clear the history
              lastPage = false;
            });
            getPackageHistoryList();
          },
          onTapSort: () {
            setState(() {
              isVisibleIcon = !isVisibleIcon;
              currentPage = 0; // Reset pagination when tab changes
              bookedHistory.clear(); // Clear the history
              lastPage = false;
            });

            getPackageHistoryList();
            print('njnkjnjknnm,');
          },
          viewchildren: List.generate(tabList.length, (index) {
            return Consumer<GetPackageHistoryViewModel>(
              builder: (context, viewModel, child) {
                final response = viewModel.getBookedHistory;

                if (response.status.toString() == "Status.loading") {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: greenColor,
                  ));
                } else if (response.status.toString() == "Status.error") {
                  return const Center(
                      child: Text(
                    'No Data',
                    style: TextStyle(color: redColor),
                  ));
                } else if (response.status.toString() == "Status.completed") {
                  final data = response.data?.data.content ?? [];

                  if (data.isEmpty && currentPage == 0) {
                    // return const Center(child: Text('No Data Available'));
                    return Center(
                        child: Container(
                            decoration: const BoxDecoration(),
                            child: const Text(
                              'No Data Found',
                              style: TextStyle(
                                  color: redColor, fontWeight: FontWeight.w600),
                            )));
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: bookedHistory.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == bookedHistory.length) {
                        return isLoadingMore
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: greenColor,
                              ))
                            : const SizedBox.shrink(); // Hide if not loading
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: PackageHistoryContainer(
                          status: bookedHistory[index].bookingStatus,
                          pkgID: bookedHistory[index].packageBookingId,
                          bookingDate: bookedHistory[index].bookingDate,
                          members:
                              bookedHistory[index].memberList.length.toString(),
                          price: bookedHistory[index].totalPayableAmount,
                          // price: bookedHistory[index]
                          //             .discountAmount
                          //             .toString()
                          //             .isEmpty ||
                          //         bookedHistory[index]
                          //                 .discountAmount
                          //                 .toString() ==
                          //             '0'
                          //     ? bookedHistory[index].totalAmount
                          //     : bookedHistory[index].discountAmount,
                          pkgName: bookedHistory[index].pkg.packageName,
                          location: bookedHistory[index].pkg.country,
                          imageList: bookedHistory[index]
                              .pkg
                              .packageActivities
                              .expand((e) => e.activity.activityImageUrl)
                              .toList(),
                          loader: status == 'Status.loading' &&
                              selectIndex == index,
                          onTap: () {
                            setState(() {
                              selectIndex = index;
                            });
                            Provider.of<GetPackageHistoryDetailByIdViewModel>(
                                    context,
                                    listen: false)
                                .fetchGetPackageHistoryDetailByIdViewModelApi(
                                    context,
                                    {
                                      "packageBookingId":
                                          bookedHistory[index].packageBookingId
                                    },
                                    widget.userID,
                                    bookedHistory[index].packageBookingId);
                          },
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text('No data found'));
              },
            );
          })),
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
  final bool loader;
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
      required this.loader,
      required this.price});

  @override
  Widget build(BuildContext context) {
    print('images  list................$loader');
    return CommonContainer(
      borderRadius: BorderRadius.circular(5),
      elevation: 0,
      borderColor: naturalGreyColor.withOpacity(0.3),
      borderReq: true,
      child: Material(
        color: background,
        child: InkWell(
          // onTap: onTap,
          child: Column(
            children: [
              SizedBox(
                height: 180,
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
                child: textTile(
                    lable1: 'Booking Id',
                    value1: pkgID,
                    lable2: 'Status',
                    value2: status),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: naturalGreyColor))),
                  child: textTile(
                      lable1: 'Date',
                      value1: bookingDate,
                      lable2: "Member's",
                      value2: members)),
              Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: naturalGreyColor))),
                  child: textTile(
                      lable1: 'Price',
                      value1: 'AED $price',
                      lable2: 'Location',
                      value2: location)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButtonSmall(
                      loading: loader,
                      height: 40,
                      width: 120,
                      btnHeading: 'View Details',
                      onTap: onTap),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  textTile({
    required String lable1,
    required String value1,
    required String lable2,
    required String value2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _builtText(lable: lable1, value: value1)),
        Expanded(flex: 2, child: _builtText(lable: lable2, value: value2))
      ],
    );
  }

  _builtText({required String lable, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: titleTextStyle,
        ),
        const SizedBox(width: 5),
        Text(
          ':',
          style: titleTextStyle,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: titleTextStyle1,
          ),
        )
      ],
    );
  }
}
