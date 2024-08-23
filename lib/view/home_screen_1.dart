import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class home_screen_1 extends StatefulWidget {
  final String? sourceLocation;
  final String? destinationLocation;
  final List<double>? sourceCoordinates;
  final List<double>? destinationCoordinates;

  final String? roundTripSourceLocation;
  final String? roundTripMoreLocation;
  final String? roundTripDestinationLocation;
  final List<double>? roundTripSourceCoordinates;
  final List<double>? roundTripMoreCoordinates;
  final List<double>? roundTripDestinationCoordinates;
  final bool isRoundTrip;

  const home_screen_1({
    Key? key,
    this.sourceLocation,
    this.destinationLocation,
    this.sourceCoordinates,
    this.destinationCoordinates,
    this.roundTripSourceLocation,
    this.roundTripMoreLocation,
    this.roundTripDestinationLocation,
    this.roundTripSourceCoordinates,
    this.roundTripMoreCoordinates,
    this.roundTripDestinationCoordinates,
    required this.isRoundTrip,
  }) : super(key: key);

  @override
  State<home_screen_1> createState() => _home_screen_1State();
}

class _home_screen_1State extends State<home_screen_1> {
  String googleApiKey = 'GOOGLE_MAP_API_KEY';
  GoogleMapController? mapController;

  LatLng sourceLatLang = const LatLng(0, 0);
  LatLng destinationLatLang = const LatLng(0, 0);

  LatLng roundTripSourceLatLang = const LatLng(0, 0);
  LatLng roundTripMoreLatLang = const LatLng(0, 0);
  LatLng roundTripDestinationLatLang = const LatLng(0, 0);

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> oneWayPolylineCoordinates = [];
  List<LatLng> roundTripPolylineCoordinates = [];

  @override
  void initState() {
    super.initState();

    if (widget.sourceCoordinates != null &&
        widget.sourceCoordinates!.isNotEmpty) {
      sourceLatLang =
          LatLng(widget.sourceCoordinates![0], widget.sourceCoordinates![1]);
    }

    if (widget.destinationCoordinates != null &&
        widget.destinationCoordinates!.isNotEmpty) {
      destinationLatLang = LatLng(
          widget.destinationCoordinates![0], widget.destinationCoordinates![1]);
    }

    if (widget.roundTripSourceCoordinates != null &&
        widget.roundTripSourceCoordinates!.isNotEmpty) {
      roundTripSourceLatLang = LatLng(widget.roundTripSourceCoordinates![0],
          widget.roundTripSourceCoordinates![1]);
    }

    if (widget.roundTripMoreCoordinates != null &&
        widget.roundTripMoreCoordinates!.isNotEmpty) {
      roundTripMoreLatLang = LatLng(widget.roundTripMoreCoordinates![0],
          widget.roundTripMoreCoordinates![1]);
    }

    if (widget.roundTripDestinationCoordinates != null &&
        widget.roundTripDestinationCoordinates!.isNotEmpty) {
      roundTripDestinationLatLang = LatLng(
          widget.roundTripDestinationCoordinates![0],
          widget.roundTripDestinationCoordinates![1]);
    }

    _updateMarkers();
    _getOneWayPolyline();
    _roundTripMarkers();
    _getRoundTripPolyline();
  }

  Future<Uint8List> _getBytesFromAsset(
      String path, int width, int height) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _updateMarkers() async {
    markers.clear();
    Uint8List markerIcon =
        await _getBytesFromAsset("assets/images/icons/cab.png", 120, 120);
    BitmapDescriptor markerBitmap = BitmapDescriptor.fromBytes(markerIcon);

    if (widget.sourceCoordinates != null &&
        widget.sourceCoordinates!.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId("source_place"),
          position: sourceLatLang,
          infoWindow: InfoWindow(
            title: "${widget.sourceLocation}",
            snippet: 'Pick Up Location',
          ),
          icon: markerBitmap,
        ),
      );
    }

    if (widget.destinationCoordinates != null &&
        widget.destinationCoordinates!.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId("destination_place"),
          position: destinationLatLang,
          infoWindow: InfoWindow(
            title: "${widget.destinationLocation}",
            snippet: 'Destination Location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  void _roundTripMarkers() async {
    markers.clear();
    Uint8List markerIcons =
        await _getBytesFromAsset("assets/images/icons/cab.png", 120, 120);
    BitmapDescriptor markerBitmap = BitmapDescriptor.fromBytes(markerIcons);

    if (widget.roundTripSourceCoordinates != null &&
        widget.roundTripSourceCoordinates!.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId("round_trip_source_place"),
          position: roundTripSourceLatLang,
          infoWindow: InfoWindow(
            title: "${widget.roundTripSourceLocation}",
            snippet: 'Round Trip Pick Up Location',
          ),
          icon: markerBitmap,
        ),
      );
    }

    if (widget.roundTripMoreCoordinates != null &&
        widget.roundTripMoreCoordinates!.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId("round_trip_additional_place"),
          position: roundTripMoreLatLang,
          infoWindow: InfoWindow(
            title: "${widget.roundTripMoreLocation}",
            snippet: 'Round Trip Additional Location',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    }

    if (widget.roundTripDestinationCoordinates != null &&
        widget.roundTripDestinationCoordinates!.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId("round_trip_destination_place"),
          position: roundTripDestinationLatLang,
          infoWindow: InfoWindow(
            title: "${widget.roundTripDestinationLocation}",
            snippet: 'Round Trip Destination Location',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  void _getOneWayPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLatLang.latitude, sourceLatLang.longitude),
      PointLatLng(destinationLatLang.latitude, destinationLatLang.longitude),
    );

    oneWayPolylineCoordinates.clear(); // Clear the polylineCoordinates list

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        oneWayPolylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      polylines.add(
        Polyline(
          polylineId: const PolylineId("poly"),
          color: const Color.fromARGB(255, 9, 117, 206),
          points: oneWayPolylineCoordinates,
          width: 5,
        ),
      );
    });
  }

  void _getRoundTripPolyline() async {
    PolylinePoints roundTripPolylinePoints = PolylinePoints();
    PolylineResult roundTripResult =
        await roundTripPolylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(
          roundTripSourceLatLang.latitude, roundTripSourceLatLang.longitude),
      PointLatLng(roundTripDestinationLatLang.latitude,
          roundTripDestinationLatLang.longitude),
    );

    roundTripPolylineCoordinates.clear(); // Clear the polylineCoordinates list

    if (roundTripResult.points.isNotEmpty) {
      for (var point in roundTripResult.points) {
        roundTripPolylineCoordinates
            .add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      polylines.add(
        Polyline(
          polylineId: const PolylineId("round_trip_poly"),
          color: const Color.fromARGB(255, 97, 155, 4),
          points: roundTripPolylineCoordinates,
          width: 5,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialCameraPosition =
        widget.isRoundTrip ? roundTripSourceLatLang : sourceLatLang;
    if (!widget.isRoundTrip) {
      initialCameraPosition = sourceLatLang;
    } else if (widget.sourceCoordinates != null) {
      initialCameraPosition = sourceLatLang;
    }
    return Scaffold(
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: initialCameraPosition,
          zoom: 12.0,
        ),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        markers: markers,
        polylines: polylines,
      ),
    );
  }
}
