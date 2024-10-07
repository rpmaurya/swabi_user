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

  // void _scrollListener() {
  //   double offset = _scrollController.offset;
  //   int newIndex = (offset / 310)
  //       .round(); // Adjust this divisor based on card width and padding
  //   if (newIndex != initialIndex) {
  //     setState(() {
  //       initialIndex = newIndex;
  //       print('indexvalue $initialIndex');
  //     });
  //   }
  // }

  // bool isCopied = false; // To manage the "Copied" text visibility

  // // Function to copy the text to the clipboard
  // void copyToClipboard(String text) {
  //   Clipboard.setData(ClipboardData(text: text)).then((_) {
  //     setState(() {
  //       isCopied = true;
  //     });
  //     // Optionally reset "Copied" text after a few seconds
  //     Future.delayed(Duration(seconds: 2), () {
  //       setState(() {
  //         isCopied = false;
  //       });
  //     });
  //   });
  // }

  bool loading = false;
  List<String> images = [
    packageImg,
    tour,
    tour2,
    viewImg,
    packageImg,
    tour,
    tour2,
    viewImg
  ];
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
                      context.go('/');
                      print("Custom Appbar");
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
                  SizedBox(height: 10),
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
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
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
            )
            // appBar: CustomAppBar(
            //   leadingIcon: true,
            //   trailingIcon: true,
            //   rightIconImage: appLogo1,
            //   appLeadingImage: menu,
            //   onTap: () => context.push("/menuPage", extra: {'id': uId}),
            // ),
            // body: Container(
            //   color: bgGreyColor,
            //   child: Stack(
            //     children: [
            //       ListView(
            //         children: [
            //           const Padding(
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //             child: CustomText(
            //               content: "Discover more then travel",
            //               align: TextAlign.start,
            //               fontSize: 20,
            //               fontWeight: FontWeight.w700,
            //             ),
            //           ),
            //           Container(
            //             // padding: const EdgeInsets.all(15),
            //             margin: const EdgeInsets.symmetric(horizontal: 10),
            //             decoration: BoxDecoration(
            //                 color: background,
            //                 borderRadius: BorderRadius.circular(20),
            //                 border: Border.all(
            //                     color: naturalGreyColor.withOpacity(0.3))),
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: InkWell(
            //                     onTap: () {
            //                       context.push("/rentalForm",
            //                           extra: {'userId': uId});
            //                     },
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(10.0),
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           Image.asset(
            //                             carRental,
            //                             height: 40,
            //                             color: btnColor,
            //                           ),
            //                           const SizedBox(height: 5),
            //                           Text(
            //                             "Rental Vehicle",
            //                             style: titleTextStyle,
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 90,
            //                   child: VerticalDivider(
            //                     indent: 0,
            //                     endIndent: 0,
            //                     thickness: 2,
            //                     color: naturalGreyColor.withOpacity(0.3),
            //                   ),
            //                 ),
            //                 Expanded(
            //                   child: InkWell(
            //                     onTap: () {
            //                       context.push("/package", extra: {"user": uId});
            //                     },
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(10.0),
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           Center(
            //                               child: Image.asset(
            //                             holidays,
            //                             height: 40,
            //                             color: btnColor,
            //                           )),
            //                           const SizedBox(height: 5),
            //                           Center(
            //                             child: Text(
            //                               "Holiday Packages",
            //                               style: titleTextStyle,
            //                             ),
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),

            //           ///Top Offer Container
            //           (offerListData?.data ?? []).isNotEmpty
            //               ? CommonContainer(
            //                   height: 50,
            //                   elevation: 0,
            //                   padding: const EdgeInsets.symmetric(horizontal: 10),
            //                   color: bgGreyColor,
            //                   borderRadius: BorderRadius.circular(0),
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       const CustomText(
            //                         content: "Offers",
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                       CommonContainer(
            //                         color: bgGreyColor,
            //                         onTap: () {
            //                           context.push('/allOffer');
            //                         },
            //                         elevation: 0,
            //                         borderRadius: BorderRadius.circular(0),
            //                         child: Row(
            //                           children: [
            //                             const CustomText(
            //                                 content: "View All",
            //                                 textColor: blueTextColor,
            //                                 fontSize: 20),
            //                             Padding(
            //                               padding: const EdgeInsets.symmetric(
            //                                   horizontal: 5),
            //                               child: Container(
            //                                 height: 15,
            //                                 width: 15,
            //                                 decoration: const BoxDecoration(
            //                                     color: blueTextColor,
            //                                     shape: BoxShape.circle),
            //                                 child: const Icon(
            //                                   Icons.arrow_forward_ios,
            //                                   color: background,
            //                                   size: 10,
            //                                 ),
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 )
            //               : Container(),
            //           (offerListData?.data ?? []).isNotEmpty
            //               ? SizedBox(
            //                   height: 160,
            //                   child: ListView.separated(
            //                     controller: _scrollController,
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 10),
            //                     scrollDirection: Axis.horizontal,
            //                     itemCount: offerListData?.data?.length ?? 0,
            //                     itemBuilder: (context, index) {
            //                       var data = offerListData?.data?[index];
            //                       return GestureDetector(
            //                         onTap: () {
            //                           Provider.of<OfferViewModel>(context,
            //                                   listen: false)
            //                               .getOfferDetails(
            //                                   context: context,
            //                                   offerId: data?.offerId ?? 0);
            //                         },
            //                         child: Container(
            //                           padding: const EdgeInsets.all(10),
            //                           width: 300,
            //                           decoration: BoxDecoration(
            //                             gradient: const LinearGradient(colors: [
            //                               Colors.pinkAccent,
            //                               Colors.purpleAccent
            //                             ]),
            //                             borderRadius: BorderRadius.circular(10),
            //                           ),
            //                           child: Stack(
            //                             children: [
            //                               Positioned(
            //                                   bottom: 0,
            //                                   right: 0,
            //                                   child: Container(
            //                                     height: 100,
            //                                     width: 120,
            //                                     decoration: BoxDecoration(
            //                                         borderRadius:
            //                                             BorderRadius.circular(10),
            //                                         border: Border.all(
            //                                             color: background,
            //                                             width: 2)),
            //                                     child: ClipRRect(
            //                                       borderRadius:
            //                                           BorderRadius.circular(10),
            //                                       child: Image.network(
            //                                         data?.imageUrl ??
            //                                             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTePpXbUcvlhV4a1px1UFFfXeZWZANowRWZXw&s',
            //                                         fit: BoxFit.fill,
            //                                       ),
            //                                     ),
            //                                   )),
            //                               Column(
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     '${data?.offerName}',
            //                                     style: const TextStyle(
            //                                         color: background,
            //                                         fontSize: 18,
            //                                         fontWeight: FontWeight.w600),
            //                                   ),
            //                                   const SizedBox(height: 5),
            //                                   Container(
            //                                     padding:
            //                                         const EdgeInsets.symmetric(
            //                                             horizontal: 8),
            //                                     decoration: BoxDecoration(
            //                                       borderRadius:
            //                                           BorderRadius.circular(20),
            //                                       color: Colors.white
            //                                           .withOpacity(0.5),
            //                                     ),
            //                                     child: Text(
            //                                       data?.bookingType ==
            //                                               'RENTAL_BOOKING'
            //                                           ? 'Rental Booking'
            //                                           : 'Package Booking',
            //                                       style: const TextStyle(
            //                                           color: background,
            //                                           fontSize: 16,
            //                                           fontWeight:
            //                                               FontWeight.w600),
            //                                     ),
            //                                   ),
            //                                   const SizedBox(height: 5),
            //                                   Text(
            //                                       'Valid till : ${data?.endDate}',
            //                                       style: const TextStyle(
            //                                           color: Colors.white,
            //                                           fontSize: 14,
            //                                           fontWeight:
            //                                               FontWeight.w600)),
            //                                   const Spacer(),
            //                                   Container(
            //                                     width: 150,
            //                                     padding:
            //                                         const EdgeInsets.symmetric(
            //                                             horizontal: 8,
            //                                             vertical: 4),
            //                                     decoration: BoxDecoration(
            //                                         color: background,
            //                                         borderRadius:
            //                                             BorderRadius.circular(8)),
            //                                     child: Row(
            //                                       mainAxisAlignment:
            //                                           MainAxisAlignment
            //                                               .spaceBetween,
            //                                       children: [
            //                                         Text(
            //                                           data?.offerCode ?? '',
            //                                           style: titleTextStyle,
            //                                         ),
            //                                         GestureDetector(
            //                                           onTap: () {
            //                                             setState(() {
            //                                               selectIndex = index;
            //                                             });
            //                                             copyToClipboard(
            //                                                 data?.offerCode ??
            //                                                     '');
            //                                           },
            //                                           child: isCopied &&
            //                                                   selectIndex == index
            //                                               ? const Icon(
            //                                                   Icons.check,
            //                                                   color: Colors.green,
            //                                                 )
            //                                               : const Icon(
            //                                                   Icons.copy),
            //                                         )
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       );
            //                     },
            //                     separatorBuilder: (context, index) =>
            //                         const SizedBox(width: 10),
            //                   ),
            //                 )
            //               : Container(),
            //           (offerListData?.data ?? []).isNotEmpty
            //               ? const SizedBox(height: 10)
            //               : const SizedBox(),
            //           (offerListData?.data ?? []).isNotEmpty
            //               ? Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: List.generate(
            //                       (offerListData?.data ?? []).length, (index) {
            //                     return AnimatedContainer(
            //                       height: initialIndex == index ? 12 : 10,
            //                       width: initialIndex == index ? 20 : 10,
            //                       duration: const Duration(milliseconds: 200),
            //                       margin:
            //                           const EdgeInsets.symmetric(horizontal: 4),
            //                       decoration: BoxDecoration(
            //                           border: Border.all(
            //                               color: Colors.black12,
            //                               strokeAlign:
            //                                   BorderSide.strokeAlignOutside),
            //                           borderRadius: BorderRadius.circular(5),
            //                           // shape: initialIndex == index
            //                           //     ? BoxShape.rectangle
            //                           //     : BoxShape.circle,
            //                           color: initialIndex == index
            //                               ? redColor
            //                               : Colors.white),
            //                     );
            //                   }),
            //                 )
            //               : const SizedBox(),
            //           const Padding(
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //             child: CustomText(
            //               content: "Exclusive Partner",
            //               align: TextAlign.start,
            //               fontSize: 20,
            //               fontWeight: FontWeight.w700,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 140,
            //             child: ListView.separated(
            //               padding: const EdgeInsets.symmetric(horizontal: 10),
            //               scrollDirection: Axis.horizontal,
            //               itemCount: images.length,
            //               itemBuilder: (context, index) => ListContainerDesign(
            //                 imageList: images[index],
            //               ),
            //               //     CommonContainer(
            //               //   elevation: 0,
            //               //   height: 140,
            //               //   width: AppDimension.getWidth(context) * .7,
            //               //   color: background,
            //               //   child: Image.asset(
            //               //     images[index],
            //               //     fit: BoxFit.fill,
            //               //   ),
            //               // ),
            //               separatorBuilder: (context, index) =>
            //                   const SizedBox(width: 10),
            //             ),
            //           ),
            //           CommonContainer(
            //             height: 70,
            //             elevation: 0,
            //             padding: const EdgeInsets.symmetric(horizontal: 10),
            //             color: bgGreyColor,
            //             borderRadius: BorderRadius.circular(0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 const CustomText(
            //                   content: "Stories By Travellers",
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w700,
            //                 ),
            //                 CommonContainer(
            //                   color: bgGreyColor,
            //                   onTap: () {
            //                     context.push("/package", extra: {"user": uId});
            //                   },
            //                   elevation: 0,
            //                   borderRadius: BorderRadius.circular(0),
            //                   child: Row(
            //                     children: [
            //                       const CustomText(
            //                           content: "View All",
            //                           textColor: blueTextColor,
            //                           fontSize: 20),
            //                       Padding(
            //                         padding:
            //                             const EdgeInsets.symmetric(horizontal: 5),
            //                         child: Container(
            //                           height: 15,
            //                           width: 15,
            //                           decoration: const BoxDecoration(
            //                               color: blueTextColor,
            //                               shape: BoxShape.circle),
            //                           child: const Icon(
            //                             Icons.arrow_forward_ios,
            //                             color: background,
            //                             size: 10,
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           Container(
            //             // height: AppDimension.getHeight(context) * .75,
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 0, horizontal: 10),
            //             child: CustomGridView(
            //               onTap: () {
            //                 print('Grid View Print');
            //               },
            //               gridImages: List.generate(
            //                   images.length, (index) => images[index]),
            //             ),
            //           )
            //         ],
            //       ),
            //       isLoadingData
            //           ? const SpinKitFoldingCube(
            //               size: 80,
            //               duration: Duration(milliseconds: 1200),
            //               color: Colors.red,
            //             )
            //           : Container()
            //     ],
            //   ),
            // ),
            ));
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

class Dashboard_Container extends StatelessWidget {
  final String img;
  final String title;
  final String bgImage;
  final bool loading;
  final VoidCallback? onTap;

  const Dashboard_Container(
      {this.bgImage = '',
      required this.img,
      required this.onTap,
      this.loading = false,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 6,
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: onTap,
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    height: AppDimension.getHeight(context) / 4,
                    width: AppDimension.getWidth(context) * .9,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(bgImage), fit: BoxFit.fill),
                        border: Border.all(color: btnColor),
                        borderRadius: BorderRadius.circular(15)),
                    // child: loading ? const SizedBox(
                    //     height: 30,
                    //     width: 30,
                    //     child: CircularProgressIndicator(color: btnColor,)) : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      title,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black),
                      // color: const Color.fromRGBO(123, 30, 52, 1)),
                    ),
                  )
                ],
              )
              //
              ),
        ),
      ],
    );
  }
}

class ListContainerDesign extends StatelessWidget {
  final String imageList;
  const ListContainerDesign({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 140,
          width: AppDimension.getWidth(context) * .7,
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: AssetImage(imageList),fit: BoxFit.fill)
          // ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                  imageList != '' && imageList.isNotEmpty ? imageList : img1,
                  fit: BoxFit.fill)),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: background),
            child: const CustomText(
              content: "HOTELS",
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: const BoxDecoration(color: background),
                child: const CustomText(
                  content: "PRICE DROP ALERT",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const CustomText(
                content: "Grab Up to 25% OFF* on Internation Hotels",
                textColor: background,
                fontWeight: FontWeight.w600,
              ),
              const CustomText(
                  content: "& plan your 15-19 Aug LOOONG weekend trip",
                  textColor: background,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ],
          ),
        )
      ],
    );
  }
}
