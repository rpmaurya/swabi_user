import 'package:flutter/material.dart';
import 'package:flutter_cab/res/custom_dropDown.dart';
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

class _RentalFormState extends State<RentalForm> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<String> items = ["1", "2", "3", "4", "5", "6"];
  List<String> hours = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"];
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
        heading: "Rental Detail",
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
                child: Text("PickUp Location", style: titleTextStyle),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: controllers[0],
                  boxDecoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: naturalGreyColor.withOpacity(0.3))
                  ),
                  googleAPIKey: "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
                  inputDecoration: InputDecoration(
                    isDense: true,
                    helperStyle: titleTextStyle,
                    prefixStyle: titleTextStyle,
                    counterStyle: titleTextStyle,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    hintText: "Search your location",
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
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
                    print("Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
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
                    controllers[0].text = prediction.description ?? "";
                    controllers[0].selection = TextSelection.fromPosition(
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
          // placesAutoCompleteTextField(controllers[0],logitude1.toString(),latitude1),
          // CustomTextFeild(
          //   controller: controllers[0],
          //   width: AppDimension.getWidth(context)*.9,
          //   headingReq: true,
          //   prefixIcon: true,
          //   img: location,
          //   heading: "Location",
          //   hint: "Enter pickup Location",
          // ),
          //////////////////////////////////////////////////
          //           GooglePlaceAutoCompleteTextField(
          //           textEditingController: controller,
          //           googleAPIKey: "YOUR_GOOGLE_API_KEY",
          //           inputDecoration: InputDecoration()
          //           debounceTime: 800,// default 600 ms,
          //           countries: ["in","fr"],// optional by default null is set
          //           isLatLngRequired:true,// if you required coordinates from place detail
          //           getPlaceDetailWithLatLng: (Prediction prediction) {
          //             // this method will return latlng with place detail
          //             print("placeDetails" + prediction.lng.toString());
          //           }, // this callback is called when isLatLngRequired is true
          //           itmClick: (Prediction prediction) {
          //             controller.text=prediction.description;
          //             controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description.length));
          //           }
          //           // if we want to make custom list item builder
          //           itemBuilder: (context, index, Prediction prediction) {
          //   return Container(
          //   padding: EdgeInsets.all(10),
          //   child: Row(
          //   children: [
          //   Icon(Icons.location_on),
          //   SizedBox(
          //   width: 7,
          //   ),
          //   Expanded(child: Text("${prediction.description??""}"))
          //   ],
          //   ),
          //   );
          //   }
          //       // if you want to add seperator between list items
          //       seperatedBuilder: Divider(),
          //   // want to show close icon
          //   isCrossBtnShown: true,
          //   // optional container padding
          //   containerHorizontalPadding: 10,
          //
          //
          //
          //
          // )
          ///////////////////////////////////////////
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text("Location",style: titleTextStyle),
          //     const SizedBox(height: 5),
          //     CommonContainer(
          //       elevation: 0,
          //       borderReq: true,
          //       height: 50,
          //       width: AppDimension.getWidth(context) * .9,
          //       borderColor: naturalGreyColor.withOpacity(0.3),
          //       padding: const EdgeInsets.only(left: 0),
          //       borderRadius: BorderRadius.circular(5),
          //       child: GestureDetector(
          //         onTap: () async {
          //           controller.text = sourceLocation; // Set the current location to the controller
          //
          //           var sourcePlace = await PlacesAutocomplete.show(
          //             context: context,
          //             apiKey: apiKey,
          //             mode: Mode.overlay,
          //             location: Location(lat: latitude, lng: logitude),
          //             strictbounds: false,
          //             hint: 'Search for a place',
          //             language: 'en',
          //             types: [],
          //             onError: (err) {
          //               print(err);
          //             },
          //           );
          //
          //           if (sourcePlace != null) {
          //             String limitedSourceLocation = sourcePlace.description != null && sourcePlace.description!.length > 150
          //                 ? "${sourcePlace.description!.substring(0, 150)}..."
          //                 : sourcePlace.description ?? "";
          //
          //             controllers[0].text = limitedSourceLocation;
          //
          //             // Initialize the GoogleMapsPlaces instance
          //             final places = GoogleMapsPlaces(apiKey: apiKey);
          //
          //             // Fetching place details to get latitude and longitude
          //             final placeDetails = await places.getDetailsByPlaceId(sourcePlace.placeId!);
          //             final lat = placeDetails.result.geometry!.location.lat;
          //             final lng = placeDetails.result.geometry!.location.lng;
          //
          //             lati = lat;
          //             logi = lng;
          //
          //             setState(() {
          //               sourceLocation = (sourcePlace.description?.length ?? 0) > 150
          //                   ? "$limitedSourceLocation..."
          //                   : limitedSourceLocation;
          //
          //               print("${controllers[0].text} PlacesDubai");
          //               print("${lat.toString()} latitudeDubai");
          //               print("${lng.toString()} longitudeDubai");
          //             });
          //           }
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 10),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               SizedBox(
          //                 width: 280,
          //                 child: CustomText(
          //                   content: sourceLocation.isNotEmpty ? sourceLocation : 'Source Location',
          //                   fontSize: 16,
          //                   align: TextAlign.start,
          //                   fontWeight: FontWeight.w600,
          //                   textColor: sourceLocation != "Source Location" ? blackColor : greyColor1,
          //                 ),
          //               ),
          //               InkWell(
          //                 onTap: () {
          //                   setState(() {
          //                     sourceLocation = ''; // Clear the source location
          //                   });
          //                 },
          //                 child: const Icon(Icons.clear, color: greyColor1, size: 15,),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 10),
          FormCommonSingleAlertSelector(
            title: "Seats",
            elevation: 0,
            controller: controllers[1],
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
          const SizedBox(height: 10),
          FormDatePickerExpense(
            title: "Date",
            controller: controllers[3],
            hint: "PickUp Date",
          ),
          const SizedBox(height: 10),
          TimePickerDropdown(
            controller: controllers[2],
          ),
          // TextFeildTiming(
          //     width: AppDimension.getWidth(context) * .9,
          //     title: "Time",
          //     hint: "PickUp Time",
          //     controller: controllers[2]),
          const SizedBox(height: 10),
          FormCommonSingleAlertSelector(
            title: "Range",
            elevation: 0,
            controller: controllers[4],
            showIcon: const Icon(
              Icons.add_road,
              color: naturalGreyColor,
            ),
            iconReq: true,
            data: List.generate(
                rangeData.length,
                (index) => "${rangeData[index].hours} Hr ${rangeData[index].kilometer} Km"),

            ///Hint Color
            initialValue: "Select Range",
            alertBoxTitle: "Select Range",
            border: true,
          ),
          // CommonContainer(
          //   // width: 450,
          //   elevation: 0,
          //   width: AppDimension.getWidth(context)*.9,
          //   height: 50,
          //   borderRadius: BorderRadius.circular(5),
          //   child: TimePickerSpinnerPopUp(
          //     mode: CupertinoDatePickerMode.time,
          //     initTime: DateTime.now(),
          //     minTime: DateTime.now(),
          //     maxTime: DateTime.now().add(const Duration(days: 30)),
          //     barrierColor: Colors.black12, //Barrier Color when pop up show
          //     pressType: PressType.singlePress,
          //     timeFormat: 'HH:mm',
          //
          //     // Customize your time widget
          //     onChange: (dateTime) {
          //       // Implement your logic with select dateTime
          //     },
          //   ),
          // ),
          // SizedBox(
          //     height: 200,
          //     child: TimePickerDropdown()),
          // SizedBox(height: AppDimension.getHeight(context) / 4),
          const Spacer(),
          CustomButtonBig(
            widht: AppDimension.getWidth(context) * .9,
            btnHeading: "SEARCH",
            // loading: _rentalViewModel.loading,
            loading: status == "Status.loading" && onTap,
            onTap: () {
              // Map<String, dynamic> data = {
              //   // "date": controllers[3].text,
              //   "pickupTime": controllers[2].text,
              //   // "seat": controllers[1].text,
              //   // "hours": controllers[4].text.split(' ')[0],
              //   // "kilometers": controllers[4].text.split(' ')[2],
              //   // "pickUpLocation": controllers[0].text,
              //   // "latitude11":lati,
              //   // "longitude11":logi,
              // };
              // setState(() {
              //   // print("${controllers[2].text.split('')[0]}${controllers[4].text.split('')[6]}");
              //   // print(controllers[2].text.split('')[0]1);
              //   // if (pickupTime.split('')[0].length < 2) {
              //   //   pickupTime = '0'+ pickupTime;
              //   // }
              //   //ja
              //   // String pickupTime = controllers[2].text;
              //   // if (pickupTime.length < 5) {
              //   //   pickupTime = '0'+ pickupTime;
              //   // }
              //   // print(pickupTime);
              //   // print(controllers[4].text);
              //   // String data = controllers[0].text.replaceAll(' ','');
              //   // String data = controllers[0].text.replaceAll(' ','');
              //   print(data);
              // });
              /////API Calling
              if (controllers[0].text.isEmpty) {
                Utils.flushBarErrorMessage(
                    "Please select your pickup point", context);
              } else if (controllers[1].text.isEmpty ||
                  controllers[1].text == "0") {
                Utils.flushBarErrorMessage("Please select your seat", context);
              } else if (controllers[2].text.isEmpty || controllers[2].text == "00:00") {
                Utils.flushBarErrorMessage(
                    "Please select pickup time", context);
              } else if (controllers[3].text.isEmpty) {
                Utils.flushBarErrorMessage(
                    "Please select pickup date", context);
              } else if (controllers[4].text.isEmpty) {
                Utils.flushBarErrorMessage("Please select your range",context);
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
                          "date": controllers[3].text,
                          "pickupTime": controllers[2].text,
                          "seat": controllers[1].text,
                          "hours": controllers[4].text.split(' ')[0],
                          "kilometers": controllers[4].text.split(' ')[2],
                          "pickUpLocation": controllers[0].text,
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
                controllers[2].clear();
                sourceLocation = '';
                List.generate(controllers.length, (index) => controllers[index].clear());
              }
              // showDialog(context: context, builder: (context) {
              //   return RazorpayPayment();
              // },);
              ///////////////////////
              // if (controllers[2].text.isEmpty) {
              //   Utils.flushBarErrorMessage(
              //       "Please select your pickup Time", context);
              // }
              // controllers[2].clear();
            },
          )
        ],
      )),
    );
  }
}
