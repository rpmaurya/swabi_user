import 'package:flutter/material.dart';
import 'package:flutter_cab/model/user_profile_model.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/res/razorPay_payment.dart';
import 'package:flutter_cab/res/validationTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/package_view_model.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../res/increaseORdiscreaseButton.dart';

class PackageBookingMemberPage extends StatefulWidget {
  final String userID;
  final String amt;
  final String bookingDate;
  final String packageID;

  const PackageBookingMemberPage(
      {super.key,
      required this.userID,
      required this.packageID,
      required this.amt,
      required this.bookingDate});

  @override
  State<PackageBookingMemberPage> createState() =>
      _PackageBookingMemberPageState();
}

class _PackageBookingMemberPageState extends State<PackageBookingMemberPage> {
  List<TextEditingController> controller =
      List.generate(2, (index) => TextEditingController());

  List<Map<String, dynamic>> members = [];
  double amount = 0.0;
  bool loader = false;

  int adultNumber = 0;
  int childNumber = 0;
  int infentNumber = 0;
  bool isAddAdultDisabled = true;
  bool isAddChildDisabled = true;
  bool isAddInfentDisabled = true;
  int intAdultNumber = 0;
  int intChildNumber = 0;
  int intInfentdNumber = 0;
  bool tableIcon = false;
  String type = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateButtonStates();
    controller[0].text = widget.bookingDate;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .fetchUserProfileViewModelApi(context, {'userId': widget.userID});
    });
  }

  void addAmount(List<Map<String, dynamic>> data, {bool onCreate = true}) {
    amount = 0.0;
    List<int> check = data.map((e) => int.parse(e["age"])).toList();
    for (int i = 0; i < check.length; i++) {
      if (check[i] > 5) {
        setState(() {
          amount += double.parse(widget.amt);
        });
      }
    }
  }

  ////Update DataTable button Condition
  void updateButtonStates() {
    int adultCount =
        members.where((m) => int.parse(m['age'].toString()) >= 18).length;
    int childCount =
        members.where((m) => int.parse(m['age'].toString()) < 18).length;
    int infentCount =
        members.where((m) => int.parse(m['age'].toString()) < 2).length;
    setState(() {
      isAddAdultDisabled = adultCount >= adultNumber;
      isAddChildDisabled = childCount >= childNumber;
      isAddInfentDisabled = infentCount >= infentNumber;
      // Enable buttons if there are fewer members than the selected counter values
      if (adultCount < adultNumber) {
        isAddAdultDisabled = false;
      }
      if (childCount < childNumber) {
        isAddChildDisabled = false;
      }
      if (infentCount < infentNumber) {
        isAddInfentDisabled = false;
      }
    });
  }

  bool _shouldDisableButton() {
    bool noAdultsPresent =
        !members.any((member) => int.parse(member['age'].toString()) >= 18);
    return amount == 0.0 || noAdultsPresent;
  }

  ///Adult Show Dialog member Added
  void _addAdultMember() {
    String name = "";
    String age = "0";
    String gender = "";
    String ageUnit = '';
    controller[1].clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70),
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: background,
            surfaceTintColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const CustomTextWidget(
                content: "ADD ADULT MEMBER",
                align: TextAlign.center,
                fontSize: 25),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValidationTextField(
                    headingReq: true,
                    heading: "Name",
                    validation: true,
                    prefixIcon: true,
                    img: user,
                    onChange: (p0) {
                      name = p0;
                    },
                    hint: "Enter Name",
                    controller: TextEditingController()),
                // CustomTextFeild(
                //   controller: TextEditingController(),
                //   headingReq: true,
                //   prefixIcon: true,
                //   img: user,
                //   onChange: (p0) {
                //     name = p0;
                //   },
                //   heading: "Name",
                //   hint: "Enter Name",
                // ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: TextEditingController(),
                  // width: AppDimension.getWidth(context)*.9,
                  headingReq: true,
                  prefixIcon: true,
                  img: user,
                  number: true,
                  digitNumber: 2,
                  onChange: (p0) {
                    age = p0;
                  },
                  heading: "Age",
                  hint: "Enter Age",
                ),
                const SizedBox(height: 10),
                FormCommonSingleAlertSelector(
                  title: "Gender",
                  controller: controller[1],
                  textStyle: titleTextStyle,
                  showIcon: const Icon(
                    Icons.event_seat,
                    color: naturalGreyColor,
                  ),
                  iconReq: false,
                  data: const ["Male", "Female"],
                  // icons: gender,
                  icon: genderImg,
                  elevation: 0,

                  ///Hint Color
                  initialValue: "Select Gender",
                  alertBoxTitle: "Select Gender",
                ),
              ],
            ),
            actions: [
              CustomButtonSmall(
                width: 80,
                btnHeading: "CANCEL",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButtonSmall(
                width: 80,
                onTap: () {
                  ageUnit = 'Year';
                  gender = controller[1].text;
                  if (name.isEmpty || name.length >= 25) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (age.isEmpty || double.parse(age) <= 0) {
                    Utils.flushBarErrorMessage("Please Enter Age", context);
                  } else if (double.parse(age) < 18) {
                    Utils.flushBarErrorMessage(
                        "Adult must be 18 or older", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Gender", context);
                  } else {
                    setState(() {
                      members.add({
                        'name': name,
                        'age': age,
                        'gender': gender,
                        'ageUnit': ageUnit,
                      });
                      updateButtonStates();
                    });
                    addAmount(members);
                    name = '';
                    age = '';
                    gender = '';
                    ageUnit = '';
                    Navigator.of(context).pop();
                  }
                },
                btnHeading: "ADD",
              ),
            ],
          ),
        );
      },
    );
  }

  ///Child Show Dialog member Added
  void _addChildMember() {
    String name = "";
    String age = "0";
    String gender = "";
    String ageUnit = '';
    controller[1].clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70),
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: background,
            surfaceTintColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const CustomTextWidget(
                content: "ADD CHILD MEMBER",
                align: TextAlign.center,
                fontSize: 25),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValidationTextField(
                    headingReq: true,
                    heading: "Name",
                    validation: true,
                    prefixIcon: true,
                    img: user,
                    onChange: (p0) {
                      name = p0;
                    },
                    hint: "Enter Name",
                    controller: TextEditingController()),
                // CustomTextFeild(
                //   controller: TextEditingController(),
                //   headingReq: true,
                //   prefixIcon: true,
                //   img: user,
                //   onChange: (p0) {
                //     name = p0;
                //   },
                //   heading: "Name",
                //   hint: "Enter Name",
                // ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: TextEditingController(),
                  // width: AppDimension.getWidth(context)*.9,
                  headingReq: true,
                  prefixIcon: true,
                  img: user,
                  number: true,
                  digitNumber: 2,
                  onChange: (p0) {
                    age = p0;
                  },
                  heading: "Age",
                  hint: "Enter Age",
                ),
                // CustomTextFeild(
                //   controller: TextEditingController(),
                //   // width: AppDimension.getWidth(context)*.9,
                //   headingReq: true,
                //   prefixIcon: true,
                //   img: user,
                //   number: true,
                //   digitNumber: 2,
                //   onChange: (p0) {
                //     type = p0;
                //   },
                //   heading: "Type",
                // ),
                const SizedBox(height: 10),
                FormCommonSingleAlertSelector(
                  title: "Gender",
                  controller: controller[1],
                  textStyle: titleTextStyle,
                  showIcon: const Icon(
                    Icons.event_seat,
                    color: naturalGreyColor,
                  ),
                  iconReq: false,
                  data: const ["Male", "Female"],
                  // icons: gender,
                  icon: genderImg,
                  elevation: 0,

                  ///Hint Color
                  initialValue: "Select Gender",
                  alertBoxTitle: "Select Gender",
                ),
              ],
            ),
            actions: [
              CustomButtonSmall(
                width: 80,
                btnHeading: "CANCEL",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButtonSmall(
                width: 80,
                onTap: () {
                  ageUnit = 'Year';
                  gender = controller[1].text;
                  if (name.isEmpty || name.length >= 25) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (age.isEmpty || double.parse(age) <= 0) {
                    Utils.flushBarErrorMessage("Please Enter Age", context);
                  } else if (double.parse(age) >= 18) {
                    Utils.flushBarErrorMessage(
                        "Child must be under 18", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Gender", context);
                  } else {
                    setState(() {
                      members.add({
                        'name': name,
                        'age': age,
                        'gender': gender,
                        'ageUnit': ageUnit,
                      });
                      updateButtonStates();
                    });
                    addAmount(members);
                    name = '';
                    age = '';
                    gender = '';
                    ageUnit = '';
                    Navigator.of(context).pop();
                  }
                },
                btnHeading: "ADD",
              ),
            ],
          ),
        );
      },
    );
  }

  ///Child Show Dialog member Added
  void _addInfantdMember() {
    String name = "";
    String age = "0";
    String gender = "";
    String ageUnit = '';
    controller[1].clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70),
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: background,
            surfaceTintColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const CustomTextWidget(
                content: "ADD INFANT MEMBER",
                align: TextAlign.center,
                fontSize: 25),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValidationTextField(
                    headingReq: true,
                    heading: "Name",
                    validation: true,
                    prefixIcon: true,
                    img: user,
                    onChange: (p0) {
                      name = p0;
                    },
                    hint: "Enter Name",
                    controller: TextEditingController()),
                // CustomTextFeild(
                //   controller: TextEditingController(),
                //   headingReq: true,
                //   prefixIcon: true,
                //   img: user,
                //   onChange: (p0) {
                //     name = p0;
                //   },
                //   heading: "Name",
                //   hint: "Enter Name",
                // ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: TextEditingController(),
                  // width: AppDimension.getWidth(context)*.9,
                  headingReq: true,
                  prefixIcon: true,
                  img: user,
                  number: true,
                  digitNumber: 2,
                  onChange: (p0) {
                    age = p0;
                    // double age1 = double.parse('${age/12}');
                    // print(age1);
                  },
                  heading: "Age",
                  hint: "Enter Age",
                ),
                const SizedBox(height: 10),
                FormCommonSingleAlertSelector(
                  title: "Gender",
                  controller: controller[1],
                  textStyle: titleTextStyle,
                  showIcon: const Icon(
                    Icons.event_seat,
                    color: naturalGreyColor,
                  ),
                  iconReq: false,
                  data: const ["Male", "Female"],
                  // icons: gender,
                  icon: genderImg,
                  elevation: 0,

                  ///Hint Color
                  initialValue: "Select Gender",
                  alertBoxTitle: "Select Gender",
                ),
              ],
            ),
            actions: [
              CustomButtonSmall(
                width: 80,
                btnHeading: "CANCEL",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButtonSmall(
                width: 80,
                onTap: () {
                  ageUnit = 'Month';
                  gender = controller[1].text;
                  if (name.isEmpty || name.length >= 25) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (age.isEmpty || double.parse(age) <= 0) {
                    Utils.flushBarErrorMessage("Please Enter Age", context);
                  } else if (double.parse(age) >= 24) {
                    Utils.flushBarErrorMessage(
                        "Infant must be under 24 month", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Gender", context);
                  } else {
                    setState(() {
                      members.add({
                        'name': name,
                        'age': age,
                        'gender': gender,
                        'ageUnit': ageUnit
                      });
                      updateButtonStates();
                    });
                    addAmount(members);
                    name = '';
                    age = '';
                    gender = '';
                    ageUnit = '';
                    Navigator.of(context).pop();
                  }
                },
                btnHeading: "ADD",
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller[0].dispose();
    controller[1].dispose();
  }

  // bool tableIcon = false;
  var profileUser;
  @override
  Widget build(BuildContext context) {
    String status = context
        .watch<GetPackageBookingByIdViewModel>()
        .getPackageBookingById
        .status
        .toString();
    profileUser = context.watch<UserProfileViewModel>().DataList.data?.data;
    debugPrint("${widget.userID}User");
    debugPrint("${widget.packageID}package");
    debugPrint("${widget.amt}amount");
    return Scaffold(
      backgroundColor: bgGreyColor,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        heading: "Package Booking",
      ),
      body: PageLayout_Page(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Booking Date",
                            overflow: TextOverflow.ellipsis,
                            style: titleTextStyle,
                          ),
                        ),
                        CommonContainer(
                          width: AppDimension.getWidth(context) * .94,
                          // width: AppDimension.getWidth(context) / 1.4,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          borderReq: true,
                          elevation: 0,
                          color: bgGreyColor.withOpacity(0.4),
                          borderColor: naturalGreyColor.withOpacity(.3),
                          borderRadius: BorderRadius.circular(5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: naturalGreyColor,
                              ),
                              const SizedBox(width: 10),
                              CustomTextWidget(
                                  content: controller[0].text,
                                  fontSize: 16,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w600)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30.0,
                      runSpacing: 10.0,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DynamicCounter(
                          label: "Adult:",
                          initialValue: 0,
                          limit: 10,
                          onChanged: (adultVal) {
                            setState(() {
                              adultNumber = adultVal;
                              updateButtonStates();
                              // isAddAdultDisabled = adultNumber == 0;
                            });
                          },
                        ),
                        DynamicCounter(
                          label: "Child:",
                          initialValue: 0,
                          limit: 4,
                          onChanged: (childVal) {
                            setState(() {
                              childNumber = childVal;
                              updateButtonStates();
                              // isAddChildDisabled = childNumber == 0;
                            });
                          },
                        ),
                        DynamicCounter(
                          label: "Infant:",
                          initialValue: 0,
                          limit: 4,
                          onChanged: (infentdVal) {
                            setState(() {
                              infentNumber = infentdVal;
                              updateButtonStates();
                              // isAddChildDisabled = childNumber == 0;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonSmall(
                          titleReq: false,
                          elevation: 0,
                          elevationReq: true,
                          buttonColor: btnColor,
                          borderRadius: BorderRadius.circular(5),
                          width: AppDimension.getWidth(context) / 4.5,
                          btnHeading: "Add Adult",
                          disable: isAddAdultDisabled,
                          height: 40,
                          onTap: () {
                            _addAdultMember();
                            setState(() {
                              type = 'Adult';
                              updateButtonStates();
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        CustomButtonSmall(
                          titleReq: false,
                          elevation: 0,
                          elevationReq: true,
                          buttonColor: btnColor,
                          borderRadius: BorderRadius.circular(5),
                          width: AppDimension.getWidth(context) / 4.5,
                          btnHeading: "Add Child",
                          height: 40,
                          disable: isAddChildDisabled,
                          onTap: () {
                            _addChildMember();
                            setState(() {
                              type = 'Child';
                              updateButtonStates();
                            });
                          },
                        ),
                        const SizedBox(width: 20),
                        CustomButtonSmall(
                          titleReq: false,
                          elevation: 0,
                          elevationReq: true,
                          buttonColor: btnColor,
                          borderRadius: BorderRadius.circular(5),
                          width: AppDimension.getWidth(context) / 4.5,
                          btnHeading: "infant",
                          height: 40,
                          disable: isAddInfentDisabled,
                          onTap: () {
                            _addInfantdMember();
                            setState(() {
                              type = 'Infant';
                              updateButtonStates();
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CommonContainer(
                        elevation: 0,
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: background,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 300,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Scaffold(
                                    backgroundColor: background,
                                    body: CommonContainer(
                                      height: 300,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                const CustomText(
                                                    content: 'Information',
                                                    fontWeight: FontWeight.w600,
                                                    textColor: redColor),
                                                CommonContainer(
                                                  elevation: 0,
                                                  height: 40,
                                                  width: 40,
                                                  onTap: () => context.pop(),
                                                  child: const Icon(
                                                      Icons.cancel_outlined),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          CommonContainer(
                                            // height: 50,
                                            width:
                                                AppDimension.getWidth(context) *
                                                    .9,
                                            borderColor: naturalGreyColor
                                                .withOpacity(0.3),
                                            borderReq: true,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 14),
                                            child: const CustomText(
                                              align: TextAlign.start,
                                              maxline: 2,
                                              content:
                                                  "Children under 5 years old can be booked for free.",
                                              textColor: redColor,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          CommonContainer(
                                            borderColor: naturalGreyColor
                                                .withOpacity(0.3),
                                            borderReq: true,
                                            width:
                                                AppDimension.getWidth(context) *
                                                    .9,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 14),
                                            child: const CustomText(
                                              align: TextAlign.start,
                                              textEllipsis: false,
                                              maxline: 5,
                                              content:
                                                  "Certain activities are not recommended for senior citizens due to potential health risks.*",
                                              textColor: redColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const CustomText(
                          content: "*Please Note*",
                          textColor: btnColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // const SizedBox(height: 5),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(100),
                          1: FixedColumnWidth(75),
                          2: FixedColumnWidth(75),
                          3: FixedColumnWidth(70),
                          4: FixedColumnWidth(80)
                        },
                        // defaultColumnWidth: FixedColumnWidth(100),
                        children: [
                          TableRow(
                              decoration: const BoxDecoration(
                                color: btnColor,
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10, top: 10),
                                  child: Text(
                                    'Name',
                                    style: tableheaderStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    'Age',
                                    style: tableheaderStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    'Gender',
                                    style: tableheaderStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    'Type',
                                    style: tableheaderStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                    'Action',
                                    style: tableheaderStyle,
                                  ),
                                ),
                              ])
                        ],
                      ),
                      Expanded(
                        child: members.isEmpty
                            ? Container(
                                child: Center(child: Text('No Members Added')),
                              )
                            : SingleChildScrollView(
                                child: Table(
                                  columnWidths: const {
                                    0: FixedColumnWidth(100),
                                    1: FixedColumnWidth(75),
                                    2: FixedColumnWidth(75),
                                    3: FixedColumnWidth(70),
                                    4: FixedColumnWidth(80)
                                  },
                                  // defaultColumnWidth: FixedColumnWidth(100),
                                  children: members.map((member) {
                                    int index = members.indexOf(member);
                                    print('objectindex$index');
                                    return TableRow(
                                        // decoration:
                                        //     BoxDecoration(color: background),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, bottom: 10, top: 10),
                                            child: Text(
                                              member['name'],
                                              style: titleTextStyle1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              '${member['age']} ${member['ageUnit']}',
                                              style: titleTextStyle1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              member['gender'],
                                              style: titleTextStyle1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              member['ageUnit'] == 'Month'
                                                  ? 'Infant'
                                                  : int.parse(member['age']) <
                                                          18
                                                      ? 'Child'
                                                      : 'Adult',
                                              style: titleTextStyle1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  child: const Icon(Icons.edit,
                                                      color: greenColor),
                                                  onTap: () {
                                                    int age = int.parse(
                                                        member['age']
                                                            .toString());
                                                    String ageunit =
                                                        member['ageUnit']
                                                            .toString();
                                                    if (ageunit == 'Month') {
                                                      _editInfantdMember(index);
                                                    } else {
                                                      if (age >= 18) {
                                                        _editAdultMember(index);
                                                      } else {
                                                        _editChildMember(index);
                                                        // addedChildCount++;
                                                      }
                                                    }
                                                    setState(() {
                                                      tableIcon = false;
                                                      updateButtonStates();
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  child: const Icon(
                                                      Icons.delete,
                                                      color: redColor),
                                                  onTap: () {
                                                    setState(() {
                                                      members.removeAt(index);
                                                      addAmount(members);
                                                      tableIcon = false;
                                                      updateButtonStates();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]);
                                  }).toList(),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // Flexible(
              //   child: Container(
              //       margin:
              //           const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              //       padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              //       decoration: ShapeDecoration(
              //         color: Colors.white,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(4)),
              //       ),
              //       child: Column(
              //         children: [
              //           Container(
              //             padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              //             decoration: const BoxDecoration(
              //                 border: Border(
              //               bottom: BorderSide(
              //                   width: 0.5, color: Color(0xFFC1C0C0)),
              //             )),
              //             child: const Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   SizedBox(
              //                       width: 60,
              //                       child: CustomTextWidget(
              //                         align: TextAlign.start,
              //                         content: "Name",
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.w700,
              //                       )),
              //                   SizedBox(
              //                       width: 40,
              //                       child: CustomTextWidget(
              //                           content: "Age",
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700)),
              //                   SizedBox(
              //                       width: 65,
              //                       child: CustomTextWidget(
              //                           content: "Gender",
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700)),
              //                   SizedBox(
              //                       width: 60,
              //                       child: CustomTextWidget(
              //                           content: "Type",
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700)),
              //                   SizedBox(
              //                       width: 60,
              //                       child: CustomTextWidget(
              //                           content: "Action",
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700))
              //                 ]),
              //           ),

              //           ///New Code
              //           Expanded(
              //             child: members.isEmpty
              //                 ? const Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       CustomText(
              //                         content: 'No Members Added',
              //                         textColor: redColor,
              //                       ),
              //                     ],
              //                   )
              //                 : SingleChildScrollView(
              //                     child: Container(
              //                       padding: const EdgeInsets.symmetric(
              //                           horizontal: 10),
              //                       child: Column(
              //                         children:
              //                             members.asMap().entries.map((entry) {
              //                           int index = entry.key;
              //                           Map<String, dynamic> member =
              //                               entry.value;
              //                           return Container(
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 10, horizontal: 5),
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 SizedBox(
              //                                   // color: Colors.cyan,
              //                                   width: 50,
              //                                   child: CustomText(
              //                                     align: TextAlign.start,
              //                                     content:
              //                                         member['name'].toString(),
              //                                     textEllipsis: true,
              //                                     // maxline: 2,
              //                                   ),
              //                                 ),
              //                                 SizedBox(
              //                                   // color: Colors.cyan,
              //                                   width: 30,
              //                                   child: CustomText(
              //                                     textEllipsis: false,
              //                                     align: TextAlign.start,
              //                                     content:
              //                                         "${member['age'].toString()}${member['ageUnit'].toString()}",
              //                                   ),
              //                                 ),
              //                                 CustomText(
              //                                   content:
              //                                       member['gender'].toString(),
              //                                   align: TextAlign.start,
              //                                 ),
              //                                 SizedBox(
              //                                   // color: Colors.cyan,
              //                                   // width: ,
              //                                   child: CustomText(
              //                                     align: TextAlign.start,
              //                                     textColor: (() {
              //                                       int age = int.parse(
              //                                           member['age']
              //                                               .toString());
              //                                       return age >= 60
              //                                           ? redColor
              //                                           : null; // Set color to red for Senior, otherwise use default
              //                                     })(),
              //                                     content: (() {
              //                                       int age = int.parse(
              //                                           member['age']
              //                                               .toString());
              //                                       String ageunit =
              //                                           member['ageUnit']
              //                                               .toString();
              //                                       print(ageunit);
              //                                       if (ageunit == 'Month') {
              //                                         return 'Infant';
              //                                       } else {
              //                                         if (age < 18) {
              //                                           return 'Child';
              //                                         }
              //                                         if (age < 60) {
              //                                           return 'Adult';
              //                                         }
              //                                       }

              //                                       return 'Senior*';
              //                                     })(),
              //                                   ),
              //                                 ),
              //                                 Row(
              //                                   mainAxisSize: MainAxisSize.min,
              //                                   children: [
              //                                     InkWell(
              //                                       child: const Icon(
              //                                           Icons.edit,
              //                                           color: greenColor),
              //                                       onTap: () {
              //                                         int age = int.parse(
              //                                             member['age']
              //                                                 .toString());
              //                                         String ageunit =
              //                                             member['ageUnit']
              //                                                 .toString();
              //                                         if (ageunit == 'Month') {
              //                                         } else {
              //                                           if (age >= 18) {
              //                                             _editAdultMember(
              //                                                 index);
              //                                           } else {
              //                                             _editChildMember(
              //                                                 index);
              //                                             // addedChildCount++;
              //                                           }
              //                                         }
              //                                         setState(() {
              //                                           tableIcon = false;
              //                                           updateButtonStates();
              //                                         });
              //                                       },
              //                                     ),
              //                                     const SizedBox(width: 10),
              //                                     InkWell(
              //                                       child: const Icon(
              //                                           Icons.delete,
              //                                           color: redColor),
              //                                       onTap: () {
              //                                         setState(() {
              //                                           members.removeAt(index);
              //                                           addAmount(members);
              //                                           tableIcon = false;
              //                                           updateButtonStates();
              //                                         });
              //                                       },
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ],
              //                             ),
              //                           );
              //                         }).toList(),
              //                       ),
              //                     ),
              //                   ),
              //           )
              //         ],
              //       )),
              // ),

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
                          text: "Price : ",
                          style: GoogleFonts.lato(
                            color: background,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      //Total Amt
                      TextSpan(
                        text: "$amount",
                        style: GoogleFonts.lato(
                          color: background,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ])),
                    CustomButtonSmall(
                        width: 120,
                        borderRadius: BorderRadius.circular(5),
                        btnHeading: "BOOK NOW",
                        elevation: 5,
                        loading: status == "Status.loading" && loader,
                        elevationReq: true,
                        buttonColor: btnColor,
                        disable: _shouldDisableButton(),
                        // disable: amount == 0.0 ?  true : false,
                        onTap: () {
                          if (members.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Please add Members First", context);
                          } else if (controller[0].text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Please select date", context);
                          } else {
                            loader = true;
                            print('mobile....${profileUser.mobile}');
                            showDialog(
                              context: context,
                              builder: (context) {
                                return RazorpayPayment(
                                  userId: widget.userID.toString(),
                                  amount: amount,
                                  email: profileUser?.email,
                                  coutryCode: profileUser?.countryCode,
                                  mobileNo: profileUser?.mobile,
                                );
                              },
                            ).then((_) async {
                              if (!mounted) return;

                              // Retrieve transaction ID
                              var transactionId =
                                  await Provider.of<PaymentVerifyViewModel>(
                                        context,
                                        listen: false,
                                      )
                                          .paymentVerify
                                          .data
                                          ?.data
                                          .transactionId ??
                                      '';
                              Provider.of<GetPackageBookingByIdViewModel>(
                                      listen: false, context)
                                  .fetchGetPackageBookingByIdViewModelApi(
                                      context,
                                      {
                                        "userId": widget.userID.toString(),
                                        "packageId":
                                            widget.packageID.toString(),
                                        "bookingDate": controller[0].text,
                                        "transactionId": transactionId,
                                        "numberOfMembers":
                                            members.length.toString(),
                                        "memberList": members,
                                      },
                                      widget.userID);
                            });

                            // Utils.flushBarSuccessMessage("Booking Success", context);
                          }
                        }),
                  ],
                ),
              )
            ],
          )),
    );
  }

  ///Edit Adult Alert Box
  void _editAdultMember(int index) {
    String name = members[index]['name'];
    String age = members[index]['age'];
    String gender = members[index]['gender'];
    controller[1].text = gender;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70),
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: background,
            surfaceTintColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const CustomTextWidget(
                content: "EDIT MEMBER", align: TextAlign.center, fontSize: 25),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValidationTextField(
                  headingReq: true,
                  heading: "Name",
                  validation: true,
                  prefixIcon: true,
                  img: user,
                  onChange: (p0) {
                    name = p0;
                  },
                  hint: "Enter Name",
                  controller: TextEditingController(text: name),
                ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: TextEditingController(text: age),
                  headingReq: true,
                  prefixIcon: true,
                  img: user,
                  number: true,
                  digitNumber: 2,
                  onChange: (p0) {
                    age = p0;
                  },
                  heading: "Age",
                  hint: "Enter Age",
                ),
                const SizedBox(height: 10),
                FormCommonSingleAlertSelector(
                  title: "Gender",
                  controller: controller[1],
                  textStyle: titleTextStyle,
                  showIcon: const Icon(
                    Icons.event_seat,
                    color: naturalGreyColor,
                  ),
                  data: const ["Male", "Female"],
                  icon: genderImg,
                  elevation: 0,
                  initialValue: gender,
                  alertBoxTitle: "Select Gender",
                ),
              ],
            ),
            actions: [
              CustomButtonSmall(
                width: 80,
                btnHeading: "CANCEL",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButtonSmall(
                width: 80,
                onTap: () {
                  gender = controller[1].text;
                  if (name.isEmpty || name.length >= 25) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (age.isEmpty || double.parse(age) <= 0) {
                    Utils.flushBarErrorMessage("Please Enter Age", context);
                  } else if (double.parse(age) < 18) {
                    Utils.flushBarErrorMessage(
                        "Adult must be 18 or older", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Gender", context);
                  } else {
                    setState(() {
                      members[index] = {
                        'name': name,
                        'age': age,
                        'gender': gender,
                      };
                      updateButtonStates();
                    });
                    addAmount(members);
                    Navigator.of(context).pop();
                  }
                },
                btnHeading: "UPDATE",
              ),
            ],
          ),
        );
      },
    );
  }

  ///Edit Child Alert Box
  void _editChildMember(int index) {
    String name = members[index]['name'];
    String age = members[index]['age'];
    String ageUnit = members[index]['ageUnit'];
    String gender = members[index]['gender'];
    controller[1].text = gender;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70),
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: background,
            surfaceTintColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const CustomTextWidget(
                content: "EDIT CHILD MEMBER",
                align: TextAlign.center,
                fontSize: 25),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ValidationTextField(
                headingReq: true,
                heading: "Name",
                validation: true,
                prefixIcon: true,
                img: user,
                onChange: (p0) {
                  name = p0;
                },
                hint: "Enter Name",
                controller: TextEditingController(text: name),
              ),
              const SizedBox(height: 10),
              CustomTextFeild(
                controller: TextEditingController(text: age),
                headingReq: true,
                prefixIcon: true,
                img: user,
                number: true,
                digitNumber: 2,
                onChange: (p0) {
                  age = p0;
                },
                heading: "Age",
                hint: "Enter Age",
              ),
              const SizedBox(height: 10),
              FormCommonSingleAlertSelector(
                title: "Gender",
                controller: controller[1],
                textStyle: titleTextStyle,
                showIcon: const Icon(
                  Icons.event_seat,
                  color: naturalGreyColor,
                ),
                iconReq: false,
                data: const ["Male", "Female"],
                icon: genderImg,
                elevation: 0,
                initialValue: gender,
                alertBoxTitle: "Select Gender",
              ),
            ]),
            actions: [
              CustomButtonSmall(
                width: 80,
                btnHeading: "CANCEL",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButtonSmall(
                width: 80,
                onTap: () {
                  gender = controller[1].text;
                  if (name.isEmpty || name.length >= 25) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (age.isEmpty || double.parse(age) <= 0) {
                    Utils.flushBarErrorMessage("Please Enter Age", context);
                  } else if (double.parse(age) >= 18) {
                    Utils.flushBarErrorMessage(
                        "Child must be under 18", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Gender", context);
                  } else {
                    setState(() {
                      members[index] = {
                        'name': name,
                        'age': age,
                        'gender': gender,
                        'ageUnit': ageUnit
                      };
                      updateButtonStates();
                    });
                    addAmount(members);
                    Navigator.of(context).pop();
                  }
                },
                btnHeading: "UPDATE",
              ),
            ],
          ),
        );
      },
    );
  }

  ///Edit Child Alert Box
  void _editInfantdMember(int index) {
    String name = members[index]['name'];
    String age = members[index]['age'];
    String ageUnit = members[index]['ageUnit'];
    String gender = members[index]['gender'];
    controller[1].text = gender;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70),
          physics: const NeverScrollableScrollPhysics(),
          child: AlertDialog(
            backgroundColor: background,
            surfaceTintColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const CustomTextWidget(
                content: "EDIT INFANT MEMBER",
                align: TextAlign.center,
                fontSize: 25),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ValidationTextField(
                headingReq: true,
                heading: "Name",
                validation: true,
                prefixIcon: true,
                img: user,
                onChange: (p0) {
                  name = p0;
                },
                hint: "Enter Name",
                controller: TextEditingController(text: name),
              ),
              const SizedBox(height: 10),
              CustomTextFeild(
                controller: TextEditingController(text: age),
                headingReq: true,
                prefixIcon: true,
                img: user,
                number: true,
                digitNumber: 2,
                onChange: (p0) {
                  age = p0;
                },
                heading: "Age",
                hint: "Enter Age",
              ),
              const SizedBox(height: 10),
              FormCommonSingleAlertSelector(
                title: "Gender",
                controller: controller[1],
                textStyle: titleTextStyle,
                showIcon: const Icon(
                  Icons.event_seat,
                  color: naturalGreyColor,
                ),
                iconReq: false,
                data: const ["Male", "Female"],
                icon: genderImg,
                elevation: 0,
                initialValue: gender,
                alertBoxTitle: "Select Gender",
              ),
            ]),
            actions: [
              CustomButtonSmall(
                width: 80,
                btnHeading: "CANCEL",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomButtonSmall(
                width: 80,
                onTap: () {
                  gender = controller[1].text;
                  if (name.isEmpty || name.length >= 25) {
                    Utils.flushBarErrorMessage("Please Enter Name", context);
                  } else if (age.isEmpty || double.parse(age) <= 0) {
                    Utils.flushBarErrorMessage("Please Enter Age", context);
                  } else if (double.parse(age) >= 24) {
                    Utils.flushBarErrorMessage(
                        "Infant must be under 24", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage("Please Enter Gender", context);
                  } else {
                    setState(() {
                      members[index] = {
                        'name': name,
                        'age': age,
                        'gender': gender,
                        'ageUnit': ageUnit
                      };
                      updateButtonStates();
                    });
                    addAmount(members);
                    Navigator.of(context).pop();
                  }
                },
                btnHeading: "UPDATE",
              ),
            ],
          ),
        );
      },
    );
  }
}
