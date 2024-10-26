import 'package:flutter/material.dart';
import 'package:flutter_cab/model/getTrasactionByIdModel.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customTabBar.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyTransaction extends StatefulWidget {
  final String userId;
  const MyTransaction({super.key, required this.userId});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction>
    with SingleTickerProviderStateMixin {
  List<String> tabList = ['SUCCESS', 'PENDING', 'REFUNDED', 'FAILED'];
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  int pageSize = 10;
  bool isLastPage = false;
  bool isLoadingMore = false;
  List<Content> allTranaction = [];
  int intialIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabList.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTrasaction();
    });
    _tabController?.addListener(() {
      intialIndex = _tabController?.index ?? 0;
      setState(() {
        currentPage = 0;
        allTranaction.clear();
        isLastPage = false;
      });
      getTrasaction();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list
        if (!isLoadingMore && !isLastPage) {
          print('testing......');
          getTrasaction();
        }
      }
    });
  }

  Future<void> getTrasaction() async {
    if (isLoadingMore || isLastPage) return;
    setState(() {
      isLoadingMore = true;
    });
    String status = tabList[intialIndex] == 'SUCCESS'
        ? 'Captured'
        : tabList[intialIndex] == 'PENDING'
            ? "Created"
            : tabList[intialIndex] == 'REFUNDED'
                ? "Refunded"
                : tabList[intialIndex] == 'FAILED'
                    ? "Failed"
                    : "ALL";
    Map<String, dynamic> query = {
      "userId": widget.userId,
      "pageNumber": currentPage,
      "pageSize": pageSize,
      "search": '',
      "bookingType": 'ALL',
      "transactionStatus": status
    };
    try {
      var resp =
          await Provider.of<GetTranactionViewModel>(context, listen: false)
              .getTranactionApi(context: context, query: query);
      var data = resp?.data?.content ?? [];
      if (data.isNotEmpty) {
        setState(() {
          allTranaction.addAll(data);
          currentPage++;
          isLastPage = data.length < pageSize;
          debugPrint('currentpage$currentPage');
        });
      } else {
        setState(() {
          isLastPage = true;
        });
      }
    } catch (e) {
      debugPrint('error$e');
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController?.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('userId....${widget.userId}');
    // return Scaffold(
    //   backgroundColor: bgGreyColor,
    //   appBar: const CustomAppBar(heading: "My Transaction"),
    //   body: PageLayout_Page(
    //       child: Column(
    //     children: [
    return Customtabbar(
        titleHeading: 'My Transaction',
        controller: _tabController,
        onTap: (index) {
          setState(() {
            currentPage = 0;
            allTranaction.clear();
            isLastPage = false;
          });
          getTrasaction();
        },
        tabs: tabList,
        viewchildren: List.generate(tabList.length, (index) {
          // const SizedBox(height: 10),
          return Consumer<GetTranactionViewModel>(
            builder: (context, value, child) {
              return value.getTrasaction.status.toString() == 'Status.loading'
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: greenColor,
                    ))
                  : allTranaction.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            var data = allTranaction[index];
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                                data.createdDate ?? 0 * 1000,
                                isUtc: false);
                            String formateDate =
                                DateFormat('MMM d, yyyy h:mm a').format(date);
                            if (index == allTranaction.length) {
                              return isLoadingMore
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: greenColor,
                                    ))
                                  : const SizedBox
                                      .shrink(); // Hide if not loading
                            }
                            return Container(
                              decoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formateDate,
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        'AED ${data.amountPaid.toString()}',
                                        style: titleTextStyle,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Booking Id',
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        data.bookingId == null
                                            ? 'N/A'
                                            : data.bookingId.toString() ?? '',
                                        style: titleTextStyle1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Payment Id',
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        data.paymentId ?? '',
                                        style: titleTextStyle1,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Status',
                                        style: titleTextStyle,
                                      ),
                                      Text(
                                        data.transactionStatus == 'Captured'
                                            ? 'Success'
                                            : data.transactionStatus ==
                                                    'Created'
                                                ? 'Pending'
                                                : data.transactionStatus ==
                                                        'failed'
                                                    ? 'Failed'
                                                    : data.transactionStatus
                                                            .toString() ??
                                                        '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: data.transactionStatus ==
                                                    'Captured'
                                                ? greenColor
                                                : data.transactionStatus ==
                                                        'Created'
                                                    ? Colors.yellow
                                                    : data.transactionStatus ==
                                                            'Refunded'
                                                        ? greenColor
                                                        : redColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              allTranaction.length + (isLoadingMore ? 1 : 0))
                      : const Center(
                          child: Text(
                            'No Transaction Available',
                            style: TextStyle(
                                color: redColor, fontWeight: FontWeight.bold),
                          ),
                        );
            },
          );
        }));
    //     ],
    //   )),
    // );
  }
}
