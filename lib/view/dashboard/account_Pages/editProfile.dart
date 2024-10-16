import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_mobileNumber.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditProfiePage extends StatefulWidget {
  final String usrId;

  const EditProfiePage({super.key, required this.usrId});

  @override
  State<EditProfiePage> createState() => _EditProfiePageState();
}

class _EditProfiePageState extends State<EditProfiePage> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  GlobalKey _phoneFieldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  // String? cuntryCode;
  // String? cuntryCodeISO;
  String countryCode1 = 'AE';
  // String? mobileNumber;

  @override
  void initState() {
    // TODO: implement initState
    // fetchUserData();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        controllers[0].text = userData?.firstName ?? '';
        controllers[1].text = userData.lastName;
        controllers[2].text = userData.address;
        controllers[3].text = userData.gender;
        controllers[4].text = userData.countryCode;
        controllers[5].text = userData.mobile;
        var list = countries
            .where((code) =>
                code.dialCode == controllers[4].text.replaceAll('+', '').trim())
            .toList();
        if (list.isNotEmpty) {
          // controllers[4].text = list.first.dialCode;
          countryCode1 = list.first.code;
          print('isocode.................... ${list.first.code}');
        }
        // cuntryCode = userData.countryCode;
        // print('countrycode$cuntryCode');
        // countryCode = getIsoCodeFromCountryCode(cuntryCode ?? 'AE');
        // print('countryucode...$countryCode');
        _phoneFieldKey = GlobalKey();
      });
    });
  }

  // Future<void> fetchUserData() async {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<UserProfileViewModel>(context, listen: false)
  //         .fetchUserProfileViewModelApi(context, {}, widget.usrId);
  //   });
  // }
  bool load = false;
  var userData;
  @override
  Widget build(BuildContext context) {
    userData = context.watch<UserProfileViewModel>().DataList.data?.data ?? '';
    print(userData.toString());
    debugPrint(widget.usrId.toString());
    return Scaffold(
      backgroundColor: bgGreyColor,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        heading: "Edit Profile",
      ),
      body: PageLayout_Page(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: 'First Name', style: titleTextStyle),
              const TextSpan(text: ' *', style: TextStyle(color: redColor))
            ])),
            const SizedBox(height: 5),
            Customtextformfield(
              focusNode: focusNode1,
              controller: controllers[0],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
              ],
              prefixiconvisible: true,
              fillColor: background,
              img: user,
              hintText: 'First Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),

            Text.rich(TextSpan(children: [
              TextSpan(text: 'Last Name', style: titleTextStyle),
              const TextSpan(text: ' *', style: TextStyle(color: redColor))
            ])),
            const SizedBox(height: 5),

            Customtextformfield(
              focusNode: focusNode2,
              controller: controllers[1],
              prefixiconvisible: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
              ],
              fillColor: background,
              img: user,
              hintText: 'Last Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter last name';
                }
                return null;
              },
            ),
            // LoginTextFeild(
            //   heading: "First Name",
            //   headingReq: true,
            //   controller: controllers[0],
            //   hint: "First Name",
            //   prefixIcon: true,
            //   img: profile,
            //   validator: (p0) {
            //     if (p0 == null || p0.isEmpty) {
            //       'Please enter first name';
            //     }
            //     return null;
            //   },
            // ),
            // const SizedBox(height: 10),
            // LoginTextFeild(
            //   heading: "Last Name",
            //   headingReq: true,
            //   controller: controllers[1],
            //   prefixIcon: true,
            //   hint: "Last Name",
            //   img: profile,
            //   validator: (p0) {
            //     if (p0 == null || p0.isEmpty) {
            //       'Please enter last name';
            //     }
            //     return null;
            //   },
            // ),
            const SizedBox(height: 10),

            Text.rich(TextSpan(children: [
              TextSpan(text: 'Address', style: titleTextStyle),
              const TextSpan(text: ' *', style: TextStyle(color: redColor))
            ])),
            const SizedBox(height: 5),
            FormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (controllers[2].text.isEmpty) {
                    return '  Please select location';
                  }
                  return null;
                },
                builder: (FormFieldState<String> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        height: 50,
                        child: GooglePlaceAutoCompleteTextField(
                          focusNode: focusNode3,
                          textEditingController: controllers[2],
                          boxDecoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: naturalGreyColor.withOpacity(0.3))),
                          googleAPIKey:
                              "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
                          inputDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            isDense: true,
                            hintText: "Search your location",
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintStyle: textTitleHint,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                location,
                                width: 10,
                                height: 10,
                              ),
                            ),
                            filled: true,
                            fillColor: background,
                            disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide.none),
                          ),
                          textStyle: titleTextStyle,
                          debounceTime: 400,
                          // countries: ["ae", "fr"],
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (prediction) {
                            print(
                                "Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
                            // You can use prediction.lat and prediction.lng here as needed
                            // Example: Save them to variables or perform further actions
                          },

                          itemClick: (prediction) {
                            controllers[2].text = prediction.description ?? "";
                            controllers[2].selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset:
                                        prediction.description?.length ?? 0));
                            field.didChange(prediction.description);
                          },
                          seperatedBuilder: const Divider(),

                          // OPTIONAL// If you want to customize list view item builder
                          itemBuilder: (context, index, prediction) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Container(
                                // color: background,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child: Text(
                                      prediction.description ?? "",
                                      style: titleTextStyle,
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                          isCrossBtnShown: false,

                          // default 600 ms ,
                        ),
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: TextStyle(color: redColor),
                        ),
                    ],
                  );
                }),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         child: Text.rich(TextSpan(children: [
            //           TextSpan(text: 'Address', style: titleTextStyle),
            //           TextSpan(text: ' *', style: TextStyle(color: redColor))
            //         ]))
            //         // child: Text("Address", style: titleTextStyle),
            //         ),
            //     const SizedBox(height: 5),
            //     Container(
            //       padding: const EdgeInsets.symmetric(horizontal: 0),
            //       height: 50,
            //       child: GooglePlaceAutoCompleteTextField(
            //         textEditingController: controllers[2],
            //         containerHorizontalPadding: 10,
            //         boxDecoration: BoxDecoration(
            //             color: background,
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(
            //                 color: naturalGreyColor.withOpacity(0.3))),
            //         googleAPIKey: "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
            //         inputDecoration: InputDecoration(
            //           isDense: true,
            //           prefixIconConstraints: const BoxConstraints(maxWidth: 50),
            //           prefixIcon: const Icon(
            //             Icons.location_on,
            //             size: 24,
            //           ),
            //           contentPadding: const EdgeInsets.symmetric(
            //               vertical: 0, horizontal: 5),
            //           hintText: "Search your location",
            //           border:
            //               const OutlineInputBorder(borderSide: BorderSide.none),
            //           hintStyle: GoogleFonts.lato(
            //             color: greyColor1,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //           ),
            //           filled: true,
            //           fillColor: background,
            //           disabledBorder: const OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(5)),
            //               borderSide: BorderSide.none),
            //         ),
            //         textStyle: titleTextStyle,
            //         debounceTime: 400,
            //         // countries: ["ae", "fr"],
            //         isLatLngRequired: true,
            //         getPlaceDetailWithLatLng: (prediction) {
            //           print(
            //               "Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
            //         },
            //         itemClick: (prediction) {
            //           controllers[2].text = prediction.description ?? "";
            //           controllers[2].selection = TextSelection.fromPosition(
            //               TextPosition(
            //                   offset: prediction.description?.length ?? 0));
            //         },
            //         seperatedBuilder: const Divider(),

            //         // OPTIONAL// If you want to customize list view item builder
            //         itemBuilder: (context, index, prediction) {
            //           return Container(
            //             padding: const EdgeInsets.only(bottom: 10, top: 10),
            //             // color: background,
            //             child: Row(
            //               children: [
            //                 const Icon(Icons.location_on),
            //                 const SizedBox(
            //                   width: 7,
            //                 ),
            //                 Expanded(child: Text(prediction.description ?? ""))
            //               ],
            //             ),
            //           );
            //         },
            //         isCrossBtnShown: false,
            //         // default 600 ms ,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10),
            //         child: Text.rich(TextSpan(children: [
            //           TextSpan(text: 'Gender', style: titleTextStyle),
            //           const TextSpan(
            //               text: ' *', style: TextStyle(color: redColor))
            //         ]))),
            //   ],
            // ),

            // LoginTextFeild(
            //   heading: "Address",
            //   headingReq: true,
            //   controller: controllers[2],
            //   hint: "Address",
            //   prefixIcon: true,
            //   img: address,
            // ),
            const SizedBox(height: 10),

            FormCommonSingleAlertSelector(
              width: double.infinity,
              elevation: 0,
              title: "Gender",
              controller: controllers[3],
              showIcon: const Icon(
                Icons.event_seat,
                color: naturalGreyColor,
              ),
              iconReq: false,
              data: const ["Male", "Female"],
              // icons: gender,
              icon: genderImg,

              ///Hint Color
              initialValue: "Select Gender",
              alertBoxTitle: "Select Gender",
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(text: 'Contact No', style: titleTextStyle),
                  const TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
              ],
            ),
            const SizedBox(height: 5),
            CustomMobilenumber(
                // width: AppDimension.getWidth(context) * .9,
                fillColor: background,
                textLength: 9,
                keyboardType: TextInputType.phone,
                countryCode: controllers[4].text,
                controller: controllers[5],
                hintText: 'Enter Mobile Number'),

            // const SizedBox(height: 10),
            // SizedBox(
            //   width: AppDimension.getWidth(context) * .9,
            //   child: IntlPhoneField(
            //     key: _phoneFieldKey,
            //     style: titleTextStyle,
            //     showCountryFlag: true,
            //     dropdownTextStyle: titleTextStyle,
            //     dropdownIconPosition: IconPosition.trailing,
            //     dropdownDecoration: const BoxDecoration(
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(5),
            //             bottomLeft: Radius.circular(5))),
            //     initialCountryCode: countryCode1,
            //     controller: controllers[5],
            //     pickerDialogStyle: PickerDialogStyle(
            //       // searchFieldCursorColor: blackColor,
            //       searchFieldInputDecoration: InputDecoration(
            //           contentPadding: const EdgeInsets.symmetric(
            //               vertical: 10, horizontal: 10),
            //           hintText: "Enter Country Code or Name",
            //           // fillColor: background,
            //           isDense: true,
            //           hintStyle: titleTextStyle1,
            //           focusedBorder: UnderlineInputBorder(
            //               borderSide: BorderSide(
            //                   color: naturalGreyColor.withOpacity(0.3))),
            //           labelStyle: titleTextStyle,
            //           counterStyle: titleTextStyle,
            //           suffixStyle: titleTextStyle),
            //       countryCodeStyle: titleTextStyle,
            //       countryNameStyle: titleTextStyle,
            //       // backgroundColor: background,
            //     ),
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: background,
            //       helperStyle: titleTextStyle1,
            //       errorStyle: GoogleFonts.lato(color: redColor),
            //       hintStyle: titleTextStyle,
            //       isDense: true,
            //       errorBorder: OutlineInputBorder(
            //         borderSide:
            //             BorderSide(color: naturalGreyColor.withOpacity(0.3)),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide:
            //             BorderSide(color: naturalGreyColor.withOpacity(0.3)),
            //       ),
            //       border: OutlineInputBorder(
            //         borderSide:
            //             BorderSide(color: naturalGreyColor.withOpacity(0.3)),
            //         // borderSide: BorderSide.none,
            //       ),
            //       contentPadding: const EdgeInsets.only(bottom: 30),
            //       suffixStyle: titleTextStyle1,
            //       focusedErrorBorder: const OutlineInputBorder(
            //           borderSide: BorderSide(color: redColor)),
            //       enabledBorder: OutlineInputBorder(
            //           borderSide:
            //               BorderSide(color: naturalGreyColor.withOpacity(0.3))),
            //     ),
            //     onChanged: (phone) {
            //       setState(() {
            //         controllers[4].text =
            //             phone.countryCode.replaceFirst('+', '').trim();
            //         controllers[5].text = phone.number;
            //         // mobileNumber = phone.number;
            //         debugPrint("${phone.number}Phone Number");
            //         debugPrint("${controllers[4].text}Phone Code..........");
            //       });
            //     },
            //     onCountryChanged: (value) {
            //       setState(() {
            //         controllers[4].text = value.fullCountryCode;
            //         debugPrint("${controllers[4].text} Code......mnbmn....");
            //       });
            //     },
            //     validator: (p0) {
            //       return null;
            //     },
            //   ),
            // ),

            ////////////////////////////////////////////////////////
            // LoginTextFeild(
            //   heading: "Mobile",
            //   headingReq: true,
            //   controller: controllers[4],
            //   hint: "Mobile",
            //   number: true,
            //   prefixIcon: true,
            //   img: phone,
            // ),
            const Spacer(),
            CustomButtonBig(
                btnHeading: "UPDATE",
                // loading: status == "Status.loading" && load,
                onTap: () {
                  // load = true;
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> data = {
                      "userId": widget.usrId.toString(),
                      "firstName": controllers[0].text,
                      "lastName": controllers[1].text,
                      "address": controllers[2].text,
                      "gender": controllers[3].text,
                      "countryCode": controllers[4].text,
                      "mobile": controllers[5].text
                    };
                    print('edit data.........$data');
                    setState(() {
                      debugPrint(data.toString());
                      debugPrint(data.toString());
                      debugPrint(widget.usrId.toString());
                    });
                    Provider.of<UserProfileUpdateViewModel>(context,
                            listen: false)
                        .fetchUserProfileUpdateViewModelApi(
                            context, data, widget.usrId);
                  }
                }),
            const SizedBox(height: 10),
          ],
        ),
      )),
    );
  }
}
