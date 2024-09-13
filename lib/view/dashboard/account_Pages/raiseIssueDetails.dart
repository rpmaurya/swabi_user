import 'package:flutter/material.dart';
import 'package:flutter_cab/model/GetIssueModel.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customTabBar.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view/dashboard/raiseIssue_pages/issue_container.dart';
import 'package:flutter_cab/view_model/raiseIssue_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Raiseissuedetails extends StatefulWidget {
  const Raiseissuedetails({super.key});

  @override
  State<Raiseissuedetails> createState() => _RaiseissuedetailsState();
}

class _RaiseissuedetailsState extends State<Raiseissuedetails>
    with SingleTickerProviderStateMixin {
  List<String> tabList = ['ALL', 'OPEN', 'IN_PROGRESS', 'RESOLVED'];
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();

  List<Content> allRaiseList = [];
  // List<Data> openRaiseList = [];
  // List<Data> inProgressRaiseList = [];
  // List<Data> resolveRaiseList = [];
  bool isLastPage = false;
  bool isLoadingMore = false;
  int currentPage = 0;
  int pageSize = 10;
  int intialIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabList.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRaiseIssue();
    });
    _tabController?.addListener(() {
      intialIndex = _tabController?.index ?? 0;
      setState(() {
        currentPage = 0;
        allRaiseList.clear();
        isLastPage = false;
      });
      getRaiseIssue();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list
        if (!isLoadingMore && !isLastPage) {
          print('testing......');
          getRaiseIssue();
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

  Future<void> getRaiseIssue() async {
    if (isLoadingMore || isLastPage) return;
    setState(() {
      isLoadingMore = true;
    });
    String status = tabList[intialIndex];
    try {
      var resp = await Provider.of<RaiseissueViewModel>(context, listen: false)
          .getRaiseIssue(
              context: context,
              issueStatus: status,
              pageNumber: currentPage,
              pageSize: pageSize);
      // Update history with new data
      final data = resp?.data?.content ?? [];

      print('Fetched data: $data');
      if (data.isNotEmpty) {
        setState(() {
          allRaiseList.addAll(data);
          currentPage++;
          isLastPage = data.length < pageSize;
        });
      } else {
        setState(() {
          isLastPage = true;
        });
      }
    } catch (e) {
      debugPrint('error $e');
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  bool isLoading = false;
  bool isLoading1 = false;
  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    // final vieProvider = Provider.of<RaiseissueViewModel>(context);
    // isLoading1 = vieProvider.isloading1;
    // // print('loding.......$isLoading1');
    // isLoading = context.watch<RaiseissueViewModel>().isloading;
    // // allRaiseList =
    // //     context.watch<RaiseissueViewModel>().getIssue?.data?.content ?? [];
    // // print('daaa${allRaiseList?.first.bookingId}');

    return Scaffold(
      appBar: const CustomAppBar(
        heading: 'Raised Issue',
      ),
      body: Customtabbar(
          controller: _tabController,
          onTap: (index) {
            setState(() {
              currentPage = 0;
              allRaiseList.clear();
              isLastPage = false;
            });
            getRaiseIssue();
          },
          tabs: tabList,
          viewchildren: List.generate(tabList.length, (index) {
            return Consumer<RaiseissueViewModel>(
              builder: (context, value, child) {
                return value.isloading
                    ? const Center(child: CircularProgressIndicator())
                    : allRaiseList.isNotEmpty
                        ? ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                allRaiseList.length + (isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              var data = allRaiseList[index];
                              if (index == allRaiseList.length) {
                                return isLoadingMore
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : const SizedBox
                                        .shrink(); // Hide if not loading
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: IssueContainer(
                                    issueId: data.issueId.toString(),
                                    bookingId: data.bookingId.toString(),
                                    userId: data.raisedById.toString(),
                                    status: data.issueStatus.toString(),
                                    issueDate: DateFormat('dd-MM-yyyy').format(
                                        data.createdDate ?? DateTime.now()),
                                    bookingType: data.bookingType.toString(),
                                    loader: value.isloading1 &&
                                        selectIndex == index,
                                    onTap: () {
                                      setState(() {
                                        selectIndex = index;
                                      });

                                      value.getRaiseIssueDetails(
                                          context: context,
                                          issueId: data.issueId.toString());
                                    }),
                              );
                            })
                        : Center(
                            child: Container(
                              child: Text(
                                'No Raise Available',
                                style: titleTextStyle,
                              ),
                            ),
                          );
              },
            );
          })),
    );
  }
}
