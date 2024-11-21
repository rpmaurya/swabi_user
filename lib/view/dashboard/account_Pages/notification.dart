import 'package:flutter/material.dart';
import 'package:flutter_cab/model/getall_notification_model.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';

import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/notification_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  final String userId;
  const NotificationPage({super.key, required this.userId});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  GetAllNotificationModel? getAllNotificationList;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  int pageSize = 10;
  bool isLastPage = false;
  bool isLoadingMore = false;
  List<Content> todayNotification = [];
  List<Content> earlierNotification = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotification();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list
        if (!isLoadingMore && !isLastPage) {
          print('testing......');
          getNotification();
        }
      }
    });
  }

  void getNotification() async {
    DateTime dateTime = DateTime.now();
    try {
      var resp =
          await Provider.of<NotificationViewModel>(context, listen: false)
              .getAllNotificationList(
                  context: context,
                  userId: widget.userId,
                  pageNumber: currentPage,
                  pageSize: pageSize,
                  readStatus: 'all');
      todayNotification = resp?.data?.content?.where((notification) {
            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                notification.createdDate ?? 0 * 1000,
                isUtc: false);
            return date.day == dateTime.day &&
                date.month == dateTime.month &&
                date.year == dateTime.year;
          }).toList() ??
          [];
      var data = resp?.data?.content?.where((notification) {
            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                notification.createdDate ?? 0 * 1000,
                isUtc: false);
            return !(date.day == dateTime.day &&
                date.month == dateTime.month &&
                date.year == dateTime.year);
          }).toList() ??
          [];
      if (data.isNotEmpty) {
        setState(() {
          earlierNotification.addAll(data);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        heading: "Notification",
      ),
      body: PageLayout_Page(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          todayNotification.isNotEmpty
              ? Text(
                  'Taday',
                  style: titleTextStyle,
                )
              : const SizedBox.shrink(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: todayNotification.length,
            itemBuilder: (context, index) {
              return NotificationContainer(
                title: todayNotification[index].title ?? '',
                subTitle: todayNotification[index].message ?? '',
                time: todayNotification[index].createdDate ?? 0,
              );
            },
          ),
          Text(
            'Earlier',
            style: titleTextStyle,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: earlierNotification.length,
            itemBuilder: (context, index) {
              return NotificationContainer(
                title: earlierNotification[index].title ?? '',
                subTitle: earlierNotification[index].message ?? '',
                time: earlierNotification[index].createdDate ?? 0,
              );
            },
          ),
        ],
      )),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final int time;
  const NotificationContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.time});

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: false);
    String formateDate = timeago.format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 70,
              width: AppDimension.getWidth(context) * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: curvePageColor,
                  )),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Stack(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.notifications_none_outlined,
                          color: btnColor,
                          size: 30,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 10,
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                        ))
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
                          width: 150,
                          child: Text(
                            title,
                            style: GoogleFonts.lato(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          )),
                      const SizedBox(height: 5),
                      SizedBox(
                          height: 20,
                          width: 200,
                          child: Text(
                            subTitle,
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formateDate,
                      style: GoogleFonts.lato(
                          color: greyColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )),
              ])),
        ),
      ),
    );
  }
}
