import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/model/offerListModel.dart';

import 'package:flutter_cab/model/user_profile_model.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';

import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_gridViewBuilder.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/string_extenstion.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view/dashboard/rental/rentalForm.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/package.dart';
import 'package:flutter_cab/view_model/offer_view_model.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:flutter_cab/view_model/user_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

///Home Screen Old
class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen>
    with TickerProviderStateMixin {
  UserViewModel userViewModel = UserViewModel();
  final ScrollController _scrollController = ScrollController();
  DateTime dateTime = DateTime.now();
  String uId = '';
  int selectIndex = -1;
  int initialIndex = 0;
  int _initialIndex = 0;

  TabController? _tabcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userViewModel.getUserId().then((value) {
        setState(() {
          if (value.userId != null && value.userId != '') {
            uId = value.userId.toString();
          }
        });
        Provider.of<UserProfileViewModel>(context, listen: false)
            .fetchUserProfileViewModelApi(context, {"userId": uId});
      });
      _tabcontroller?.addListener(() {
        setState(() {
          _initialIndex = _tabcontroller?.index ?? 0;
        });
        print({'gfgfgfgh': _initialIndex});
      });
      // Provider.of<OfferViewModel>(context, listen: false).getOfferList(
      //     context: context, date: DateFormat('dd-MM-yyyy').format(dateTime));
    });
    // _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabcontroller!.dispose();
  }

  bool loading = false;
  // List<String> images = [
  //   packageImg,
  //   tour,
  //   tour2,
  //   viewImg,
  //   packageImg,
  //   tour,
  //   tour2,
  //   viewImg
  // ];
  ProfileData? userdata;
  OfferListModel? offerListData;
  bool isLoadingData = false;
  @override
  Widget build(BuildContext context) {
    // print("UserId here at homeScreen $uId");
    userdata = context.watch<UserProfileViewModel>().DataList.data?.data;

    // offerListData = context.watch<OfferViewModel>().offerListModel;
    // isLoadingData = context.watch<OfferViewModel>().isLoading1;
    return PopScope(
        canPop: false,
        onPopInvoked: (val) async {
          if (GoRouterState.of(context).uri.toString() != '/') {
            context.go('/');
            // return;
          } else if (GoRouterState.of(context).uri.toString() == '/') {
            await showDialog(
                context: context, builder: (context) => exitContainer());
          }
        },
        child: Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              titleSpacing: 0,
              leading: IconButton(
                  onPressed: () => context
                          .push("/menuPage", extra: {'id': uId}).then((value) {
                        Provider.of<UserProfileViewModel>(context,
                                listen: false)
                            .fetchUserProfileViewModelApi(
                                context, {"userId": uId});
                      }),
                  icon: const Icon(
                    Icons.notes_rounded,
                    size: 34,
                  )),
              title: Row(
                children: [
                  Container(
                    width: 40, // Adjust to match the radius
                    height: 40, // Adjust to match the radius
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          (userdata?.profileImageUrl ?? '').isNotEmpty
                              ? userdata?.profileImageUrl ?? ''
                              : 'https://up.yimg.com/ib/th?id=OIP.eCrcK2BiqwBGE1naWwK3UwHaHa&pid=Api&rs=1&c=1&qlt=95&w=115&h=115',
                        ),
                        fit:
                            BoxFit.cover, // Ensures the image covers the circle
                      ),
                    ),
                    // Fallback color when the image is loading or fails
                    child: userdata?.profileImageUrl == null
                        ? Icon(Icons.person, size: 20, color: Colors.grey[700])
                        : null,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'Hi,',
                    style: TextStyle(color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      userdata?.firstName.capitalizeFirstOfEach ?? '',
                      style: titleTextStyle,
                    ),
                  )
                ],
              ),
              actions: [
                InkWell(
                    onTap: () {
                      setState(() {
                        _tabcontroller?.index = 0;
                      });

                      context.go('/');
                      debugPrint("Custom Appbar");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Image.asset(
                        appLogo1,
                        height: 25,
                      ),
                    )
                    // child: Image.asset(appLogo1)
                    )
              ],
            ),
            body: Container(
              color: bgGreyColor,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: naturalGreyColor.withOpacity(0.3))),
                    child: TabBar(
                        onTap: (value) {},
                        controller: _tabcontroller,
                        splashBorderRadius: BorderRadius.circular(20),
                        // indicator: BoxDecoration(
                        //     border: _initialIndex == 0
                        //         ? Border(right: BorderSide())
                        //         : Border(left: BorderSide())),
                        unselectedLabelColor: Colors.black87,
                        labelColor: btnColor,
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Center(
                                    child: Image.asset(
                                  holidays,
                                  height: 35,
                                  color: _initialIndex == 0
                                      ? btnColor
                                      : blackColor,
                                )),
                                const SizedBox(height: 5),
                                Text(
                                  "Holiday Packages",
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                  // style: titleTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Image.asset(
                                  carRental,
                                  height: 35,
                                  color: _initialIndex == 1
                                      ? btnColor
                                      : blackColor,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Rental Vehicle',
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: _tabcontroller, children: [
                      Packages(ursID: uId),
                      RentalForm(userId: uId)
                    ]),
                  )
                ],
              ),
            )));
  }

  ///Exit Container Dialog Box
  Widget exitContainer() {
    return SizedBox(
      width: AppDimension.getWidth(context) * .7,
      height: AppDimension.getHeight(context) * .5,
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Stack(clipBehavior: Clip.none, children: [
          SizedBox(
            width: AppDimension.getWidth(context) * .7,
            height: AppDimension.getHeight(context) * .2,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 20, left: 20),
                  child: CustomTextWidget(
                      content: "Are you sure want to exit ?",
                      fontSize: 18,
                      align: TextAlign.center,
                      fontWeight: FontWeight.w600,
                      textColor: textColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonSmall(
                      width: 70,
                      btnHeading: "NO",
                      onTap: () {
                        context.pop();
                      },
                    ),
                    CustomButtonSmall(
                      width: 70,
                      btnHeading: "YES",
                      onTap: () {
                        exit(0);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: SizedBox(
                // decoration: BoxDecoration(
                //   border: Border.all(color: btnColor),
                //   borderRadius: BorderRadius.circular(10)
                // ),
                height: 100,
                width: 100,
                child: Card(
                  surfaceTintColor: background,
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(question),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
