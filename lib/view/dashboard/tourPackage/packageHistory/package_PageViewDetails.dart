import 'package:flutter/material.dart';
import 'package:flutter_cab/model/packageModels.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/multi_imageSlider_ContainerWidget.dart';
import 'package:flutter_cab/res/customAlertBox.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/customContainer.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/string_extenstion.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view/dashboard/rental/carBooking.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/packageDetails.dart';
import 'package:go_router/go_router.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../../../view_model/package_view_model.dart';

class PackagePageViewDetails extends StatefulWidget {
  final String userId;
  final String packageBookID;

  const PackagePageViewDetails({
    super.key,
    required this.userId,
    required this.packageBookID,
  });

  @override
  State<PackagePageViewDetails> createState() => _PackagePageViewDetailsState();
}

class _PackagePageViewDetailsState extends State<PackagePageViewDetails> {
  TextEditingController cancelController = TextEditingController();
  TextEditingController alertController = TextEditingController();

  bool loading = false;
  int? day;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetPackageItineraryViewModel>(context, listen: false)
          .fetchGetPackageItineraryViewModelApi(
              context, {"packageBookingId": widget.packageBookID});
    });
    // day = detailsData.bookingDate * pkgDetails.noOfDays;
  }

  var detailsData, pkgDetails, userDetails, dataPackage;
  List<PackageHIstoryDetailsMemberList> memberListDetails = [];
  List<PackageHIstoryDetailsPackageActivity> packageHistoryActivityList = [];
  List<AssignedDriverOnPackageBooking> packageDriverDetails = [];
  List<AssignedVehicleOnPackageBooking> packageVehicleDetail = [];
  List<String> packageImage = [];

  ////GetPackageItinerary
  var getPackageItinerary;
  List<ItineraryDetail> getPackageItineraryList = [];

  @override
  Widget build(BuildContext context) {
    detailsData = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data ??
        '';
    memberListDetails = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data
            .memberList ??
        [];
    userDetails = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data
            .user ??
        '';

    pkgDetails = context
        .watch<GetPackageHistoryDetailByIdViewModel>()
        .getPackageHistoryDetailById
        .data
        ?.data
        .pkg;

    packageHistoryActivityList = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data
            .pkg
            .packageActivities ??
        [];
    packageImage = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data
            .pkg
            .packageImageUrl ??
        [];
    packageDriverDetails = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data
            .assignedDriverOnPackageBookings ??
        [];
    packageVehicleDetail = context
            .watch<GetPackageHistoryDetailByIdViewModel>()
            .getPackageHistoryDetailById
            .data
            ?.data
            .assignedVehicleOnPackageBookings ??
        [];

    ///package Details Sub Data
    // String packageString = pkgDetails.replaceAll('{', '').replaceAll('}', '');
    // List<String> packageAttributes = packageString.split(", ");
    // Map<String, dynamic> packageMap = {};
    // for (String attribute in packageAttributes) {
    //   List<String> keyValue = attribute.split(":");
    //   if (keyValue.length == 2) {
    //     String key = keyValue[0].trim();
    //     String value = keyValue[1].trim();
    //     if (key.isNotEmpty && value.isNotEmpty) {
    //       packageMap[key] = value;
    //     }
    //   }
    // }

    getPackageItineraryList = context
            .watch<GetPackageItineraryViewModel>()
            .getPackageItineraryList
            .data
            ?.data
            .itineraryDetails ??
        [];
    getPackageItinerary = context
            .watch<GetPackageItineraryViewModel>()
            .getPackageItineraryList
            .data
            ?.data
            .packageBookingId ??
        '';
    // debugPrint("${getPackageItineraryList.length} GetItineraryDetailsList");
    // debugPrint("$getPackageItinerary GetItineraryDetails");
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Booking Details",
      ),
      body: PageLayout_Page(
          // onRefresh: () async {
          //   await Provider.of<GetPackageHistoryDetailByIdViewModel>(
          //       context,
          //       listen: false)
          //       .fetchGetPackageHistoryDetailByIdViewModelApi(
          //       context,
          //       {
          //         "packageBookingId": widget.packageBookID
          //       },
          //       widget.userId,
          //       widget.packageBookID);
          // },
          child: ListView(
        children: [
          PackageDetailsContainer(
            id: widget.packageBookID,
            pkgImage: packageImage,
            packageName: pkgDetails.packageName,
            bookingStatus: detailsData.bookingStatus,
            location: pkgDetails.location,
            startTime: detailsData.bookingDate,
            endTime: detailsData.bookingDate,
            totalMembers: memberListDetails.length.toString(),
            days: pkgDetails.noOfDays,
            cancelReason: detailsData.cancellationReason,
            cancelledBy: detailsData.cancelledBy,
            pickUpLocation: detailsData.pickupLocation,
            controllerWidget: alertController,
            alertOnTap: () {
              if (alertController.text.isEmpty) {
                Utils.flushBarErrorMessage(
                    "Please enter your pickUp Location", context);
              } else {
                Provider.of<AddPickUpLocationPackageViewModel>(context,
                        listen: false)
                    .fetchAddPickUpLocationPackageViewModelApi(context, {
                  "packageBookingId": widget.packageBookID,
                  "pickupLocation": alertController.text
                });
                context.pop(context);
              }
              // setState(() {
              //   debugPrint(alertController.text);
              // });
              alertController.clear();
            },
            totalAmt: detailsData.totalAmount,
            memberList: List.generate(
                memberListDetails.length,
                (index) => PackageHIstoryDetailsMemberList(
                    memberId: memberListDetails[index].memberId,
                    name: memberListDetails[index].name,
                    age: memberListDetails[index].age,
                    type: memberListDetails[index].type,
                    gender: memberListDetails[index].gender)),
            driverDetails: List.generate(
                packageDriverDetails.length,
                (index) => AssignedDriverOnPackageBooking(
                    date: packageDriverDetails[index].date,
                    driverAssignedId: "",
                    isCancelled: false,
                    driver: Driver(
                        driverId: packageDriverDetails[index].driverAssignedId,
                        firstName: packageDriverDetails[index].driver.firstName,
                        lastName: packageDriverDetails[index].driver.lastName,
                        driverAddress: "",
                        emiratesId: "",
                        mobile: packageDriverDetails[index].driver.mobile,
                        countryCode: "",
                        email: "",
                        gender: packageDriverDetails[index].driver.gender,
                        licenceNumber: "",
                        createdDate: "",
                        modifiedDate: "",
                        profileImageUrl: "",
                        userType: "",
                        vendorId: "",
                        driverStatus: ""))),
            vehicleDetails: List.generate(
                packageVehicleDetail.length,
                (index) => AssignedVehicleOnPackageBooking(
                      vehicle: Vehicle(
                          vehicleId: "",
                          carName: packageVehicleDetail[index].vehicle.carName,
                          year: "",
                          carType: "",
                          brandName: "",
                          fuelType: "",
                          seats: "",
                          color: "",
                          vehicleNumber:
                              packageVehicleDetail[index].vehicle.vehicleNumber,
                          modelNo: "",
                          createdDate: "",
                          modifiedDate: "",
                          images: [],
                          vehicleStatus: ""),
                      date: packageVehicleDetail[index].date,
                      assignedId: "",
                      isCancelled: false,
                    )),
            ///Activity Details List
            child: getPackageItineraryList.isNotEmpty
                ? ItineraryActivityContainer(
                    itineraryDataList: getPackageItineraryList.isNotEmpty
                        ? getPackageItineraryList
                        : packageHistoryActivityList,
                    isPackageItinerary: getPackageItineraryList.isNotEmpty,
                  )

                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: getPackageItineraryList.length,
                //   itemBuilder: (context, index) {
                //     final itineraryData = getPackageItineraryList[index];
                //     final List image =
                //         getPackageItineraryList[index].activity.activityImageUrl;
                //     return ItineraryActivityContainer(
                //       days: "Day ${itineraryData.day == "null" ? "" : itineraryData.day} Activity (${itineraryData.date})",
                //       actyImage:
                //       List.generate(image.length, (index) => image[index]),
                //       activityName: itineraryData.activity.activityName,
                //       description: itineraryData.activity.description,
                //       activityHour: itineraryData.activity.activityHours,
                //       activityVisit: itineraryData.activity.bestTimeToVisit,
                //       openTime: itineraryData.activity.startTime,
                //       closeTime: itineraryData.activity.endTime,
                //       address: itineraryData.activity.address,
                //     );
                //   },
                // )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: packageHistoryActivityList.length,
                    itemBuilder: (context, index) {
                      final data = packageHistoryActivityList[index];
                      final List image = packageHistoryActivityList[index]
                          .activity
                          .activityImageUrl;
                      return ActivityContainer(
                        days:
                            "Activity ${data.day == "null" ? index + 1 : data.day}",
                        actyImage: List.generate(
                            image.length, (index) => image[index]),
                        activityName: data.activity.activityName,
                        description: data.activity.description,
                        activityHour: data.activity.activityHours,
                        activityVisit: data.activity.bestTimeToVisit,
                        openTime: data.activity.startTime,
                        closeTime: data.activity.endTime,
                        address: data.activity.address,
                      );
                    },
                  ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    cancelController.clear();
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: AppDimension.getHeight(context) * .2),
                      child: CancelContainerDialog(
                        loading: loading,
                        controllerCancel: cancelController,
                        onTap: () async {
                          loading = true;
                          if (cancelController.text.isEmpty ||
                              cancelController.text == 'null') {
                            Utils.flushBarErrorMessage(
                                "Please enter the reason", context);
                          } else {
                            await Provider.of<PackageCancelViewModel>(context,
                                    listen: false)
                                .fetchPackageCancelViewModelApi(
                                    context,
                                    {
                                      "packageBookingId": widget.packageBookID,
                                      "cancellationReason":
                                          cancelController.text,
                                      "cancelledBy": "USER"
                                    },
                                    widget.userId)
                                .then((value) {
                              if (context.mounted) {
                                cancelController.clear();
                              }
                            });
                            // controller.dispose();
                          }
                        },
                      ),
                    );
                  });
            },
          )
        ],
      )),
    );
  }
}

class PackageDetailsContainer extends StatefulWidget {
  final String id;
  final String bookingStatus;
  final String packageName;
  final String location;
  final List<String> pkgImage;
  final String startTime;
  final TextEditingController controllerWidget;
  final VoidCallback? alertOnTap;
  final String endTime;
  final String totalMembers;
  final String totalAmt;
  final String pickUpLocation;
  final String days;
  final String cancelReason;
  final String cancelledBy;
  final Widget child;
  final List<PackageHIstoryDetailsMemberList> memberList;
  final List<AssignedVehicleOnPackageBooking> vehicleDetails;
  final List<AssignedDriverOnPackageBooking> driverDetails;
  final VoidCallback? onTap;

  const PackageDetailsContainer(
      {super.key,
      required this.id,
      required this.bookingStatus,
      this.onTap,
      required this.packageName,
      required this.location,
      required this.pkgImage,
      required this.child,
      required this.pickUpLocation,
      required this.controllerWidget,
      this.alertOnTap,
      required this.totalAmt,
      required this.startTime,
      required this.endTime,
      required this.totalMembers,
      required this.cancelReason,
      required this.cancelledBy,
      required this.memberList,
      required this.vehicleDetails,
      required this.driverDetails,
      required this.days});

  @override
  State<PackageDetailsContainer> createState() =>
      _PackageDetailsContainerState();
}

class _PackageDetailsContainerState extends State<PackageDetailsContainer> {
  String apiKey = 'AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo';
  String sourceLocation = "Source Location";
  double logitude = 0.0;
  double latitude = 0.0;

  Future<List<double>?> getCoordinates(String location) async {
    try {
      final places = GoogleMapsPlaces(
        apiKey: apiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      var locations = await places
          .searchByText(location)
          .then((result) => result.results)
          .then((results) => results.map((result) => result.geometry!.location))
          .then((locations) => locations.toList());

      if (locations.isNotEmpty) {
        print("${locations.first.lat}Location");
        return [locations.first.lat, locations.first.lng];
      } else {
        return [];
      }
    } catch (e) {
      print("Error getting coordinates: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTextWidget(
                sideLogo: true,
                content: "Package Images",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                textColor: textColor),
            widget.bookingStatus == "BOOKED"
                ? widget.pickUpLocation != "N/A" &&
                        widget.pickUpLocation.isEmpty
                    ? CustomButtonSmall(
                        height: 40,
                        // width: AppDimension.getWidth(context) * .35,
                        btnHeading: "PickUp Location",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 150),
                                      CustomAlertBox(
                                        heading: "Add PickUp Location",
                                        height:
                                            AppDimension.getHeight(context) /
                                                3.4,
                                        widgetReq: true,
                                        crossIcon: true,
                                        crossOnTap: () {
                                          widget.controllerWidget.clear();
                                          context.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Location",
                                                style: titleTextStyle),
                                            const SizedBox(height: 5),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              height: 50,
                                              child:
                                                  GooglePlaceAutoCompleteTextField(
                                                textEditingController:
                                                    widget.controllerWidget,
                                                boxDecoration: BoxDecoration(
                                                    color: background,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: naturalGreyColor
                                                            .withOpacity(0.3))),
                                                googleAPIKey:
                                                    "AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo",
                                                inputDecoration:
                                                    InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5,
                                                          vertical: 0),
                                                  isDense: true,
                                                  hintText:
                                                      "Search your location",
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  hintStyle: GoogleFonts.lato(
                                                    color: greyColor1,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  filled: true,
                                                  fillColor: background,
                                                  disabledBorder:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          borderSide:
                                                              BorderSide.none),
                                                ),
                                                textStyle: titleTextStyle,
                                                debounceTime: 400,
                                                // countries: ["ae", "fr"],
                                                isLatLngRequired: true,
                                                getPlaceDetailWithLatLng:
                                                    (prediction) {
                                                  print(
                                                      "Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
                                                  // You can use prediction.lat and prediction.lng here as needed
                                                  // Example: Save them to variables or perform further actions
                                                },

                                                itemClick: (prediction) {
                                                  widget.controllerWidget.text =
                                                      prediction.description ??
                                                          "";
                                                  widget.controllerWidget
                                                          .selection =
                                                      TextSelection.fromPosition(
                                                          TextPosition(
                                                              offset: prediction
                                                                      .description
                                                                      ?.length ??
                                                                  0));
                                                },
                                                seperatedBuilder:
                                                    const Divider(),

                                                // OPTIONAL// If you want to customize list view item builder
                                                itemBuilder: (context, index,
                                                    prediction) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Container(
                                                      color: background,
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
                                                            prediction
                                                                    .description ??
                                                                "",
                                                            style:
                                                                titleTextStyle,
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
                                            // StatefulBuilder(
                                            //   builder: (context, setState) {
                                            //     return CommonContainer(
                                            //       elevation: 0,
                                            //       borderReq: true,
                                            //       height: 50,
                                            //       width: AppDimension.getWidth(context) * .7,
                                            //       borderColor: naturalGreyColor.withOpacity(0.3),
                                            //       padding: const EdgeInsets.only(left: 0),
                                            //       borderRadius: BorderRadius.circular(5),
                                            //       child: GestureDetector(
                                            //         onTap: () async {
                                            //           widget.controllerWidget.text = sourceLocation; // Set the current location to the controller
                                            //           var sourcePlace = await PlacesAutocomplete.show(
                                            //             context: context,
                                            //             apiKey: apiKey,
                                            //             mode: Mode.overlay,
                                            //             strictbounds: false,
                                            //             hint: 'Search for a place',
                                            //             language: 'en',
                                            //             // location: Location(context,logitude,latitude),
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
                                            //             widget.controllerWidget.text = limitedSourceLocation;
                                            //
                                            //             // Initialize the GoogleMapsPlaces instance
                                            //             final places = GoogleMapsPlaces(apiKey: apiKey);
                                            //
                                            //             // Fetching place details to get latitude and longitude
                                            //             final placeDetails = await places.getDetailsByPlaceId(sourcePlace.placeId!);
                                            //             final lat = placeDetails.result.geometry!.location.lat;
                                            //             final lng = placeDetails.result.geometry!.location.lng;
                                            //
                                            //             setState(() {
                                            //               sourceLocation = (sourcePlace.description?.length ?? 0) > 150
                                            //                   ? "$limitedSourceLocation..."
                                            //                   : limitedSourceLocation;
                                            //
                                            //               print("${widget.controllerWidget.text} PlacesDubai");
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
                                            //                 width: 230,
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
                                            //                     print("presss");
                                            //                     sourceLocation = ''; // Clear the source location
                                            //                   });
                                            //                 },
                                            //                 child: const Icon(Icons.clear, color: greyColor1, size: 15,),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     );
                                            //   },
                                            // ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CustomButtonSmall(
                                                    height: 40,
                                                    width:
                                                        AppDimension.getWidth(
                                                                context) *
                                                            .3,
                                                    btnHeading: "Submit",
                                                    onTap: widget.alertOnTap ??
                                                        () => print('object'))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                      )
                    : const SizedBox()
                : const SizedBox()
          ],
        ),
        const SizedBox(height: 10),
        CommonContainer(
            height: 150,
            elevation: 0,
            width: double.infinity,
            borderRadius: BorderRadius.circular(5),
            borderReq: true,
            borderColor: naturalGreyColor.withOpacity(0.3),
            child: MultiImageSlider(
              images: widget.pkgImage,
            )),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomTextWidget(
            content: "Booking Details",
            sideLogo: true,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        ///Booking Details Container
        CommonContainer(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          elevation: 0,
          borderRadius: BorderRadius.circular(5),
          borderReq: true,
          borderColor: naturalGreyColor.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    content: "Id : ",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    content: widget.id,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                // width: 190,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      content: "Package Name : ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 210,
                      child: CustomText(
                        align: TextAlign.start,
                        content: widget.packageName.capitalizeFirstOfEach,
                        maxline: 4,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        content: "Status : ",
                        fontSize: 16,
                        align: TextAlign.start,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        width: 100,
                        child: CustomText(
                          content: widget.bookingStatus,
                          fontSize: 16,
                          // textColor: widget.bookingStatus == "CANCELLED" ? redColor : greenColor,
                          align: TextAlign.start,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  SizedBox(
                    width: 190,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CustomTextWidget(
                          content: "Days : ",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          // width: 120,
                          child: CustomTextWidget(
                            align: TextAlign.start,
                            content: "${widget.days} Days",
                            maxline: 4,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textEllipsis: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidget(
                        content: "Start Date : ",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomTextWidget(
                        content: widget.startTime,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  // const Spacer(),
                  SizedBox(
                    width: 175,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextWidget(
                          content: "End Date : ",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          // width: 120,
                          child: CustomTextWidget(
                            align: TextAlign.start,
                            content: widget.endTime,
                            maxline: 4,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textEllipsis: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    content: "Total Members : ",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    content: widget.totalMembers,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              widget.bookingStatus == "CANCELLED"
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomTextWidget(
                            content: "Cancelled By : ",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            // color: Colors.cyan,
                            width: AppDimension.getWidth(context) * .58,
                            child: CustomText(
                              content: widget.cancelledBy,
                              fontSize: 16,
                              maxline: 5,
                              align: TextAlign.start,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              widget.bookingStatus == "CANCELLED"
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomTextWidget(
                            content: "Cancel Reason : ",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            // color: Colors.cyan,
                            width: AppDimension.getWidth(context) * .58,
                            child: CustomText(
                              content: widget.cancelReason,
                              fontSize: 16,
                              maxline: 5,
                              align: TextAlign.start,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      content: "Location : ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .6,
                      child: CustomText(
                        align: TextAlign.start,
                        content: widget.location,
                        maxline: 4,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textEllipsis: false,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                      content: "PickUp Location : ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .55,
                      child: CustomText(
                        maxline: 5,
                        align: TextAlign.start,
                        content: widget.pickUpLocation.isEmpty
                            ? "N/A"
                            : widget.pickUpLocation,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // : const SizedBox(),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    content: "Total Amount : ",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextWidget(
                    content: "AED ${widget.totalAmt}",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomTextWidget(
            content: "Members Details",
            fontSize: 20,
            sideLogo: true,
            fontWeight: FontWeight.w600,
          ),
        ),

        ///Members Details Container
        CommonContainer(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          width: double.infinity,
          elevation: 0,
          borderRadius: BorderRadius.circular(5),
          borderReq: true,
          borderColor: naturalGreyColor.withOpacity(0.3),
          child: DataTable(
              columnSpacing: 30,
              headingRowHeight: 40,
              dividerThickness: 0,
              dataTextStyle: titleTextStyle1,
              columns: const [
                DataColumn(
                    label: CustomTextWidget(
                  content: "Id",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
                DataColumn(
                    label: SizedBox(
                        // width: 60,
                        child: CustomTextWidget(
                            content: "Name",
                            fontSize: 18,
                            fontWeight: FontWeight.w700))),
                DataColumn(
                    label: CustomTextWidget(
                        content: "Age",
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                DataColumn(
                    label: CustomTextWidget(
                        content: "Type",
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                DataColumn(
                    label: CustomTextWidget(
                        content: "Gender",
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ],
              rows: widget.memberList
                  .map((PackageHIstoryDetailsMemberList members) => DataRow(
                        cells: [
                          DataCell(CustomText(
                            content: members.memberId.toString(),
                            textEllipsis: true,
                          )),
                          DataCell(SizedBox(
                              width: 60,
                              child: CustomText(
                                  maxline: 2,
                                  align: TextAlign.start,
                                  textEllipsis: true,
                                  content: members.name.toString()))),
                          DataCell(CustomText(content: members.age.toString())),
                          DataCell(CustomText(
                            textColor: (() {
                              int age = int.parse(members.age.toString());
                              return age >= 60
                                  ? redColor
                                  : null; // Set color to red for Senior, otherwise use default
                            })(),
                            content: (() {
                              int age = int.parse(members.age.toString());
                              if (age < 5) return 'Infant';
                              if (age < 18) return 'Child';
                              if (age < 60) return 'Adult';
                              return 'Senior*';
                              // return age.toString();  // Display the age as-is for other cases
                            })(),
                          )),
                          DataCell(
                              CustomText(content: members.gender.toString())),
                        ],
                      ))
                  .toList()),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CustomTextWidget(
            content: "Activities Details",
            fontSize: 20,
            sideLogo: true,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          child: widget.child,
        ),
        const SizedBox(height: 10),
        widget.bookingStatus == "BOOKED"
            ? Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomButtonSmall(
                    height: 40,
                    width: AppDimension.getWidth(context) * .35,
                    btnHeading: "Cancel Booking",
                    onTap: widget.onTap ?? () => print("Cancel Button Press"),
                  ),
                ),
              )
            : const SizedBox(),
        widget.driverDetails.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextWidget(
                  content: "Driver Details",
                  fontSize: 20,
                  sideLogo: true,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),

        ///Driver Details Container
        widget.driverDetails.isNotEmpty
            ? CommonContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                width: double.infinity,
                elevation: 0,
                borderRadius: BorderRadius.circular(5),
                borderReq: true,
                borderColor: naturalGreyColor.withOpacity(0.3),
                child: DataTable(
                  horizontalMargin: 5,
                    columnSpacing: 20,
                    headingRowHeight: 40,
                    dividerThickness: 0,
                    dataTextStyle: titleTextStyle1,
                    columns: const [
                      DataColumn(
                          label: CustomTextWidget(
                        content: "Date",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                      DataColumn(
                          label: SizedBox(
                              // width: 60,
                              child: CustomTextWidget(
                                  content: "Name",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700))),
                      DataColumn(
                          label: CustomTextWidget(
                              content: "Gender",
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      DataColumn(
                          label: CustomTextWidget(
                              content: "Contact",
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                    rows: widget.driverDetails
                        .map((AssignedDriverOnPackageBooking driver) => DataRow(
                              cells: [
                                DataCell(CustomText(
                                  content: driver.date.toString(),
                                  textEllipsis: true,
                                )),
                                DataCell(SizedBox(
                                    width: 60,
                                    child: CustomText(
                                        maxline: 2,
                                        align: TextAlign.start,
                                        textEllipsis: true,
                                        content:
                                            "${driver.driver.firstName.toString()} ${driver.driver.lastName.toString()}"))),
                                DataCell(CustomText(
                                    content: driver.driver.gender.toString())),
                                DataCell(CustomText(
                                    content: driver.driver.mobile.toString())),
                              ],
                            ))
                        .toList()),
              )
            : const SizedBox(),
        widget.vehicleDetails.isNotEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CustomTextWidget(
                  content: "Vehicle Details",
                  fontSize: 20,
                  sideLogo: true,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),

        ///Vehicle Details Container
        widget.vehicleDetails.isNotEmpty
            ? CommonContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                width: double.infinity,
                elevation: 0,
                borderRadius: BorderRadius.circular(5),
                borderReq: true,
                borderColor: naturalGreyColor.withOpacity(0.3),
                child: DataTable(
                    columnSpacing: 30,
                    headingRowHeight: 40,
                    dividerThickness: 0,
                    dataTextStyle: titleTextStyle1,
                    columns: const [
                      DataColumn(
                          label: CustomTextWidget(
                        content: "Date",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                      DataColumn(
                          label: SizedBox(
                              // width: 60,
                              child: CustomTextWidget(
                                  content: "Name",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700))),
                      DataColumn(
                          label: CustomTextWidget(
                              content: "Number",
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ],
                    rows: widget.vehicleDetails
                        .map((AssignedVehicleOnPackageBooking vehicle) =>
                            DataRow(
                              cells: [
                                DataCell(CustomText(
                                  content: vehicle.date.toString(),
                                  textEllipsis: true,
                                )),
                                DataCell(CustomText(
                                    content:
                                        vehicle.vehicle.carName.toString())),
                                DataCell(CustomText(
                                    content: vehicle.vehicle.vehicleNumber
                                        .toString())),
                              ],
                            ))
                        .toList()),
              )
            : const SizedBox(),
      ],
    );
  }
}

class ItineraryActivityContainer extends StatefulWidget {
  final List<dynamic> itineraryDataList;
  final bool isPackageItinerary;

  const ItineraryActivityContainer({
    required this.itineraryDataList,
    required this.isPackageItinerary,
    Key? key,
  }) : super(key: key);

  @override
  State<ItineraryActivityContainer> createState() =>
      _ItineraryActivityContainerState();
}

class _ItineraryActivityContainerState
    extends State<ItineraryActivityContainer> {
  @override
  Widget build(BuildContext context) {
    return widget.isPackageItinerary
        ? _buildPackageItineraryList()
        : _buildPackageHistoryList();
  }

  Widget _buildPackageItineraryList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.itineraryDataList.length,
      itemBuilder: (context, index) {
        final itineraryData = widget.itineraryDataList[index];
        final List image = itineraryData.activity.activityImageUrl;

        if (index == 0 ||
            itineraryData.day != widget.itineraryDataList[index - 1].day) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == 0 ||
                itineraryData.day != widget.itineraryDataList[index - 1].day ?  2 : 5),
            child: CommonContainer(
              borderReq: true,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              borderColor: naturalGreyColor.withOpacity(.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,top: 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidget(
                              content:
                              "Day ${itineraryData.day == "null" ? "" : itineraryData.day} (${itineraryData.date})",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              sideLogo: true,
                            ),
                            CommonContainer(
                              padding: const EdgeInsets.all(5),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              color: widget.itineraryDataList[index].dayStatus == "COMPLETED" ? greenColor : redColor ,
                              child: CustomText(
                                content:
                                widget.itineraryDataList[index].dayStatus,
                                fontSize: 16,
                                textColor: background,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextWidget(
                                content:
                                "Start Time : ${widget.itineraryDataList[index].startTimestamp.toString().isEmpty ? "N/A" : widget.itineraryDataList[index].startTimestamp.toString().split(' ')[1].substring(0,5)}",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomTextWidget(
                                content:
                                "End Time : ${widget.itineraryDataList[index].endTimestamp.toString().isEmpty ? "N/A" : widget.itineraryDataList[index].endTimestamp.toString().split(' ')[1].substring(0,5)}",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildActivityContent(itineraryData, image, "Activity 1"),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CommonContainer(
              borderReq: true,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              borderColor: naturalGreyColor.withOpacity(.3),
              child: _buildActivityContent(itineraryData, image, "Activity ${index + 1}"),
            ),
          );
        }
      },
    );
  }

  Widget _buildPackageHistoryList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.itineraryDataList.length,
      itemBuilder: (context, index) {
        final data = widget.itineraryDataList[index];
        final List image = data.activity.activityImageUrl;
        return CommonContainer(
          borderReq: true,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          borderColor: naturalGreyColor.withOpacity(.3),
          child: _buildActivityContent(
            data,
            image,
            "Activity ${data.day == "null" ? index + 1 : data.day}",
          ),
        );
      },
    );
  }

  Widget _buildActivityContent(dynamic data, List image, String days) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        CustomTextWidget(
          // sideLogo: true,
          align: TextAlign.start,
          content: days,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          textColor: blackColor,
        ),
        const SizedBox(height: 10),
        CommonContainer(
          elevation: 0,
          height: 150,
          borderRadius: BorderRadius.circular(10),
          child: MultiImageSlider(
            images: List.generate(image.length, (index) => image[index]),
          ),
        ),
        const SizedBox(height: 5),
        CustomText(
          align: TextAlign.start,
          content: data.activity.activityName,
          maxline: 3,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          textColor: blackColor,
        ),
        const SizedBox(height: 5),
        ReadMoreText(
          data.activity.description,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: blackColor,
            fontWeight: FontWeight.w400,
          ),
          moreStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: redColor, fontSize: 15),
          lessStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: redColor, fontSize: 15),
        ),
        const SizedBox(height: 5),
        _buildInfoRow("Activity Hours", data.activity.activityHours,
            "Time To Visit", data.activity.bestTimeToVisit),
        const SizedBox(height: 10),
        _buildInfoRow("Opening Time", data.activity.startTime, "Closing Time",
            data.activity.endTime),
        const SizedBox(height: 10),
        _buildLocationInfo(data.activity.address),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildInfoRow(
      String label1, String value1, String label2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRichText(label1, value1),
        _buildRichText(label2, value2),
      ],
    );
  }

  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(String address) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Location: ",
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          TextSpan(
            text: address,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

///OLD CODE
// class ItineraryActivityContainer extends StatefulWidget {
//   final List<String> actyImage;
//   final String days;
//   final String activityName;
//   final String description;
//   final String activityHour;
//   final String activityVisit;
//   final String openTime;
//   final String closeTime;
//   final String address;
//
//   const ItineraryActivityContainer(
//       {required this.actyImage,
//       required this.days,
//       required this.activityName,
//       required this.description,
//       required this.activityHour,
//       required this.activityVisit,
//       required this.openTime,
//       required this.closeTime,
//       required this.address,
//       super.key});
//
//   @override
//   State<ItineraryActivityContainer> createState() =>
//       _ItineraryActivityContainerState();
// }
//
// class _ItineraryActivityContainerState
//     extends State<ItineraryActivityContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: CommonContainer(
//         borderReq: true,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//         borderColor: naturalGreyColor.withOpacity(.3),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             CustomTextWidget(
//               sideLogo: true,
//               align: TextAlign.start,
//               content: widget.days == "null" ? "" : widget.days,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               textColor: blackColor,
//             ),
//             const SizedBox(height: 10),
//             CommonContainer(
//               elevation: 0,
//               height: 150,
//               borderRadius: BorderRadius.circular(10),
//               child: MultiImageSlider(
//                 images: widget.actyImage,
//               ),
//             ),
//             const SizedBox(height: 5),
//             CustomText(
//               align: TextAlign.start,
//               content: widget.activityName,
//               maxline: 3,
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               textColor: blackColor,
//             ),
//             const SizedBox(height: 5),
//             ReadMoreText(
//               widget.description,
//               style: GoogleFonts.lato(
//                 fontSize: 14,
//                 // textEllipsis: true,
//                 color: blackColor,
//                 fontWeight: FontWeight.w400,
//               ),
//               moreStyle: const TextStyle(
//                   fontWeight: FontWeight.w500, color: redColor, fontSize: 15),
//               lessStyle: const TextStyle(
//                   fontWeight: FontWeight.w500, color: redColor, fontSize: 15),
//             ),
//             const SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                       text: "Activity Hours : ",
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: textColor)),
//                   TextSpan(
//                       text: widget.activityHour,
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: textColor))
//                 ])),
//                 RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                       text: "Time To Visit : ",
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: textColor)),
//                   TextSpan(
//                       text: widget.activityVisit,
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: textColor))
//                 ]))
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                       text: "Opening Time : ",
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: textColor)),
//                   TextSpan(
//                       text: widget.openTime,
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: textColor))
//                 ])),
//                 RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                       text: "Closing Time : ",
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: textColor)),
//                   TextSpan(
//                       text: widget.closeTime,
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: textColor))
//                 ]))
//               ],
//             ),
//             const SizedBox(height: 10),
//             RichText(
//                 textAlign: TextAlign.start,
//                 text: TextSpan(children: [
//                   TextSpan(
//                       text: "Location : ",
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: textColor)),
//                   TextSpan(
//                       text: widget.address,
//                       style: GoogleFonts.lato(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: textColor))
//                 ])),
//             const SizedBox(height: 5),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
