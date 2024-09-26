// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Widgets/CustomTextFormfield.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_mobileNumber.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
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
      List.generate(8, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  GlobalKey _phoneFieldKey = GlobalKey();
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final addressFocus = FocusNode();
  final genderFocus = FocusNode();
  final phoneFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confPassFocus = FocusNode();

  bool load = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // String? countryCode;
  String countryCode = '971';

  String? mobileNumber;
  String? _emailValidation(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Enter valid email id';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _phoneFieldKey = GlobalKey();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller[0].dispose();
    controller[1].dispose();
    controller[2].dispose();
    controller[3].dispose();
    controller[4].dispose();
    controller[5].dispose();
    controller[6].dispose();
    controller[7].dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    addressFocus.dispose();
    genderFocus.dispose();
    phoneFocus.dispose();
    passwordFocus.dispose();
    confPassFocus.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    isLoading = context.watch<PostSignUpViewModel>().loading;
    return Scaffold(
        backgroundColor: bgGreyColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(child: Image.asset(appLogo1)),
                    const SizedBox(height: 30),
                    Text(
                      'Create Your Account.',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        // color: Color.fromRGBO(0, 0, 0, 0.5)
                      ),
                    ),
                    const SizedBox(height: 10),

                    lableText('First Name'),
                    Customtextformfield(
                      focusNode: firstNameFocus,
                      controller: controller[0],
                      fillColor: background,
                      hintText: 'Enter Your first Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    lableText('Last Name'),
                    Customtextformfield(
                      focusNode: lastNameFocus,
                      controller: controller[1],
                      fillColor: background,
                      hintText: 'Enter Your last name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    lableText('Email'),
                    Customtextformfield(
                        focusNode: emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller[2],
                        fillColor: background,
                        hintText: 'xyz@gmail.com',
                        validator: _emailValidation),
                    const SizedBox(height: 10),
                    // LoginTextFeild(
                    //   headingReq: true,
                    //   heading: "Last Name",
                    //   prefixIcon: false,
                    //   img: user,
                    //   hint: "Enter your last name",
                    //   controller: controller[1],
                    //   validator: (p0) {
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(height: 10),

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

                    Text.rich(TextSpan(children: [
                      TextSpan(text: 'Address', style: titleTextStyle),
                      const TextSpan(
                          text: ' *', style: TextStyle(color: redColor))
                    ])),
                    const SizedBox(height: 5),
                    FormField<String>(validator: (value) {
                      if (controller[3].text.isEmpty) {
                        return '  Please select a location';
                      }
                      return null;
                    }, builder: (FormFieldState<String> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            height: 50,
                            child: GooglePlaceAutoCompleteTextField(
                              focusNode: addressFocus,
                              textEditingController: controller[3],
                              boxDecoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          naturalGreyColor.withOpacity(0.3))),
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
                                controller[3].text =
                                    prediction.description ?? "";
                                controller[3].selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            prediction.description?.length ??
                                                0));
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
                      // icon: genderImg,
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
                            content: "Contact",
                            textColor: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        Text(
                          ' *',
                          style: TextStyle(color: redColor),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    CustomMobilenumber(
                        controller: controller[5],
                        fillColor: background,
                        textLength: 9,
                        hintText: 'Enter phone number',
                        countryCode: countryCode),
                    SizedBox(height: 10),
                    // SizedBox(
                    //   width: AppDimension.getWidth(context) * .9,
                    //   child: IntlPhoneField(
                    //     focusNode: phoneFocus,
                    //     key: _phoneFieldKey,
                    //     flagsButtonPadding: EdgeInsets.only(left: 10),
                    //     style: titleTextStyle,
                    //     showCountryFlag: true,
                    //     dropdownTextStyle: titleTextStyle,
                    //     dropdownIconPosition: IconPosition.trailing,
                    //     dropdownDecoration: const BoxDecoration(
                    //         borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(5),
                    //             bottomLeft: Radius.circular(5))),
                    //     initialCountryCode: 'AE',
                    //     controller: controller[5],
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
                    //                   color:
                    //                       naturalGreyColor.withOpacity(0.3))),
                    //           labelStyle: titleTextStyle,
                    //           counterStyle: titleTextStyle,
                    //           suffixStyle: titleTextStyle),
                    //       countryCodeStyle: titleTextStyle,
                    //       countryNameStyle: titleTextStyle,
                    //       // backgroundColor: background,
                    //     ),
                    //     decoration: InputDecoration(
                    //       hintText: 'Enter Your Number',
                    //       filled: true,
                    //       fillColor: background,
                    //       helperStyle: titleTextStyle1,
                    //       errorStyle: GoogleFonts.lato(color: redColor),
                    //       hintStyle: textTitleHint,
                    //       isDense: true,
                    //       errorBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: naturalGreyColor.withOpacity(0.3)),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: naturalGreyColor.withOpacity(0.3)),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //             color: naturalGreyColor.withOpacity(0.3)),
                    //         // borderSide: BorderSide.none,
                    //       ),
                    //       contentPadding: const EdgeInsets.only(bottom: 30),
                    //       suffixStyle: titleTextStyle1,
                    //       focusedErrorBorder: const OutlineInputBorder(
                    //           borderSide: BorderSide(color: redColor)),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //               color: naturalGreyColor.withOpacity(0.3))),
                    //     ),
                    //     validator: (value) async {
                    //       print('phone number validation $value');
                    //       if (value == null || value.number.isEmpty) {
                    //         return 'Enter your Number';
                    //       }
                    //       return null;
                    //     },
                    //     onChanged: (phone) {
                    //       countryCode = phone.countryCode;
                    //       mobileNumber = phone.number;
                    //       debugPrint("${phone.number}Phone Number");
                    //       debugPrint("${phone.countryCode}Phone Code");
                    //     },
                    //   ),
                    // ),

                    // const SizedBox(height: 10),
                    // LoginTextFeild(
                    //   headingReq: true,
                    //   heading: "Email",
                    //   img: email,
                    //   prefixIcon: false,
                    //   hint: "Enter your email",
                    //   controller: controller[5],
                    //   validator: (p0) {
                    //     Validation().isEmailField(p0 ?? '');
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(height: 10),

                    lableText('Password'),
                    Customtextformfield(
                      focusNode: passwordFocus,
                      obscureText: obscurePassword,
                      controller: controller[6],
                      fillColor: background,
                      hintText: 'Enter Your Password',
                      suffixIcons: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    lableText('Confirm Password'),
                    Customtextformfield(
                      focusNode: confPassFocus,
                      obscureText: obscureConfirmPassword,
                      controller: controller[7],
                      fillColor: background,
                      suffixIcons: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                      hintText: 'Enter Your Confirm Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your confirm password';
                        } else if (value != controller[6].text) {
                          return 'password do not match';
                        }
                        return null;
                      },
                    ),

                    // LoginTextFeild(
                    //   headingReq: true,
                    //   heading: "Password",
                    //   img: pass,
                    //   suffixIcon: true,
                    //   prefixIcon: false,
                    //   obscure: true,
                    //   hint: "Enter your password",
                    //   controller: controller[6],
                    //   validator: (p0) {
                    //     return null;
                    //   },
                    // ),
                    // LoginTextFeild(
                    //   headingReq: true,
                    //   heading: "Confirm Password",
                    //   img: pass,
                    //   suffixIcon: true,
                    //   prefixIcon: false,
                    //   obscure: true,
                    //   hint: "Enter your password",
                    //   controller: controller[7],
                    //   validator: (p0) {
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 40),
                    CustomButtonBig(
                      btnHeading: "SIGN UP",
                      loading: isLoading,
                      onTap: () {
                        setState(() {
                          load = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            load = true;
                          });
                          Map<String, String> body = {
                            "firstName": controller[0].text,
                            "lastName": controller[1].text,
                            "countryCode": countryCode.toString(),
                            "mobile": controller[5].text,
                            "address": controller[3].text,
                            "gender": controller[4].text,
                            "email": controller[2].text,
                            "password": controller[6].text,
                          };
                          Provider.of<PostSignUpViewModel>(context,
                                  listen: false)
                              .fetchPostSingUp(context: context, body: body)
                              .then((value) {
                            setState(() {
                              load = false;
                            });
                          });
                        } else {
                          setState(() {
                            load = false;
                          });
                        }
                        // if (controller[0].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your first name", context);
                        //   // context.push("/")
                        // } else if (controller[1].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your last name", context);
                        // } else if (controller[2].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your contact no", context);
                        // } else if (controller[3].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your address", context);
                        // } else if (controller[4].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your gender", context);
                        // } else if (controller[5].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your email", context);
                        // } else if (controller[6].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your password", context);
                        // } else if (controller[6].text.length <= 8) {
                        //   Utils.flushBarErrorMessage(
                        //       "Password should be more then 8 words", context);
                        // } else if (controller[7].text.isEmpty) {
                        //   Utils.flushBarErrorMessage(
                        //       "Kindly enter your confirm password", context);
                        // } else if (controller[7].text != controller[6].text) {
                        //   Utils.flushBarErrorMessage(
                        //       "Password is not match", context);
                        // } else {
                        //   load = true;
                        //   Map<String, String> data = {
                        //     "firstName": controller[0].text,
                        //     "lastName": controller[1].text,
                        //     "countryCode": countryCode.toString(),
                        //     "mobile": controller[2].text,
                        //     "address": controller[3].text,
                        //     "gender": controller[4].text,
                        //     "email": controller[5].text,
                        //     "password": controller[6].text,
                        //   };
                        //   Provider.of<PostSignUpViewModel>(context,
                        //           listen: false)
                        //       .fetchPostSingUp(data, context);
                        //   context.push("/login");
                        // }
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
          ),
        ));
  }

  lableText(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text.rich(TextSpan(children: [
        TextSpan(text: title, style: titleTextStyle),
        TextSpan(text: ' *', style: TextStyle(color: redColor))
      ])),
    );
  }
}
