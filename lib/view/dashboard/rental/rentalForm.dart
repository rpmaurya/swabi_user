import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/customdropdown_button.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_dropDown.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_cab/model/rentalBooking_model.dart';
import 'package:flutter_cab/res/Common%20Widgets/common_alertTextfeild.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/custom_datePicker/common_textfield.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/rental_view_model.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';

class RentalForm extends StatefulWidget {
  final String userId;

  const RentalForm({super.key, required this.userId});

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> with RouteAware {
  final pickuplocationController = TextEditingController();
  final pickupdateController = TextEditingController();
  final seatController = TextEditingController();
  final rentalController = TextEditingController();
  String selectHour = '';
  String selectMin = '';

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
  List<String> mins = ['00', '15', '30', '45'];
  List<String> hours = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
  ];
  String apiKey = 'AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo';
  String sourceLocation = "Source Location";
  String? logitude1;
  String? latitude1;
  // double logitude1 = 0.0;
  // double latitude1 = 0.0;
  double logi = 0.0;
  double lati = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetRentalRangeListViewModel>(context, listen: false)
          .fetchGetRentalRangeListViewModelApi(context, {});
    });
    // controllers[0].addListener(() {
    //   onChange();
    // });
  }

  @override
  void didPopNext() {
    // Reset the time when coming back to this page
  }

  bool onTap = false;
  String? selectValue;
  String? vehicle;
  String? vehicleStatus;
  List<GetRentalRangeListDatum> rangeData = [];

  @override
  Widget build(BuildContext context) {
    vehicleStatus = context.watch<RentalViewModel>().DataList.status.toString();
    rangeData = context
            .watch<GetRentalRangeListViewModel>()
            .getRentalRangeList
            .data
            ?.data ??
        [];
    String status = context.watch<RentalViewModel>().DataList.status.toString();
    return Scaffold(
      backgroundColor: bgGreyColor,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        heading: "Rental Vehicle",
      ),
      body: PageLayout_Page(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: 'Pickup Location', style: titleTextStyle),
                  TextSpan(text: ' *', style: TextStyle(color: redColor))
                ])),
                // child: Text("Pickup Location", style: titleTextStyle),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: pickuplocationController,
                  boxDecoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: naturalGreyColor.withOpacity(0.3))),
                  googleAPIKey: "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
                  inputDecoration: InputDecoration(
                    isDense: true,
                    helperStyle: titleTextStyle,
                    prefixStyle: titleTextStyle,
                    counterStyle: titleTextStyle,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    hintText: "Search your location",
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: GoogleFonts.lato(
                      color: greyColor1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    filled: true,
                    labelStyle: titleTextStyle,
                    fillColor: background,
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide.none),
                  ),
                  textStyle: titleTextStyle,
                  debounceTime: 400,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (prediction) {
                    print(
                        "Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
                    setState(() {
                      lati = double.parse(prediction.lat ?? '0.0');
                      logi = double.parse(prediction.lng ?? '0.0');
                    });
                    // logitude = prediction.lng.toString();
                    // latitude = prediction.lat.toString();
                    // You can use prediction.lat and prediction.lng here as needed
                    // Example: Save them to variables or perform further actions
                  },
                  itemClick: (prediction) {
                    pickuplocationController.text =
                        prediction.description ?? "";
                    pickuplocationController.selection =
                        TextSelection.fromPosition(TextPosition(
                            offset: prediction.description?.length ?? 0));
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
          const SizedBox(height: 10),
          FormDatePickerExpense(
            title: "Pickup Date",
            controller: pickupdateController,
            hint: "PickUp Date",
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: 'Pickup Time', style: titleTextStyle),
                TextSpan(text: ' *', style: TextStyle(color: redColor))
              ])),
            ),
          ),
          const SizedBox(height: 5),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CustomDropdownButton(
                      itemsList: hours,
                      onChanged: (p0) {
                        setState(() {
                          selectHour = p0;
                        });
                      },
                      hintText: 'Select Hours'),
                ),
              ),
              const Text(
                ':',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CustomDropdownButton(
                    itemsList: mins,
                    onChanged: (p0) {
                      setState(() {
                        selectMin = p0;
                      });
                    },
                    hintText: 'Select Mins',
                  ),
                ),
              )
            ],
          ),
          // TimePickerDropdown(
          //   hrcontroller: controllers[2],
          //   mincontroller: controllers[3],
          // ),
          const SizedBox(height: 10),
          FormCommonSingleAlertSelector(
            title: "Select Seats",
            elevation: 0,
            controller: seatController,
            showIcon: const Icon(
              Icons.event_seat,
              color: naturalGreyColor,
            ),
            iconReq: true,
            data: items,
            border: true,

            ///Hint Color
            initialValue: "Select Seats",
            alertBoxTitle: "Select Seats",
          ),

          // TextFeildTiming(
          //     width: AppDimension.getWidth(context) * .9,
          //     title: "Time",
          //     hint: "PickUp Time",
          //     controller: controllers[2]),
          const SizedBox(height: 10),
          FormCommonSingleAlertSelector(
            title: "Select Rental Package",
            elevation: 0,
            controller: rentalController,
            showIcon: const Icon(
              Icons.add_road,
              color: naturalGreyColor,
            ),
            iconReq: true,
            data: List.generate(
                rangeData.length,
                (index) =>
                    "${rangeData[index].hours} Hr ${rangeData[index].kilometer} Km"),

            ///Hint Color
            initialValue: "Select Rental package",
            alertBoxTitle: "Select Rental package",
            border: true,
          ),

          const Spacer(),
          CustomButtonBig(
            widht: AppDimension.getWidth(context) * .9,
            btnHeading: "SEARCH",
            // loading: _rentalViewModel.loading,
            loading: status == "Status.loading" && onTap,
            onTap: () {
              /////API Calling
              if (pickuplocationController.text.isEmpty) {
                Utils.flushBarErrorMessage(
                    "Please select your pickup point", context);
              } else if (pickupdateController.text.isEmpty ||
                  pickupdateController.text == "0") {
                Utils.flushBarErrorMessage(
                    "Please select pickup date", context);
              } else if (selectHour.isEmpty || selectHour == "00") {
                Utils.flushBarErrorMessage("Please select hour", context);
              } else if (selectMin.isEmpty) {
                Utils.flushBarErrorMessage("Please select min", context);
              } else if (seatController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please select your seats", context);
              } else if (rentalController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please select your range", context);
              } else {
                // String pickupTime = controllers[2].text;
                // if (pickupTime.length < 5) {
                //   pickupTime = '0$pickupTime';
                // }
                onTap = true;
                // print(pickupTime);
                Provider.of<RentalViewModel>(context, listen: false)
                    .fetchRentalViewModelApi(
                        context,
                        {
                          "date": pickupdateController.text,
                          "pickupTime": '${selectHour}:${selectMin}',
                          "seat": seatController.text,
                          "hours": rentalController.text.split(' ')[0],
                          "kilometers": rentalController.text.split(' ')[2],
                          "pickUpLocation": pickuplocationController.text,
                          "latitude": lati.toString(),
                          "longitude": logi.toString(),
                        },
                        widget.userId,
                        logi,
                        lati);
                print("${status}Status Hai Ye");
                // if(status == "Status.completed"){
                // context.push('/rentalForm/carsDetails',extra: {'id': widget.userId});
                // }else{
                //   Utils.flushBarErrorMessage("No vehicle available with the selected number of seats.", context, redColor);
                // }

                sourceLocation = '';
              }
            },
          )
        ],
      )),
    );
  }
}
