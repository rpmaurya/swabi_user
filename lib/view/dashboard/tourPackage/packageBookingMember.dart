import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20%20Button/customdropdown_button.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customPhoneField.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/package_view_model.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/services/paymentService.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:marquee/marquee.dart';

import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController primaryNoController = TextEditingController();
  TextEditingController secondaryNoController = TextEditingController();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  GlobalKey _phoneKey = GlobalKey();
  bool tableIcon = false;

  // String ageUnit = '';
  List<Map<String, dynamic>> members = [];
  double amount = 0.0;
  bool loader = false;
  bool isAddAdultDisabled = false;
  bool isAddChildDisabled = false;
  bool isAddInfentDisabled = false;
  String validationMessage = '';
  String primaryCountryCode = '';
  String secondaryCountryCode = '';
  String initialCountryCode = 'AE';

  // int adultNumber = 0;
  // int childNumber = 0;
  // int infentNumber = 0;

  // int intAdultNumber = 0;
  // int intChildNumber = 0;
  // int intInfentdNumber = 0;
  // String type = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updateButtonStates();
    controller[0].text = widget.bookingDate;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .fetchUserProfileViewModelApi(context, {'userId': widget.userID});
      getData();
    });
  }

  getData() async {
    await Future.delayed(Duration(seconds: 2));
    final userProfile =
        await Provider.of<UserProfileViewModel>(context, listen: false)
            .DataList
            .data!
            .data;

    // Set the primary country code and primary number
    setState(() {
      primaryCountryCode = userProfile.countryCode;
      primaryNoController.text = userProfile.mobile;
      var list = countries
          .where((code) => code.dialCode == primaryCountryCode)
          .toList();
      if (list.isNotEmpty) {
        // controllers[4].text = list.first.dialCode;
        initialCountryCode = list.first.code;
        _phoneKey = GlobalKey();
        //  = list.first.code;
        print('isocode.................... ${list.first.code}');
      }
    });
  }

  void _addAmount() {
    setState(() {
      amount += double.parse(widget.amt);
    });
  }

  void _subAmount() {
    setState(() {
      amount -= double.parse(widget.amt);
    });
  }

  bool _shouldDisableButton() {
    bool noAdultsPresent =
        !members.any((member) => int.parse(member['age'].toString()) >= 18);
    return amount == 0.0 || noAdultsPresent;
  }

  /// Add memeber
  void _addMember(
      {required String title, required String ageUnit, required String type}) {
    nameController.text = '';
    ageController.text = '';
    genderController.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setstate) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 70),
            physics: const NeverScrollableScrollPhysics(),
            child: AlertDialog(
              backgroundColor: background,
              surfaceTintColor: background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: CustomTextWidget(
                  content: title, align: TextAlign.center, fontSize: 25),
              content: Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Name',
                        style: titleTextStyle,
                      ),
                    ),
                    Customtextformfield(
                      focusNode: focusNode1,
                      controller: nameController,
                      hintText: 'Enter Name',
                      // errorText:
                      //     validationMessage.isEmpty ? '' : validationMessage,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      // onChanged: (p0) {
                      //   if (p0 != '') {
                      //     setstate(() {
                      //       validationMessage = 'return error';
                      //     });
                      //   } else {
                      //     validationMessage = '';
                      //   }
                      // },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Age',
                        style: titleTextStyle,
                      ),
                    ),
                    Customtextformfield(
                      focusNode: focusNode2,
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      hintText: 'Enter Age',
                      validator: (value) {
                        int age = int.tryParse(value ?? '')?.toInt() ?? 0;

                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        } else if (type == 'Adult') {
                          print('type of member1$type');
                          if (age < 18 || age >= 60) {
                            return 'Adult must be 18 Year or older';
                          }
                        } else if (type == 'Child') {
                          print('type of member2$type');
                          if (age <= 2 || age >= 18) {
                            return 'Child must be under 2 to 18 Year';
                          }
                        } else if (type == 'Infant') {
                          print('type of member3$type');
                          if (age >= 24) {
                            return 'Infant must be under 24 Month';
                          }
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Gender',
                        style: titleTextStyle,
                      ),
                    ),
                    CustomDropdownButton(
                        focusNode: focusNode3,
                        itemsList: ['Male', 'Female'],
                        onChanged: (value) {
                          setState(() {
                            genderController.text = value;
                          });
                        },
                        hintText: 'Select Gender')
                  ],
                ),
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
                    if (_formKey.currentState!.validate()) {
                      print('succes');
                      setState(() {
                        members.add({
                          'name': nameController.text,
                          'age': ageController.text,
                          'gender': genderController.text,
                          'ageUnit': ageUnit,
                          'type': type
                        });
                        // updateButtonStates();
                      });
                      type == 'Infant' ? null : _addAmount();
                      ageUnit = '';
                      type = '';
                      nameController.text = '';
                      ageController.text = '';
                      genderController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                  btnHeading: "ADD",
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// Update memeber
  void _editMember(
      {required String title,
      required int index,
      required String ageUnit,
      required String type}) {
    nameController.text = members[index]['name'];
    ageController.text = members[index]['age'];
    genderController.text = members[index]['gender'];
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
            title: CustomTextWidget(
                content: title, align: TextAlign.center, fontSize: 25),
            content: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Name',
                      style: titleTextStyle,
                    ),
                  ),
                  Customtextformfield(
                    focusNode: focusNode1,
                    controller: nameController,
                    hintText: 'Enter Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Age',
                      style: titleTextStyle,
                    ),
                  ),
                  Customtextformfield(
                    focusNode: focusNode2,
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter Age',
                    validator: (value) {
                      int age = int.tryParse(value ?? '')?.toInt() ?? 0;

                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      } else if (type == 'Adult') {
                        print('type of member1$type');
                        if (age <= 18 || age >= 60) {
                          return 'Adult must be 18 Year or older';
                        }
                      } else if (type == 'Child') {
                        print('type of member2$type');
                        if (age >= 18) {
                          return 'Child must be under 18 Year';
                        }
                      } else if (type == 'Infant') {
                        print('type of member3$type');
                        if (age >= 24) {
                          return 'Infant must be under 24 Month';
                        }
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Age',
                      style: titleTextStyle,
                    ),
                  ),
                  CustomDropdownButton(
                      selecteValue: genderController.text,
                      focusNode: focusNode3,
                      itemsList: ['Male', 'Female'],
                      onChanged: (value) {
                        setState(() {
                          genderController.text = value;
                        });
                      },
                      hintText: 'Select Gender')
                ],
              ),
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
                  if (_formKey.currentState!.validate()) {
                    print('succes');
                    setState(() {
                      members[index] = {
                        'name': nameController.text,
                        'age': ageController.text,
                        'gender': genderController.text,
                        'ageUnit': ageUnit,
                        'type': type
                      };
                      // updateButtonStates();
                    });
                    // type == 'Infant' ? null : _subAmount();
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
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    primaryNoController.dispose();
    secondaryNoController.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
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
    // primaryCountryCode =
    //     context.watch<UserProfileViewModel>().DataList.data?.data.countryCode ??
    //         '';
    // primaryNoController.text =
    //     context.watch<UserProfileViewModel>().DataList.data?.data.mobile ?? '';
    debugPrint("${widget.userID}User");
    debugPrint("${widget.packageID}package");
    debugPrint("${widget.amt}amount");
    debugPrint('${primaryCountryCode}countrycode,,,,');
    debugPrint('${primaryNoController.text}primary number,,,,');

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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Marquee(
                            showFadingOnlyWhenScrolling: false,
                            text:
                                '*Children under 2 years old can be booked for free. and Certain activities are not recommended for senior citizens due to potential health risks.*',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: redColor),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: AppDimension.getWidth(context),
                            velocity: 100.0,
                            pauseAfterRound: Duration(seconds: 1),
                            startPadding: 0,
                            accelerationDuration: Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration: Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          ),
                        ),
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
                          height: 45,
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
                        const SizedBox(height: 5),
                        Text(
                          'Primary Number',
                          style: titleTextStyle,
                        ),
                        Customphonefield(
                          poneKey: _phoneKey,
                          focusNode: focusNode4,
                          initalCountryCode: initialCountryCode,
                          controller: primaryNoController,
                          onChanged: (phoneNumber) {
                            primaryCountryCode = phoneNumber.countryCode
                                .replaceFirst("+", '')
                                .trim();
                            debugPrint('phone number$primaryCountryCode');
                            // primaryNoController.text = phoneNumber.number;
                          },
                          onCountryChanged: (country) {
                            primaryCountryCode = country.dialCode;
                          },
                          validator: (p0) {
                            return null;
                          },
                        ),
                        const Text(
                          'Secondary Number',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 0),
                        ),
                        Customphonefield(
                          focusNode: focusNode5,
                          initalCountryCode: 'AE',
                          controller: secondaryNoController,
                          onChanged: (phoneNumber) {
                            secondaryCountryCode = phoneNumber.countryCode
                                .replaceFirst("+", '')
                                .trim();
                            // secondaryNoController.text = phoneNumber.number;

                            debugPrint(
                                "${secondaryCountryCode} secondarycode....");
                            debugPrint(
                                "${secondaryNoController.text} secondaryNumber....");
                          },
                          onCountryChanged: (country) {
                            secondaryCountryCode = country.fullCountryCode;
                            debugPrint(
                                "${secondaryCountryCode} secondarycode....");
                          },
                          validator: (p0) async {
                            // String pattern = r'^\+?[0-9]{10,15}$';
                            // RegExp regex = RegExp(pattern);

                            // if (!regex.hasMatch(p0!.completeNumber)) {
                            //   return 'Please enter a valid phone number';
                            // }
                            return null;
                          },
                        ),
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
                            _addMember(
                                title: 'Add Adult Member',
                                ageUnit: 'Year',
                                type: 'Adult');

                            // _addAdultMember();
                            // setState(() {
                            //   type = 'Adult';
                            //   updateButtonStates();
                            // });
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
                            _addMember(
                                title: 'Add Child Member',
                                ageUnit: 'Year',
                                type: 'Child');

                            // _addChildMember();
                            // setState(() {
                            //   type = 'Child';
                            //   updateButtonStates();
                            // });
                          },
                        ),
                        const SizedBox(width: 20),
                        CustomButtonSmall(
                          titleReq: false,
                          elevation: 0,
                          elevationReq: true,
                          buttonColor: btnColor,
                          borderRadius: BorderRadius.circular(5),
                          width: AppDimension.getWidth(context) / 4,
                          btnHeading: "Add Infant",
                          height: 40,
                          disable: isAddInfentDisabled,
                          onTap: () {
                            _addMember(
                                title: 'Add Infant Member',
                                ageUnit: 'Month',
                                type: 'Infant');

                            // _addInfantdMember();
                            // setState(() {
                            //   type = 'Infant';
                            //   updateButtonStates();
                            // });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
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
                                                      // _editInfantdMember(index);
                                                      _editMember(
                                                          title:
                                                              'Edit Infant Member',
                                                          index: index,
                                                          ageUnit: 'Month',
                                                          type: 'Infant');
                                                    } else {
                                                      if (age >= 18) {
                                                        // _editAdultMember(index);
                                                        _editMember(
                                                            title:
                                                                'Edit Adult Member',
                                                            index: index,
                                                            ageUnit: 'Year',
                                                            type: 'Adult');
                                                      } else {
                                                        // _editChildMember(index);
                                                        _editMember(
                                                            title:
                                                                'Edit Child Member',
                                                            index: index,
                                                            ageUnit: 'Year',
                                                            type: 'Child');
                                                        // addedChildCount++;
                                                      }
                                                    }
                                                    setState(() {
                                                      tableIcon = false;
                                                      // updateButtonStates();
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
                                                      // addAmount(members);
                                                      member['ageUnit']
                                                                  .toString() ==
                                                              'Month'
                                                          ? null
                                                          : _subAmount();
                                                      tableIcon = false;
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
                          debugPrint('ghjkjhjkj$primaryCountryCode');
                          if (members.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Please add Members First", context);
                          } else if (controller[0].text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Please select date", context);
                          } else {
                            loader = true;
                            // ignore: unused_element
                            // void initiatePayment(BuildContext context) {
                            PaymentService paymentService = PaymentService(
                              context: context,
                              onPaymentSuccess:
                                  (PaymentSuccessResponse response) {
                                print('paymentResponse#${response.orderId}');
                                Provider.of<PaymentVerifyViewModel>(context,
                                        listen: false)
                                    .paymentVerifyViewModelApi(
                                        context: context,
                                        userId: widget.userID.toString(),
                                        paymentId: response.paymentId,
                                        razorpayOrderId: response.orderId,
                                        razorpaySignature: response.signature)
                                    .then(
                                  (value) {
                                    if (value?.status.httpCode == '200') {
                                      print(
                                          'payment verification is successfull${value?.data.transactionId}');
                                      debugPrint(response.orderId);
                                      debugPrint(
                                        response.paymentId,
                                      );
                                      debugPrint(response.signature);
                                      Provider.of<GetPackageBookingByIdViewModel>(
                                              listen: false, context)
                                          .fetchGetPackageBookingByIdViewModelApi(
                                              context,
                                              {
                                                "userId":
                                                    widget.userID.toString(),
                                                "packageId":
                                                    widget.packageID.toString(),
                                                "bookingDate":
                                                    controller[0].text,
                                                "transactionId":
                                                    value?.data.transactionId,
                                                "countryCode":
                                                    primaryCountryCode
                                                        .replaceAll("+", '')
                                                        .trim(),
                                                "mobile":
                                                    primaryNoController.text,
                                                "alternateMobileCountryCode":
                                                    secondaryCountryCode,
                                                "alternateMobile":
                                                    secondaryNoController.text,
                                                "numberOfMembers":
                                                    members.length.toString(),
                                                "memberList": members,
                                              },
                                              widget.userID);
                                      // context.pop();
                                    }
                                  },
                                );
                                // Call verify payment function after successful payment
                                // _verifyPayment(context, response);
                              },
                            );

                            paymentService.openCheckout(
                                amount: amount,
                                userId: widget.userID.toString(),
                                coutryCode: profileUser?.countryCode,
                                mobileNo: profileUser?.mobile,
                                email: profileUser?.email);

                            // }

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
}
