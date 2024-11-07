import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20%20Button/customdropdown_button.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/Custom%20Widgets/customPhoneField.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_mobileNumber.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/string_extenstion.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/offer_view_model.dart';
import 'package:flutter_cab/view_model/package_view_model.dart';
import 'package:flutter_cab/view_model/payment_gateway_view_model.dart';
import 'package:flutter_cab/view_model/services/paymentService.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:marqueer/marqueer.dart';
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
  final _formCouponKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController primaryNoController = TextEditingController();
  TextEditingController secondaryNoController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode couponFocus = FocusNode();
  GlobalKey _phoneKey = GlobalKey();
  bool tableIcon = false;

  // String ageUnit = '';
  List<Map<String, dynamic>> members = [];
  double sumAmount = 0;
  double payAbleAmount = 0.0;
  bool loader = false;
  bool isAddAdultDisabled = false;
  bool isAddChildDisabled = false;
  bool isAddInfentDisabled = false;
  String validationMessage = '';
  String primaryCountryCode = '';
  String secondaryCountryCode = '971';
  String initialCountryCode = 'AE';

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
    _phoneKey = GlobalKey();
  }

  getData() async {
    await Future.delayed(Duration(seconds: 2));
    final userProfile =
        Provider.of<UserProfileViewModel>(context, listen: false)
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

  double taxPercentage = 5;
  double taxAmount = 0;
  double taxamount() {
    return (taxPercentage / 100) * sumAmount;
    // return sumAmount + taxamt;
  }

  void _addAmount() {
    setState(() {
      sumAmount += double.parse(widget.amt);
      taxAmount = taxamount();
      // amount += double.parse(widget.amt);
      payAbleAmount = sumAmount + taxAmount;
      debugPrint('taxamount....$taxAmount');
      debugPrint('totalPayableAmount....$payAbleAmount');
      discountAmount == 0 ? null : discountAmount = getPercentage();
    });
  }

  void _subAmount() {
    setState(() {
      sumAmount -= double.parse(widget.amt);
      taxAmount = taxamount();

      // amount += double.parse(widget.amt);
      payAbleAmount = sumAmount + taxAmount;
      debugPrint('taxamount....$taxAmount');
      debugPrint('totalPayableAmount....$payAbleAmount');
      discountAmount == 0 ? null : discountAmount = getPercentage();
    });
  }

  bool _shouldDisableButton() {
    bool noAdultsPresent =
        !members.any((member) => int.parse(member['age'].toString()) >= 18);
    return payAbleAmount == 0.0 || noAdultsPresent;
  }

  void showBottomModal(
      {required String title,
      required Widget child,
      required String btnHeading,
      required void Function()? onTap}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setstate) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjust modal size when keyboard opens
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: buttonText,
                        ),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Text(
                              'X',
                              textAlign: TextAlign.end,
                              style: buttonText,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    child,
                    const SizedBox(height: 15),
                    CustomButtonSmall(btnHeading: btnHeading, onTap: onTap)
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  /// Add memeber
  void _addMember(
      {required String title, required String ageUnit, required String type}) {
    nameController.text = '';
    ageController.text = '';
    genderController.text = '';
    showBottomModal(
        title: title,
        child: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Name', style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ),
              Customtextformfield(
                focusNode: focusNode1,
                controller: nameController,
                hintText: 'Enter Name',
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                // ],
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
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Age', style: titleTextStyle),
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                      text: type == 'Infant' ? '(Month)' : '(Year)',
                      style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ),
              Customtextformfield(
                focusNode: focusNode2,
                controller: ageController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                hintText: 'Enter Age',
                validator: (value) {
                  int age = int.tryParse(value ?? '')?.toInt() ?? 0;

                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  } else if (type == 'Adult') {
                    debugPrint('type of member1$type');
                    if (age < 18 || age >= 100) {
                      return 'Adult must be 18 years or older';
                    }
                  } else if (type == 'Child') {
                    debugPrint('type of member2$type');
                    if (age <= 2 || age >= 18) {
                      return 'Child must be between 2 and 18 years old';
                    }
                  } else if (type == 'Infant') {
                    debugPrint('type of member3$type');
                    if (age >= 24) {
                      return 'Infant must be under 24 months';
                    }
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Gender', style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ),
              CustomDropdownButton(
                controller: genderController,
                focusNode: focusNode3,
                itemsList: const ['Male', 'Female'],
                onChanged: (value) {
                  setState(() {
                    genderController.text = value ?? '';
                    debugPrint('validate gender ${genderController.text}');
                  });
                },
                hintText: 'Select Gender',
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please select gender';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
        btnHeading: 'ADD',
        onTap: () {
          if (_formKey.currentState!.validate()) {
            debugPrint('succes');
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
          } else {
            debugPrint('jhhjhjcgnxbcnbxcnxbcxjc');
          }
        });
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
    showBottomModal(
        title: title,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Name', style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ),
              Customtextformfield(
                focusNode: focusNode1,
                controller: nameController,
                hintText: 'Enter Name',
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                // ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Age', style: titleTextStyle),
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                      text: type == 'Infant' ? '(Month)' : '(Year)',
                      style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ),
              Customtextformfield(
                focusNode: focusNode2,
                controller: ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: 'Enter Age',
                validator: (value) {
                  int age = int.tryParse(value ?? '')?.toInt() ?? 0;

                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  } else if (type == 'Adult') {
                    debugPrint('type of member1$type');
                    if (age <= 18 || age >= 100) {
                      return 'Adult must be 18 Year or older';
                    }
                  } else if (type == 'Child') {
                    debugPrint('type of member2$type');
                    if (age >= 18) {
                      return 'Child must be under 18 Year';
                    }
                  } else if (type == 'Infant') {
                    debugPrint('type of member3$type');
                    if (age >= 24) {
                      return 'Infant must be under 24 Month';
                    }
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Gender', style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ),
              CustomDropdownButton(
                controller: genderController,
                focusNode: focusNode3,
                itemsList: const ['Male', 'Female'],
                onChanged: (value) {
                  setState(() {
                    genderController.text = value ?? '';
                  });
                },
                hintText: 'Select Gender',
                // validator: (p0) {
                //   if (p0 == null || p0.isEmpty) {
                //     return 'Please select gender';
                //   }
                //   return null;
                // },
              )
            ],
          ),
        ),
        btnHeading: "EDIT",
        onTap: () {
          if (_formKey.currentState!.validate()) {
            debugPrint('succes');
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
        });
  }

  double marqueeVelocity = 100.0; // Default scrolling speed
  bool visibleSecondaryContact = false;
  bool offerVisible = false;
  bool isHovering = false;
  double disCountPer = 0;
  double maxDisAmount = 0;
  String? offerCode;
  double discountAmount = 0;
  double disAmount = 0;
  double getPercentage() {
    double amt = (disCountPer / 100) * payAbleAmount;
    disAmount = amt > maxDisAmount ? maxDisAmount : amt;
    return payAbleAmount - disAmount.toInt();
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
        .watch<PaymentCreateOrderIdViewModel>()
        .paymentOrderID
        .status
        .toString();
    bool bookingStatus =
        context.watch<GetPackageBookingByIdViewModel>().isLoading;
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
    final marqueeController = MarqueerController();
    return Scaffold(
      backgroundColor: bgGreyColor,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        heading: "Package Booking",
      ),
      body: PageLayout_Page(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              SingleChildScrollView(
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
                                child: Marqueer(
                                  pps: 100,
                                  controller: marqueeController,
                                  direction: MarqueerDirection.rtl,
                                  restartAfterInteractionDuration:
                                      const Duration(seconds: 0),
                                  restartAfterInteraction: true,
                                  onChangeItemInViewPort: (index) {
                                    debugPrint('item index: $index');
                                  },
                                  onInteraction: () {
                                    debugPrint('on interaction callback');
                                  },
                                  onStarted: () {
                                    debugPrint('on started callback');
                                  },
                                  onStopped: () {
                                    debugPrint('on stopped callback');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                2),
                                    child: const Text(
                                      '*Children under 2 years old can be booked for free. and Certain activities are not recommended for senior citizens due to potential health risks.*',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: redColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Travel Date",
                                  overflow: TextOverflow.ellipsis,
                                  style: titleTextStyle,
                                ),
                              ),
                              CommonContainer(
                                width: AppDimension.getWidth(context) * .94,
                                // width: AppDimension.getWidth(context) / 1.4,
                                height: 45,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                                'Primary Contact',
                                style: titleTextStyle,
                              ),

                              const SizedBox(height: 5),

                              CustomMobilenumber(
                                  textLength: 9,
                                  readOnly: true,
                                  focusNode: focusNode4,
                                  fillColor: background,
                                  controller: primaryNoController,
                                  hintText: 'Enter number',
                                  suffixIcons: primaryNoController.text.isEmpty
                                      ? const SpinKitThreeBounce(
                                          size: 20,
                                          color: btnColor,
                                        )
                                      : null,
                                  countryCode: primaryCountryCode),
                              // Customphonefield(
                              //   poneKey: _phoneKey,
                              //   focusNode: focusNode4,
                              //   initalCountryCode: initialCountryCode,
                              //   controller: primaryNoController,
                              //   onChanged: (phoneNumber) {
                              //     primaryCountryCode = phoneNumber.countryCode
                              //         .replaceFirst("+", '')
                              //         .trim();
                              //     debugPrint('phone number$primaryCountryCode');
                              //     // primaryNoController.text = phoneNumber.number;
                              //   },
                              //   onCountryChanged: (country) {
                              //     primaryCountryCode = country.dialCode;
                              //   },
                              //   validator: (p0) {
                              //     return null;
                              //   },
                              // ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text('Secondary Contact ',
                                      textAlign: TextAlign.start,
                                      style: titleTextStyle),
                                  Text('(Optional)',
                                      textAlign: TextAlign.start,
                                      style: titleTextStyle1),
                                ],
                              ),
                              const SizedBox(height: 5),
                              CustomMobilenumber(
                                  textLength: 9,
                                  focusNode: focusNode5,
                                  fillColor: background,
                                  controller: secondaryNoController,
                                  hintText: 'Enter number',
                                  countryCode: secondaryCountryCode)
                              // Customphonefield(
                              //   focusNode: focusNode5,
                              //   initalCountryCode: 'AE',
                              //   controller: secondaryNoController,
                              //   onChanged: (phoneNumber) {
                              //     secondaryCountryCode = phoneNumber.countryCode
                              //         .replaceFirst("+", '')
                              //         .trim();
                              //     // secondaryNoController.text = phoneNumber.number;

                              //     debugPrint(
                              //         "${secondaryCountryCode} secondarycode....");
                              //     debugPrint(
                              //         "${secondaryNoController.text} secondaryNumber....");
                              //   },
                              //   onCountryChanged: (country) {
                              //     secondaryCountryCode = country.fullCountryCode;
                              //     debugPrint(
                              //         "${secondaryCountryCode} secondarycode....");
                              //   },
                              //   validator: (p0) async {
                              //     // String pattern = r'^\+?[0-9]{10,15}$';
                              //     // RegExp regex = RegExp(pattern);

                              //     // if (!regex.hasMatch(p0!.completeNumber)) {
                              //     //   return 'Please enter a valid phone number';
                              //     // }
                              //     return null;
                              //   },
                              // ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: background,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: naturalGreyColor.withOpacity(.3))),
                            child: Form(
                              key: _formCouponKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Customtextformfield(
                                          focusNode: couponFocus,
                                          controller: couponController,
                                          hintText: 'Coupon code',
                                          readOnly: offerVisible ? true : false,
                                          validator: (p0) {
                                            if (members.isEmpty) {
                                              return 'Please add members first';
                                            } else if (p0 == null ||
                                                p0.isEmpty) {
                                              return "Please enter offer coupon";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      offerVisible
                                          ? CustomButtonSmall(
                                              height: 45,
                                              width: 80,
                                              btnHeading: 'Remove',
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                // Optionally, unfocus specific fields
                                                couponFocus.unfocus();
                                                setState(() {
                                                  offerVisible = false;
                                                  discountAmount = 0;
                                                });
                                              },
                                            )
                                          : CustomButtonSmall(
                                              height: 45,
                                              width: 80,
                                              btnHeading: 'Apply',
                                              onTap: () {
                                                if (_formCouponKey.currentState!
                                                    .validate()) {
                                                  Provider.of<OfferViewModel>(
                                                          context,
                                                          listen: false)
                                                      .validateOffer(
                                                          context: context,
                                                          offerCode:
                                                              couponController
                                                                  .text,
                                                          bookingType:
                                                              'PACKAGE_BOOKING',
                                                          bookigAmount:
                                                              payAbleAmount
                                                                  .toInt())
                                                      .then((onValue) {
                                                    if (onValue?.status
                                                            ?.httpCode ==
                                                        '200') {
                                                      Utils.toastSuccessMessage(
                                                          onValue?.status
                                                                  ?.message ??
                                                              '');
                                                      offerCode = onValue
                                                          ?.data?.offerCode;
                                                      disCountPer = onValue
                                                              ?.data
                                                              ?.discountPercentage ??
                                                          0;
                                                      maxDisAmount = onValue
                                                              ?.data
                                                              ?.maxDiscountAmount ??
                                                          0;
                                                      setState(() {
                                                        offerVisible = true;
                                                        discountAmount =
                                                            getPercentage();
                                                        debugPrint(
                                                            'discountpercentage.....,..,.,$discountAmount');
                                                      });
                                                    } else {
                                                      setState(() {
                                                        discountAmount = 0;
                                                      });
                                                    }
                                                  });
                                                }
                                              },
                                            )
                                    ],
                                  ),
                                  offerVisible
                                      ? Text(
                                          'Congrats!  You have availed discount of AED ${disAmount.toInt()}.',
                                          style: TextStyle(color: greenColor),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Travellers Details',
                                style: TextStyle(
                                    color: btnColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();

                                    // Optionally, unfocus specific fields
                                    focusNode4.unfocus();
                                    focusNode5.unfocus();
                                    couponFocus.unfocus();
                                    _addMember(
                                        title: 'Add Adult Member',
                                        ageUnit: 'Year',
                                        type: 'Adult');
                                  },
                                  child: Material(
                                    elevation: 4,
                                    color: bgGreyColor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(color: btnColor)),
                                      padding: EdgeInsets.all(2),
                                      child: Image.asset(
                                        adultIcon,
                                        width: 24,
                                        height: 24,
                                        color: btnColor,
                                      ),
                                    ),
                                  )),
                              const SizedBox(width: 20),
                              InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();

                                    // Optionally, unfocus specific fields
                                    focusNode4.unfocus();
                                    focusNode5.unfocus();
                                    couponFocus.unfocus();
                                    _addMember(
                                        title: 'Add Child Member',
                                        ageUnit: 'Year',
                                        type: 'Child');
                                  },
                                  child: Material(
                                    elevation: 4,
                                    color: bgGreyColor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(color: btnColor)),
                                      padding: const EdgeInsets.all(2),
                                      child: Image.asset(
                                        childIcon,
                                        width: 26,
                                        height: 26,
                                        color: btnColor,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )),
                              const SizedBox(width: 20),

                              InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();

                                    // Optionally, unfocus specific fields
                                    focusNode4.unfocus();
                                    focusNode5.unfocus();
                                    couponFocus.unfocus();
                                    _addMember(
                                        title: 'Add Infant Member',
                                        ageUnit: 'Month',
                                        type: 'Infant');
                                  },
                                  child: Material(
                                    elevation: 4,
                                    color: bgGreyColor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          // boxShadow: [
                                          //   BoxShadow(offset: Offset(-2, 3))
                                          // ],
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(color: btnColor)),
                                      padding: const EdgeInsets.all(3),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            infantIcon,
                                            width: 24,
                                            height: 24,
                                            color: btnColor,
                                          ),
                                          const Positioned(
                                            right: -4,
                                            bottom: 0,
                                            child: Icon(
                                              Icons.add_circle_outline_sharp,
                                              color: btnColor,
                                              size: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              // Expanded(
                              //   child: CustomButtonSmall(
                              //     titleReq: false,
                              //     elevation: 0,
                              //     elevationReq: true,
                              //     buttonColor: btnColor,
                              //     borderRadius: BorderRadius.circular(5),
                              //     // width: AppDimension.getWidth(context) / 4.5,
                              //     btnHeading: "Add Adult",
                              //     disable: isAddAdultDisabled,
                              //     height: 40,
                              //     onTap: () {
                              //       FocusScope.of(context).unfocus();

                              //       // Optionally, unfocus specific fields
                              //       focusNode4.unfocus();
                              //       focusNode5.unfocus();
                              //       couponFocus.unfocus();
                              //       _addMember(
                              //           title: 'Add Adult Member',
                              //           ageUnit: 'Year',
                              //           type: 'Adult');

                              //       // _addAdultMember();
                              //       // setState(() {
                              //       //   type = 'Adult';
                              //       //   updateButtonStates();
                              //       // });
                              //     },
                              //   ),
                              // ),
                              // const SizedBox(width: 10),
                              // Expanded(
                              //   child: CustomButtonSmall(
                              //     titleReq: false,
                              //     elevation: 0,
                              //     elevationReq: true,
                              //     buttonColor: btnColor,
                              //     borderRadius: BorderRadius.circular(5),
                              //     // width: AppDimension.getWidth(context) / 4.5,
                              //     btnHeading: "Add Child",
                              //     height: 40,
                              //     disable: isAddChildDisabled,
                              //     onTap: () {
                              //       FocusScope.of(context).unfocus();

                              //       // Optionally, unfocus specific fields
                              //       focusNode4.unfocus();
                              //       focusNode5.unfocus();
                              //       couponFocus.unfocus();
                              //       _addMember(
                              //           title: 'Add Child Member',
                              //           ageUnit: 'Year',
                              //           type: 'Child');

                              //       // _addChildMember();
                              //       // setState(() {
                              //       //   type = 'Child';
                              //       //   updateButtonStates();
                              //       // });
                              //     },
                              //   ),
                              // ),
                              // const SizedBox(width: 10),
                              // Expanded(
                              //   child: CustomButtonSmall(
                              //     titleReq: false,
                              //     elevation: 0,
                              //     elevationReq: true,
                              //     buttonColor: btnColor,
                              //     borderRadius: BorderRadius.circular(5),
                              //     // width: AppDimension.getWidth(context) / 4,
                              //     btnHeading: "Add Infant",
                              //     height: 40,
                              //     disable: isAddInfentDisabled,
                              //     onTap: () {
                              //       FocusScope.of(context).unfocus();

                              //       // Optionally, unfocus specific fields
                              //       focusNode4.unfocus();
                              //       focusNode5.unfocus();
                              //       couponFocus.unfocus();
                              //       _addMember(
                              //           title: 'Add Infant Member',
                              //           ageUnit: 'Month',
                              //           type: 'Infant');

                              //       // _addInfantdMember();
                              //       // setState(() {
                              //       //   type = 'Infant';
                              //       //   updateButtonStates();
                              //       // });
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FixedColumnWidth(120),
                            1: FixedColumnWidth(50),
                            2: FlexColumnWidth(),
                            3: FlexColumnWidth(),
                            4: FlexColumnWidth()
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
                                        top: 10, bottom: 10, right: 5),
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
                                        left: 5, top: 10, bottom: 10),
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
                        members.isEmpty
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  'No Travellers Added',
                                  style: TextStyle(
                                      color: redColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            : Table(
                                border: const TableBorder(
                                  horizontalInside: BorderSide(
                                    width: 1, // Width of the row separator
                                    color: Colors
                                        .grey, // Color of the row separator
                                  ),
                                  top: BorderSide(
                                    width: 1,
                                    color: Colors
                                        .grey, // Bottom border of the table
                                  ),
                                ),

                                columnWidths: const {
                                  0: FixedColumnWidth(120),
                                  1: FixedColumnWidth(50),
                                  2: FlexColumnWidth(),
                                  3: FlexColumnWidth(),
                                  4: FlexColumnWidth()
                                },
                                // defaultColumnWidth: FixedColumnWidth(100),
                                children: members.map((member) {
                                  int index = members.indexOf(member);
                                  debugPrint('objectindex$index');
                                  return TableRow(
                                      // decoration:
                                      //     BoxDecoration(color: background),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              bottom: 10,
                                              top: 10,
                                              right: 10),
                                          child: Text(
                                            member['name']
                                                .toString()
                                                .capitalizeFirstOfEach,
                                            style: titleTextStyle1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            '${member['age']}',
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
                                              left: 5, top: 10, bottom: 10),
                                          child: Text(
                                            member['ageUnit'] == 'Month'
                                                ? 'Infant'
                                                : int.parse(member['age']) < 18
                                                    ? 'Child'
                                                    : int.parse(member['age']) <
                                                            60
                                                        ? 'Adult'
                                                        : 'Senior*',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    int.parse(member['age']) >=
                                                            60
                                                        ? redColor
                                                        : blackColor),
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
                                                      member['age'].toString());
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
                                                child: const Icon(Icons.delete,
                                                    color: redColor),
                                                onTap: () {
                                                  // setState(() {
                                                  //   members.removeAt(index);
                                                  //   // addAmount(members);
                                                  //   member['ageUnit']
                                                  //               .toString() ==
                                                  //           'Month'
                                                  //       ? null
                                                  //       : _subAmount();
                                                  //   tableIcon = false;
                                                  // });
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (context) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            background,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    top: 20,
                                                                    bottom: 5),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Are you sure you want to delete this traveler ?',
                                                                  // textAlign:
                                                                  //     TextAlign
                                                                  //         .center,
                                                                  style:
                                                                      titleTextStyle,
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                const Divider(
                                                                    height: 0),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    IconButton(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .zero,
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .pop();
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              redColor,
                                                                          size:
                                                                              24,
                                                                        )),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    IconButton(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .zero,
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            members.removeAt(index);
                                                                            // addAmount(members);
                                                                            member['ageUnit'].toString() == 'Month'
                                                                                ? null
                                                                                : _subAmount();
                                                                            tableIcon =
                                                                                false;
                                                                          });
                                                                          context
                                                                              .pop();
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              greenColor,
                                                                          size:
                                                                              30,
                                                                        ))
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]);
                                }).toList(),
                              ),
                      ],
                    ),
                    const SizedBox(height: 80)
                  ],
                ),
              ),
              bookingStatus
                  ? Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              size: 60,
                              color: btnColor,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Please wait.....',
                              style: TextStyle(color: greenColor),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    discountAmount == 0
                        ? "AED $payAbleAmount"
                        : "AED $discountAmount",
                    style: const TextStyle(
                        color: blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // const Flexible(
                //   child: Text('(Inclusive of taxes)',
                //       style: TextStyle(color: blackColor)),
                // ),

                InkWell(
                  onTap: _showPaymentDailog,
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        // decorationColor: greenColor,
                        fontWeight: FontWeight.w600,
                        color: greenColor),
                  ),
                )
              ],
            ),
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
                    Utils.toastMessage('Please add Members First');
                  } else if (controller[0].text.isEmpty) {
                    Utils.toastMessage('Please select date');
                    // Utils.flushBarErrorMessage("Please select date", context);
                  } else {
                    setState(() {
                      loader = true;
                    });
                    // ignore: unused_element
                    // void initiatePayment(BuildContext context) {
                    PaymentService paymentService = PaymentService(
                      context: context,
                      onPaymentError: (PaymentFailureResponse response) {
                        setState(() {
                          loader = false;
                          debugPrint(
                              'onpaymentfail status  ,,,,,,,,,,${response.message}${response.code}');
                        });
                      },
                      onPaymentSuccess: (PaymentSuccessResponse response) {
                        debugPrint('paymentResponse#${response.orderId}');
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
                              debugPrint(
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
                                        "userId": widget.userID.toString(),
                                        "packageId":
                                            widget.packageID.toString(),
                                        "bookingDate": controller[0].text,
                                        "transactionId":
                                            value?.data.transactionId,
                                        "countryCode": primaryCountryCode
                                            .replaceAll("+", '')
                                            .trim(),
                                        "mobile": primaryNoController.text,
                                        "alternateMobileCountryCode":
                                            secondaryCountryCode,
                                        "alternateMobile":
                                            secondaryNoController.text,
                                        "offerCode": offerCode,
                                        "discountAmount": disAmount.toInt(),
                                        "numberOfMembers":
                                            members.length.toString(),
                                        "memberList": members,
                                        "packagePrice": sumAmount,
                                        "taxAmount": taxAmount,
                                        "taxPercentage": taxPercentage,
                                        "totalPayableAmount":
                                            discountAmount == 0
                                                ? payAbleAmount
                                                : discountAmount
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
                        amount: sumAmount,
                        taxAmount: taxAmount,
                        taxPercentage: taxPercentage,
                        discountAmount: disAmount,
                        payableAmount: discountAmount == 0
                            ? payAbleAmount
                            : discountAmount,
                        userId: widget.userID.toString(),
                        coutryCode: profileUser?.countryCode,
                        mobileNo: profileUser?.mobile,
                        email: profileUser?.email);
                    // setState(() {
                    //   loader = false;
                    // });
                    // }

                    // Utils.flushBarSuccessMessage("Booking Success", context);
                  }
                }),
          ],
        ),
      ),
    );
  }

  void _showPaymentDailog() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: background,
        // isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setstate) {
            return SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Summary',
                        style: buttonText,
                      ),
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: Text(
                            'X',
                            textAlign: TextAlign.end,
                            style: buttonText,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Package Amount',
                        style: titleTextStyle,
                      ),
                      Text(
                        'AED $sumAmount',
                        style: titleTextStyle1,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax Amount (5 %)',
                        style: titleTextStyle,
                      ),
                      Text(
                        '+ AED $taxAmount',
                        style: titleTextStyle1,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save Amount',
                        style: titleTextStyle,
                      ),
                      Text(
                        discountAmount == 0
                            ? '- AED $discountAmount'
                            : '- AED $disAmount',
                        style: titleTextStyle1,
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payable Amount',
                        style: pageHeadingTextStyle,
                      ),
                      Column(
                        children: [
                          Text(
                            discountAmount == 0
                                ? 'AED $payAbleAmount'
                                : 'AED $discountAmount',
                            style: pageHeadingTextStyle,
                          ),
                          const Text('(Inclusive of Taxes)',
                              style: TextStyle(color: blackColor))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ));
          });
        });
  }
}
