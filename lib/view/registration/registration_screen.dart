// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/registration_view_model.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class registration_screen extends StatefulWidget {
  const registration_screen({super.key});

  @override
  State<registration_screen> createState() => _registration_screenState();
}

class _registration_screenState extends State<registration_screen> {
  List<TextEditingController> controller =
      List.generate(7, (index) => TextEditingController());
  bool load = false;
  String? countryCode;
  String? mobileNumber;

  @override
  Widget build(BuildContext context) {
    String status =
        context.watch<PostSignUpViewModel>().DataList.status.toString();
    return Scaffold(
        backgroundColor: bgGreyColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(child: Image.asset(appLogo1)),
                  const SizedBox(height: 30),
                  Text('Create Your Account.',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      // color: Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                  const SizedBox(height: 10),
                  LoginTextFeild(
                      headingReq: true,
                      heading: "First Name",
                      hint: "Enter your first name",
                      prefixIcon: true,
                      img: user,
                      controller: controller[0]),
                  const SizedBox(height: 10),
                  LoginTextFeild(
                      headingReq: true,
                      heading: "Last Name",
                      prefixIcon: true,
                      img: user,
                      hint: "Enter your last name",
                      controller: controller[1]),
                  const SizedBox(height: 10),

                  // LoginTextFeild(
                  //   headingReq: true,
                  //   heading: "Mobile No.",
                  //   controller: controller[2],
                  //   prefixIcon: true,
                  //   img: phone,
                  //   hint: "Enter your contact no.",
                  //   number: true,
                  // ),
                  // const SizedBox(height: 10),
                  // LoginTextFeild(
                  //     headingReq: true,
                  //     heading: "Address",
                  //     prefixIcon: true,
                  //     img: address,
                  //     hint: "Enter your address",
                  //     controller: controller[3]),
                  Text("Address",style: titleTextStyle),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    height: 50,
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: controller[3],
                      boxDecoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
                      googleAPIKey: "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
                      inputDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                        isDense: true,
                        hintText: "Search your location",
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: GoogleFonts.lato(
                          color: greyColor1,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: background,
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide.none),
                      ),
                      textStyle: titleTextStyle,
                      debounceTime: 400,
                      // countries: ["ae", "fr"],
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (prediction) {
                        print("Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
                        // You can use prediction.lat and prediction.lng here as needed
                        // Example: Save them to variables or perform further actions
                      },

                      itemClick: (prediction) {
                        controller[3].text = prediction.description ?? "";
                        controller[3].selection = TextSelection.fromPosition(
                            TextPosition(offset: prediction.description?.length ?? 0));
                      },
                      seperatedBuilder: const Divider(),

                      // OPTIONAL// If you want to customize list view item builder
                      itemBuilder: (context, index, prediction) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            color: background,
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,size: 15,),
                                const SizedBox(
                                  width: 7,
                                ),
                                Expanded(child: Text(prediction.description ?? "",style: titleTextStyle,))
                              ],
                            ),
                          ),
                        );
                      },
                      isCrossBtnShown: false,
                      // default 600 ms ,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FormCommonSingleAlertSelector(
                    title: "Gender",
                    controller: controller[4],
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
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                          content: "Mobile No",
                          textColor: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: AppDimension.getWidth(context)*.9,
                    child:IntlPhoneField(
                      style: titleTextStyle,
                      showCountryFlag: true,
                      dropdownTextStyle: titleTextStyle,
                      dropdownIconPosition: IconPosition.trailing,
                      dropdownDecoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ),
                      initialCountryCode: 'AE',
                      controller: controller[2],
                      pickerDialogStyle: PickerDialogStyle(
                        // searchFieldCursorColor: blackColor,
                        searchFieldInputDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            hintText: "Enter Country Code or Name",
                            // fillColor: background,
                            isDense: true,
                            hintStyle: titleTextStyle1,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: naturalGreyColor.withOpacity(0.3))
                            ),
                            labelStyle: titleTextStyle,
                            counterStyle: titleTextStyle,
                            suffixStyle: titleTextStyle
                        ),
                        countryCodeStyle: titleTextStyle,
                        countryNameStyle: titleTextStyle,
                        // backgroundColor: background,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: background,
                        helperStyle: titleTextStyle1,
                        errorStyle: GoogleFonts.lato(
                            color: redColor
                        ),
                        hintStyle: titleTextStyle,
                        isDense: true,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: naturalGreyColor.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: naturalGreyColor.withOpacity(0.3)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: naturalGreyColor.withOpacity(0.3)),
                          // borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 30),
                        suffixStyle: titleTextStyle1,
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: redColor
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: naturalGreyColor.withOpacity(0.3))
                        ),
                      ),
                      onChanged:(phone) {
                        countryCode = phone.countryCode;
                        mobileNumber = phone.number;
                        debugPrint("${phone.number}Phone Number");
                        debugPrint("${phone.countryCode}Phone Code");
                      },
                    ),
                  ),
                  // const SizedBox(height: 10),
                  LoginTextFeild(
                      headingReq: true,
                      heading: "Email",
                      img: email,
                      prefixIcon: true,
                      hint: "Enter your email",
                      controller: controller[5]),
                  const SizedBox(height: 10),
                  LoginTextFeild(
                      headingReq: true,
                      heading: "Password",
                      img: pass,
                      suffixIcon: true,
                      prefixIcon: true,
                      obscure: true,
                      hint: "Enter your password",
                      controller: controller[6]),
                  const SizedBox(height: 40),
                  CustomButtonBig(
                    btnHeading: "SIGN UP",
                    loading: status == "Status.loading" && load,
                    onTap: () {
                      load = true;
                      if (controller[0].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your first name", context);
                        // context.push("/")
                      } else if (controller[1].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your last name", context);
                      } else if (controller[2].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your contact no", context);
                      } else if (controller[3].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your address", context);
                      } else if (controller[4].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your gender", context);
                      } else if (controller[5].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your email", context);
                      } else if (controller[6].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Kindly enter your password", context);
                      } else if (controller[6].text.length <= 8) {
                        Utils.flushBarErrorMessage(
                            "Password should be more then 8 words", context);
                      } else {
                        Map<String, String> data = {
                          "firstName": controller[0].text,
                          "lastName": controller[1].text,
                          "countryCode" : countryCode.toString(),
                          "mobile": controller[2].text,
                          "address": controller[3].text,
                          "gender": controller[4].text,
                          "email": controller[5].text,
                          "password": controller[6].text,
                        };
                        Provider.of<PostSignUpViewModel>(context, listen: false)
                            .fetchPostSingUp(data, context);
                      }
                      context.push("/login");
                    },
                  ),
                  const SizedBox(height: 10),
                  Login_SignUpBtn(
                    onTap: () => context.push("/login"),
                    btnHeading: 'Login',
                    sideHeading: 'Already have an account?',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }
}
