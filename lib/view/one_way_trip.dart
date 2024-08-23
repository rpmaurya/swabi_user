// ignore_for_file: unnecessary_null_comparison, unused_local_variable, use_build_context_synchronously, avoid_print, unused_import, constant_identifier_names, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/view/consts.dart';
import 'package:flutter_cab/view/home_screen_1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import "package:google_maps_webservice/places.dart";
import 'package:google_api_headers/google_api_headers.dart';

enum Destination { one_way_trip, round_trip }

class one_way_trip extends StatefulWidget {
  const one_way_trip({super.key});

  @override
  State<one_way_trip> createState() => _one_way_tripState();
}

class _one_way_tripState extends State<one_way_trip> {
  Destination? _destination = Destination.one_way_trip;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  FocusNode sourceFocusNode = FocusNode();
  FocusNode destinationFocusNode = FocusNode();
  // TextEditingController sourceController = TextEditingController();
  // TextEditingController destinationController = TextEditingController();

  String sourceLocation = "Source Location";
  String destinationLocation = "Destination Location";

  String roundTripSourceLocation = "Source Location";
  String roundTripMoreLocation = "Add Location";
  String roundTripDestinationLocation = "Destination Location";

  Future<List<double>?> getCoordinates(String location) async {
    try {
      final places = GoogleMapsPlaces(
        apiKey: GOOGLE_MAP_API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      List<Location> locations = await places
          .searchByText(location)
          .then((result) => result.results)
          .then((results) => results.map((result) => result.geometry!.location))
          .then((locations) => locations.toList());

      if (locations.isNotEmpty) {
        return [locations.first.lat, locations.first.lng];
      } else {
        return [];
      }
    } catch (e) {
      print("Error getting coordinates: $e");
      return [];
    }
  }

  Future<List<double>?> getRoundTripCoordinates(String location) async {
    try {
      final places = GoogleMapsPlaces(
        apiKey: GOOGLE_MAP_API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      List<Location> locations = await places
          .searchByText(location)
          .then((result) => result.results)
          .then((results) => results.map((result) => result.geometry!.location))
          .then((locations) => locations.toList());

      if (locations.isNotEmpty) {
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
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListTile(
                        leading: const Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        title: Text(
                          'Destination',
                          style: GoogleFonts.lato(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: const Text('One way Trip'),
                          leading: Radio<Destination>(
                              value: Destination.one_way_trip,
                              groupValue: _destination,
                              onChanged: (Destination? value) {
                                setState(() {
                                  _destination = value;
                                });
                              }),
                        )),
                        Expanded(
                            child: ListTile(
                          title: const Text('Round Trip'),
                          leading: Radio<Destination>(
                              value: Destination.round_trip,
                              groupValue: _destination,
                              onChanged: (Destination? value) {
                                setState(() {
                                  _destination = value;
                                });
                              }),
                        ))
                      ],
                    ),

///////////////////////////////////////      ONE WAY TRIP      ///////////////////////////////////////////////

                    if (_destination == Destination.one_way_trip)
                      Column(
                        children: [
                          ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            leading: const Padding(
                              padding: EdgeInsets.only(left: 3, bottom: 20),
                              child: Icon(Icons.radio_button_checked),
                            ),
                            title: GestureDetector(
                                onTap: () async {
                                  var sourcePlace =
                                      await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey: GOOGLE_MAP_API_KEY,
                                          mode: Mode.overlay,
                                          types: [],
                                          strictbounds: false,
                                          onError: (err) {
                                            print(err);
                                          });

                                  if (sourcePlace != null) {
                                    final plist = GoogleMapsPlaces(
                                      apiKey: GOOGLE_MAP_API_KEY,
                                      apiHeaders: await const GoogleApiHeaders()
                                          .getHeaders(),
                                    );
                                    String placeid = sourcePlace.placeId ?? "0";
                                    final detail = await plist
                                        .getDetailsByPlaceId(placeid);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;

                                    String limitedSourceLocation = sourcePlace
                                                    .description !=
                                                null &&
                                            sourcePlace.description!.length > 30
                                        ? "${sourcePlace.description!.substring(0, 30)}..."
                                        : sourcePlace.description ?? "";

                                    setState(() {
                                      sourceLocation =
                                          (sourcePlace.description?.length ??
                                                      0) >
                                                  30
                                              ? "$limitedSourceLocation..."
                                              : limitedSourceLocation;
                                      try {
                                        if (sourceLocation != null) {
                                          print(sourceLocation);
                                        } else {
                                          print('error here');
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    });
                                  }
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  minVerticalPadding: 0,
                                  dense: true,
                                  title: Text(
                                    sourceLocation.isNotEmpty
                                        ? sourceLocation
                                        : 'Source Location',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sourceLocation =
                                              ''; // Clear the source location
                                        });
                                      },
                                      child: const Icon(Icons.clear)),
                                )),
                            subtitle: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Divider(
                                    thickness: 1.0,
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(234, 232, 232, 1)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.add,
                                    size: 32,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            leading: const Padding(
                              padding: EdgeInsets.only(left: 3, bottom: 20),
                              child: Icon(Icons.radio_button_checked),
                            ),
                            title: GestureDetector(
                                onTap: () async {
                                  var sourcePlace =
                                      await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey: GOOGLE_MAP_API_KEY,
                                          mode: Mode.overlay,
                                          types: [],
                                          strictbounds: false,
                                          onError: (err) {
                                            print(err);
                                          });

                                  if (sourcePlace != null) {
                                    final plist = GoogleMapsPlaces(
                                      apiKey: GOOGLE_MAP_API_KEY,
                                      apiHeaders: await const GoogleApiHeaders()
                                          .getHeaders(),
                                    );
                                    String placeid = sourcePlace.placeId ?? "0";
                                    final detail = await plist
                                        .getDetailsByPlaceId(placeid);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;

                                    String limitedSourceLocation = sourcePlace
                                                    .description !=
                                                null &&
                                            sourcePlace.description!.length > 30
                                        ? "${sourcePlace.description!.substring(0, 30)}..."
                                        : sourcePlace.description ?? "";

                                    setState(() {
                                      sourceLocation =
                                          (sourcePlace.description?.length ??
                                                      0) >
                                                  30
                                              ? "$limitedSourceLocation..."
                                              : limitedSourceLocation;
                                      try {
                                        if (sourceLocation != null) {
                                          print(sourceLocation);
                                        } else {
                                          print('error here');
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    });
                                  }
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  minVerticalPadding: 0,
                                  dense: true,
                                  title: Text(
                                    sourceLocation.isNotEmpty
                                        ? sourceLocation
                                        : 'Source Location',
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sourceLocation =
                                              ''; // Clear the source location
                                        });
                                      },
                                      child: const Icon(Icons.clear)),
                                )),
                            subtitle: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Divider(
                                    thickness: 1.0,
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(234, 232, 232, 1)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.add,
                                    size: 32,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -30),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(
                                      'assets/images/icons/dotted-line.png')),
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -35),
                            child: ListTile(
                              minVerticalPadding: 0,
                              dense: true,
                              leading: const Icon(
                                Icons.add_location,
                                size: 30,
                              ),
                              title: GestureDetector(
                                  onTap: () async {
                                    var destinationPlace =
                                        await PlacesAutocomplete.show(
                                            context: context,
                                            apiKey: GOOGLE_MAP_API_KEY,
                                            mode: Mode.overlay,
                                            types: [],
                                            strictbounds: false,
                                            onError: (err) {
                                              print(err);
                                            });

                                    if (destinationPlace != null) {
                                      final plist = GoogleMapsPlaces(
                                        apiKey: GOOGLE_MAP_API_KEY,
                                        apiHeaders:
                                            await const GoogleApiHeaders()
                                                .getHeaders(),
                                      );
                                      String placeid =
                                          destinationPlace.placeId ?? "0";
                                      final detail = await plist
                                          .getDetailsByPlaceId(placeid);
                                      final geometry = detail.result.geometry!;
                                      final lat = geometry.location.lat;
                                      final lang = geometry.location.lng;
                                      String limitedDestinationLocation =
                                          destinationPlace.description !=
                                                      null &&
                                                  destinationPlace
                                                          .description!.length >
                                                      30
                                              ? "${destinationPlace.description!.substring(0, 30)}..."
                                              : destinationPlace.description ??
                                                  "";

                                      setState(() {
                                        destinationLocation = (destinationPlace
                                                        .description?.length ??
                                                    0) >
                                                30
                                            ? "$limitedDestinationLocation..."
                                            : limitedDestinationLocation;
                                      });
                                    }
                                  },
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                        destinationLocation.isNotEmpty
                                            ? destinationLocation
                                            : 'Destination Location',
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            destinationLocation =
                                                ''; // Clear the source location
                                          });
                                        },
                                        child: const Icon(Icons.clear)),
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                right: 18,
                                left: 18,
                              ),
                              child: Transform.translate(
                                offset: const Offset(0, -20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'Departure Date',
                                                  style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 0.4)),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        DateTime? datePicked =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    selectedDate,
                                                                firstDate:
                                                                    DateTime(
                                                                        2024),
                                                                lastDate:
                                                                    DateTime(
                                                                        2030));

                                                        if (datePicked !=
                                                            null) {
                                                          setState(() {
                                                            selectedDate =
                                                                datePicked;
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.calendar_month,
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 0.4),
                                                        size: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      selectedDate != null
                                                          ? DateFormat(
                                                                  'dd MMMM, yyyy')
                                                              .format(
                                                                  selectedDate)
                                                          : 'Select a date',
                                                      style:
                                                          GoogleFonts.lato(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/icons/search-places.png'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Search Near by Places',
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: const Color.fromRGBO(
                                                      217, 115, 122, 1)),
                                            )
                                          ],
                                        ),
                                      ),
                                      _shoppix_mall(),
                                      const Divider(),
                                      _shoppix_mall(),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        'Popular Places',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: const Color.fromRGBO(
                                                217, 115, 122, 1)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _shoppix_mall(),
                                      const Divider(),
                                      _shoppix_mall(),
                                      const Divider(),
                                      _shoppix_mall(),
                                      const Divider(),
                                      _shoppix_mall(),
                                      const Divider(),
                                      _shoppix_mall(),
                                    ]),
                              ))
                        ],
                      ),

////////////////////////////////////////      ROUND TRIP       ///////////////////////////////////////////////

                    if (_destination == Destination.round_trip)
                      Column(children: [
                        ListTile(
                          minVerticalPadding: 0,
                          dense: true,
                          leading: const Padding(
                            padding: EdgeInsets.only(left: 3, bottom: 10),
                            child: Icon(Icons.radio_button_checked),
                          ),
                          title: GestureDetector(
                              onTap: () async {
                                var roundTripSourcePlace =
                                    await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: GOOGLE_MAP_API_KEY,
                                        mode: Mode.overlay,
                                        types: [],
                                        strictbounds: false,
                                        onError: (err) {
                                          print(err);
                                        });

                                if (roundTripSourcePlace != null) {
                                  final glist = GoogleMapsPlaces(
                                    apiKey: GOOGLE_MAP_API_KEY,
                                    apiHeaders: await const GoogleApiHeaders()
                                        .getHeaders(),
                                  );
                                  String roundTripPlaceId =
                                      roundTripSourcePlace.placeId ?? "0";
                                  final detail = await glist
                                      .getDetailsByPlaceId(roundTripPlaceId);
                                  final geometry = detail.result.geometry!;
                                  final lat = geometry.location.lat;
                                  final lang = geometry.location.lng;

                                  String roundTripLimitedSourceLocation =
                                      roundTripSourcePlace.description !=
                                                  null &&
                                              roundTripSourcePlace
                                                      .description!.length >
                                                  30
                                          ? "${roundTripSourcePlace.description!.substring(0, 30)}..."
                                          : roundTripSourcePlace.description ??
                                              "";

                                  setState(() {
                                    roundTripSourceLocation =
                                        (roundTripSourcePlace
                                                        .description?.length ??
                                                    0) >
                                                30
                                            ? "$roundTripLimitedSourceLocation..."
                                            : roundTripLimitedSourceLocation;
                                    try {
                                      if (roundTripSourceLocation != null) {
                                        print(roundTripSourceLocation);
                                      } else {
                                        print('error here');
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  });
                                }
                              },
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                minVerticalPadding: 0,
                                title: Text(
                                  roundTripSourceLocation.isNotEmpty
                                      ? roundTripSourceLocation
                                      : 'Source Location',
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                          subtitle: const Divider(),
                          trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  roundTripSourceLocation = '';
                                });
                              },
                              child: const Icon(Icons.clear)),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -25),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                    'assets/images/icons/dotted-line.png')),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -25),
                          child: ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            leading: Transform.translate(
                              offset: const Offset(0, -22),
                              child: Container(
                                width: 28,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    shape: BoxShape.circle),
                                child: const Center(child: Text('1')),
                              ),
                            ),
                            title: Transform.translate(
                              offset: const Offset(0, -10),
                              child: GestureDetector(
                                  onTap: () async {
                                    var morePlace =
                                        await PlacesAutocomplete.show(
                                            context: context,
                                            apiKey: GOOGLE_MAP_API_KEY,
                                            mode: Mode.overlay,
                                            types: [],
                                            strictbounds: false,
                                            onError: (err) {
                                              print(err);
                                            });

                                    if (morePlace != null) {
                                      final glist = GoogleMapsPlaces(
                                        apiKey: GOOGLE_MAP_API_KEY,
                                        apiHeaders:
                                            await const GoogleApiHeaders()
                                                .getHeaders(),
                                      );
                                      String roundTripPlaceId =
                                          morePlace.placeId ?? "0";
                                      final detail =
                                          await glist.getDetailsByPlaceId(
                                              roundTripPlaceId);
                                      final geometry = detail.result.geometry!;
                                      final lat = geometry.location.lat;
                                      final lang = geometry.location.lng;
                                      String limitedDestinationLocation = morePlace
                                                      .description !=
                                                  null &&
                                              morePlace.description!.length > 30
                                          ? "${morePlace.description!.substring(0, 30)}..."
                                          : morePlace.description ?? "";

                                      setState(() {
                                        roundTripMoreLocation = (morePlace
                                                        .description?.length ??
                                                    0) >
                                                30
                                            ? "$limitedDestinationLocation..."
                                            : limitedDestinationLocation;
                                      });
                                    }
                                  },
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    minVerticalPadding: 0,
                                    dense: true,
                                    title: Text(
                                        roundTripMoreLocation.isNotEmpty
                                            ? roundTripMoreLocation
                                            : 'Add Location',
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            roundTripMoreLocation = '';
                                          });
                                        },
                                        child: const Icon(Icons.clear)),
                                  )),
                            ),
                            subtitle: Transform.translate(
                              offset: const Offset(0, -15),
                              child: Row(
                                children: <Widget>[
                                  const Expanded(
                                    child: Divider(
                                      thickness: 1.0,
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(234, 232, 232, 1)),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 32,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -68),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                    'assets/images/icons/dotted-line.png')),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -76),
                          child: ListTile(
                            minVerticalPadding: 0,
                            dense: true,
                            leading: const Icon(
                              Icons.add_location,
                              size: 30,
                            ),
                            title: GestureDetector(
                                onTap: () async {
                                  var roundTripDestinationPlace =
                                      await PlacesAutocomplete.show(
                                          context: context,
                                          apiKey: GOOGLE_MAP_API_KEY,
                                          mode: Mode.overlay,
                                          types: [],
                                          strictbounds: false,
                                          onError: (err) {
                                            print(err);
                                          });

                                  if (roundTripDestinationPlace != null) {
                                    final glist = GoogleMapsPlaces(
                                      apiKey: GOOGLE_MAP_API_KEY,
                                      apiHeaders: await const GoogleApiHeaders()
                                          .getHeaders(),
                                    );
                                    String roundTripPlaceId =
                                        roundTripDestinationPlace.placeId ??
                                            "0";
                                    final detail = await glist
                                        .getDetailsByPlaceId(roundTripPlaceId);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;
                                    String roundTripLimitedDestinationLocation =
                                        roundTripDestinationPlace.description !=
                                                    null &&
                                                roundTripDestinationPlace
                                                        .description!.length >
                                                    30
                                            ? "${roundTripDestinationPlace.description!.substring(0, 30)}..."
                                            : roundTripDestinationPlace
                                                    .description ??
                                                "";

                                    setState(() {
                                      roundTripDestinationLocation =
                                          (roundTripDestinationPlace.description
                                                          ?.length ??
                                                      0) >
                                                  30
                                              ? "$roundTripLimitedDestinationLocation..."
                                              : roundTripLimitedDestinationLocation;
                                    });
                                  }
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  minVerticalPadding: 0,
                                  dense: true,
                                  title: Text(
                                      roundTripDestinationLocation.isNotEmpty
                                          ? roundTripDestinationLocation
                                          : 'Destination Location',
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          roundTripDestinationLocation = '';
                                        });
                                      },
                                      child: const Icon(Icons.clear)),
                                )),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -60),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18, left: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Departure Date',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.4)),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                DateTime? datePicked =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            selectedDate,
                                                        firstDate:
                                                            DateTime(2024),
                                                        lastDate:
                                                            DateTime(2030));

                                                if (datePicked != null) {
                                                  setState(() {
                                                    selectedDate = datePicked;
                                                  });
                                                }
                                              },
                                              child: const Icon(
                                                Icons.calendar_month,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.4),
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              selectedDate != null
                                                  ? DateFormat('dd MMMM, yyyy')
                                                      .format(selectedDate)
                                                  : 'Select a date',
                                              style: GoogleFonts.lato(
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                        'assets/images/icons/vertical-line.png'),
                                    Column(
                                      children: [
                                        Text(
                                          'Return Date',
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.4)),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                DateTime? datePicked2 =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            selectedDate2,
                                                        firstDate:
                                                            DateTime(2024),
                                                        lastDate:
                                                            DateTime(2030));

                                                if (datePicked2 != null) {
                                                  setState(() {
                                                    selectedDate2 = datePicked2;
                                                  });
                                                }
                                              },
                                              child: const Icon(
                                                Icons.calendar_month,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.4),
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              selectedDate2 != null
                                                  ? DateFormat('dd MMMM, yyyy')
                                                      .format(selectedDate2)
                                                  : 'Select a date',
                                              style: GoogleFonts.lato(
                                                  color: const Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          'assets/images/icons/search-places.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Search Near by Places',
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: const Color.fromRGBO(
                                                217, 115, 122, 1)),
                                      )
                                    ],
                                  ),
                                ),
                                _shoppix_mall(),
                                const Divider(),
                                _shoppix_mall(),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'Popular Places',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: const Color.fromRGBO(
                                          217, 115, 122, 1)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _shoppix_mall(),
                                const Divider(),
                                _shoppix_mall(),
                                const Divider(),
                                _shoppix_mall(),
                                const Divider(),
                                _shoppix_mall(),
                                const Divider(),
                                _shoppix_mall(),
                              ],
                            ),
                          ),
                        )
                      ]),
                    GestureDetector(
                      onTap: () async {
                        HapticFeedback.heavyImpact();
                        List<double>? sourceCoordinates;
                        List<double>? destinationCoordinates;
                        List<double>? roundTripSourceCoordinates;
                        List<double>? roundTripMoreCoordinates;
                        List<double>? roundTripDestinationCoordinates;

                        if (_destination == Destination.one_way_trip &&
                            sourceLocation.isNotEmpty &&
                            destinationLocation.isNotEmpty) {
                          sourceCoordinates =
                              await getCoordinates(sourceLocation);
                          destinationCoordinates =
                              await getCoordinates(destinationLocation);
                        } else if (_destination == Destination.round_trip &&
                            // sourceLocation.isNotEmpty &&
                            // destinationLocation.isNotEmpty &&
                            roundTripSourceLocation.isNotEmpty &&
                            roundTripMoreLocation.isNotEmpty &&
                            roundTripDestinationLocation.isNotEmpty) {
                          // sourceCoordinates =
                          //     await getCoordinates(sourceLocation);
                          // destinationCoordinates =
                          //     await getCoordinates(destinationLocation);
                          roundTripSourceCoordinates =
                              await getRoundTripCoordinates(
                                  roundTripSourceLocation);
                          roundTripMoreCoordinates =
                              await getRoundTripCoordinates(
                                  roundTripMoreLocation);
                          roundTripDestinationCoordinates =
                              await getRoundTripCoordinates(
                                  roundTripDestinationLocation);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home_screen_1(
                              sourceLocation: sourceLocation,
                              destinationLocation: destinationLocation,
                              sourceCoordinates: sourceCoordinates,
                              destinationCoordinates: destinationCoordinates,
                              roundTripSourceLocation: roundTripSourceLocation,
                              roundTripMoreLocation: roundTripMoreLocation,
                              roundTripDestinationLocation:
                                  roundTripDestinationLocation,
                              roundTripSourceCoordinates:
                                  roundTripSourceCoordinates,
                              roundTripMoreCoordinates:
                                  roundTripMoreCoordinates,
                              roundTripDestinationCoordinates:
                                  roundTripDestinationCoordinates,
                              isRoundTrip: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 35, left: 18, right: 18),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(123, 30, 52, 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'Search',
                          style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ])),
            )));
  }

  _shoppix_mall() {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0),
      leading: const Icon(
        Icons.add_location,
        size: 30,
      ),
      title: Text(
        'Shoppix Mall',
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        'Surya Place Colony, Meerut,Uttar Pradesh 25...',
        style: GoogleFonts.poppins(
            fontSize: 12, color: const Color.fromRGBO(59, 65, 86, 0.7)),
      ),
      trailing: Container(
        width: 30,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(194, 33, 44, 1), shape: BoxShape.circle),
        child: const Center(
            child: Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        )),
      ),
    );
  }
}
