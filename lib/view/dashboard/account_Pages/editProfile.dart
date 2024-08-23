import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
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

    String? cuntryCode;
    String? mobileNumber;

  @override
  void initState() {
    // TODO: implement initState
    // fetchUserData();
    super.initState();
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     controllers[0].text = userData.firstName;
     controllers[1].text = userData.lastName;
     controllers[2].text = userData.address;
     controllers[3].text = userData.gender;
     controllers[4].text = userData.mobile;
     controllers[5].text = userData.countryCode;
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
          child: Column(
            children: [
              LoginTextFeild(
                heading: "First Name",
                headingReq: true,
                controller: controllers[0],
                hint: "First Name",
                prefixIcon: true,
                img: profile,
              ),
              const SizedBox(height: 10),
              LoginTextFeild(
                heading: "Last Name",
                headingReq: true,
                controller: controllers[1],
                prefixIcon: true,
                hint: "Last Name",
                img: profile,
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Address", style: titleTextStyle),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: controllers[2],
                      boxDecoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
                      googleAPIKey: "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
                      inputDecoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 5),
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
                      },
                      itemClick: (prediction) {
                        controllers[2].text = prediction.description ?? "";
                        controllers[2].selection = TextSelection.fromPosition(
                            TextPosition(offset: prediction.description?.length ?? 0));
                      },
                      seperatedBuilder: const Divider(),

                      // OPTIONAL// If you want to customize list view item builder
                      itemBuilder: (context, index, prediction) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          // color: background,
                          child: Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(child: Text(prediction.description ?? ""))
                            ],
                          ),
                        );
                      },
                      isCrossBtnShown: false,
                      // default 600 ms ,
                    ),

                  ),
                ],
              ),
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
                elevation: 0,
                title: "Gender",
                controller: controllers[3],
                showIcon: const Icon(Icons.event_seat,color: naturalGreyColor,),
                iconReq: false,
                data: const ["Male","Female"],
                // icons: gender,
                icon: genderImg,
                ///Hint Color
                initialValue: "Select Gender",
                alertBoxTitle: "Select Gender",
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      content: "Mobile",
                        textColor: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
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
                  controller: controllers[4],
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
                    cuntryCode = phone.countryCode;
                    mobileNumber = phone.number;
                    debugPrint("${phone.number}Phone Number");
                    debugPrint("${phone.countryCode}Phone Code");
                  },
                ),
              ),
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
                  btnHeading: "Save",
                  // loading: status == "Status.loading" && load,
                  onTap: () {
                    // load = true;

                    Map<String, dynamic> data = {
                      "userId": widget.usrId.toString(),
                      "firstName": controllers[0].text,
                      "lastName": controllers[1].text,
                      "address": controllers[2].text,
                      "gender": controllers[3].text,
                      "countryCode" : cuntryCode,
                      "mobile": controllers[4].text
                    };

                    setState(() {
                      debugPrint(data.toString());
                      debugPrint(cuntryCode);
                      debugPrint(mobileNumber);
                      debugPrint(data.toString());
                      debugPrint(widget.usrId.toString());
                    });
                    Provider.of<UserProfileUpdateViewModel>(context,
                            listen: false)
                        .fetchUserProfileUpdateViewModelApi(
                            context, data, widget.usrId);
                  }),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}
