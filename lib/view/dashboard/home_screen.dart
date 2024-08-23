import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_gridViewBuilder.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// class home_screen extends StatefulWidget {
//   const home_screen({super.key});
//
//   @override
//   State<home_screen> createState() => _home_screenState();
// }
//
// class _home_screenState extends State<home_screen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: 500.0,
//             systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarBrightness: Brightness.dark
//             ),
//             pinned: true,
//             backgroundColor: background,
//             surfaceTintColor: background,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(''),
//               background: Image.asset(
//                 dubaiHome1,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             // bottom: PreferredSize(
//             //     preferredSize: Size.fromHeight(0.0),
//             //     child: Container(
//             //       height: 1,
//             //       color: background,
//             //     )),
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(0.0),
//               child: Container(
//                 child: Row(
//                   children: [
//                     Dashboard_Container(
//                       bgImage: rentalCar,
//                       // loading: rangeStatus == "Status.loading" && loading,
//                       // onTap: ()=> context.push("/rentalForm", extra: {'iD': uId})
//                       onTap: () {
//                         // context.push("/rentalForm/rentalHistory");
//                         // context.push("/rentalForm", extra: {'userId':uId});
//                       },
//                       img: rent,
//                       title: "Rental Vehicle",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//           ),
//           // SliverList(
//           //   delegate: SliverChildBuilderDelegate(
//           //         (BuildContext context, int index) {
//           //       return ClipRRect(
//           //         borderRadius: BorderRadius.only(
//           //             topLeft: Radius.circular(10),
//           //             topRight: Radius.circular(10)
//           //         ),
//           //         child: Container(
//           //           decoration: BoxDecoration(
//           //             borderRadius: BorderRadius.only(
//           //               topLeft: Radius.circular(10),
//           //               topRight: Radius.circular(10)
//           //             )
//           //           ),
//           //             child: Row(
//           //               children: [
//           //               ],
//           //             )),
//           //       );
//           //     },
//           //     childCount: 50, // Adjust the number of items as needed
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
///Home Screen Old
class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  UserViewModel userViewModel = UserViewModel();

  String uId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      userViewModel.getUserId().then((value) async {
        setState(() {
          if (value.userId != null && value.userId != '') {
            uId = value.userId.toString();
          }
        });
      });
    });
  }

  bool loading = false;
  List<String> images = [
    packageImg,
    tour1,
    tour2,
    viewImg,
    packageImg,
    tour1,
    tour2,
    viewImg
  ];

  @override
  Widget build(BuildContext context) {
    // print("UserId here at homeScreen $uId");
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
          appBar: CustomAppBar(
            leadingIcon: true,
            trailingIcon: true,
            rightIconImage: appLogo1,
            appLeadingImage: menu,
            onTap: () => context.push("/menuPage", extra: {'id': uId}),
          ),
          body: Container(
            color: bgGreyColor,
            child: ListView(
              children: [
                ///Top Offer Container
                CommonContainer(
                  height: 50,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: bgGreyColor,
                  borderRadius: BorderRadius.circular(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        content: "Offers",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      CommonContainer(
                        color: bgGreyColor,
                        onTap: () {
                          context.push("/package", extra: {"user": uId});
                        },
                        elevation: 0,
                        borderRadius: BorderRadius.circular(0),
                        child: Row(
                          children: [
                            const CustomText(
                                content: "View All",
                                textColor: blueTextColor,
                                fontSize: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                    color: blueTextColor,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: background,
                                  size: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ListContainerDesign(
                        imageList: images[index],
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: images.length),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CustomText(
                    content: "Discover more then travel",
                    align: TextAlign.start,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CommonContainer(
                    height: 100,
                    borderRadius: BorderRadius.circular(20),
                    elevation: 0,
                    borderReq: true,
                    borderColor: naturalGreyColor.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            context.push("/rentalForm", extra: {'userId': uId});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(carRental, height: 40),
                                const SizedBox(height: 5),
                                Text("Rental",style: titleTextStyle,)
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          thickness: 2,
                          color: naturalGreyColor.withOpacity(0.3),
                        ),
                        InkWell(
                          onTap: () {
                            context.push("/package", extra: {"user": uId});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(holidays, height: 40),
                                const SizedBox(height: 5),
                                Text("Package",style: titleTextStyle,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CustomText(
                    content: "Exclusive Partner",
                    align: TextAlign.start,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) => ListContainerDesign(
                      imageList: images[index],
                    ),
                    //     CommonContainer(
                    //   elevation: 0,
                    //   height: 140,
                    //   width: AppDimension.getWidth(context) * .7,
                    //   color: background,
                    //   child: Image.asset(
                    //     images[index],
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  ),
                ),
                CommonContainer(
                  height: 70,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: bgGreyColor,
                  borderRadius: BorderRadius.circular(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        content: "Stories By Travellers",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      CommonContainer(
                        color: bgGreyColor,
                        onTap: () {
                          context.push("/package", extra: {"user": uId});
                        },
                        elevation: 0,
                        borderRadius: BorderRadius.circular(0),
                        child: Row(
                          children: [
                            const CustomText(
                                content: "View All",
                                textColor: blueTextColor,
                                fontSize: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                    color: blueTextColor,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: background,
                                  size: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: AppDimension.getHeight(context) * .75,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: CustomGridView(
                    onTap: () {
                      print('Grid View Print');
                    },
                    gridImages:
                        List.generate(images.length, (index) => images[index]),
                  ),
                )
              ],
            ),
          ),
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
                  padding: EdgeInsets.only(top: 50, bottom: 20),
                  child: CustomTextWidget(
                      content: "Are you sure want to exit ?",
                      fontSize: 18,
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
              child: Image.asset(imageList,fit: BoxFit.fill)),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: background
          ),
          child: const CustomText(content: "HOTELS",fontSize: 10,fontWeight: FontWeight.w600,),
        ),),
        Positioned(
          bottom: 5,
          left: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                decoration: const BoxDecoration(
                    color: background
                ),
                child: const CustomText(content: "PRICE DROP ALERT",fontSize: 10,fontWeight: FontWeight.w600,),
              ),
              const CustomText(content: "Grab Up to 25% OFF* on Internation Hotels",textColor: background,fontWeight: FontWeight.w600,),
              const CustomText(content: "& plan your 15-19 Aug LOOONG weekend trip",textColor: background,fontSize: 10,fontWeight: FontWeight.w600),
            ],
          ),)
      ],
    );
  }
}
