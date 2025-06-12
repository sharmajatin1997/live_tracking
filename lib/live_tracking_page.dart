import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_tracking/constants.dart';
import 'package:location/location.dart';

class LiveTrackingPage extends StatefulWidget {
  const LiveTrackingPage({super.key});

  @override
  State<LiveTrackingPage> createState() => _LiveTrackingPageState();
}

class _LiveTrackingPageState extends State<LiveTrackingPage> {
  final Completer<GoogleMapController> _googleMapController = Completer();

  LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  LatLng destinationLocation = LatLng(37.33429383, -122.06600055);

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkers();
    getPolyline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: MarkerId('source'),
            position: sourceLocation,
            icon: sourceIcon,
          ),
          Marker(
            markerId: MarkerId('destination'),
            position: destinationLocation,
            icon: destinationIcon,
          ),
          if (locationData != null)
            Marker(
              markerId: MarkerId('Current Location'),
              icon: currentLocation,
              position: LatLng(
                locationData!.latitude!,
                locationData!.longitude!,
              ),
            ),
        },
        onMapCreated: (controller) {
          _googleMapController.complete(controller);
        },
        polylines: {
          Polyline(
            polylineId: PolylineId('Routes'),
            points: polyPoints,
            width: 6,
            color: primaryColor,
          ),
        },
      ),
    );
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocation = BitmapDescriptor.defaultMarker;

  void setCustomMarkers() async {
    try {
      final iconResult = await Future.wait([
        BitmapDescriptor.asset(
          ImageConfiguration(size: Size(15, 28)),
          'assets/Pin_source.png',
        ),
        BitmapDescriptor.asset(
          ImageConfiguration(size: Size(24, 28)),
          'assets/Pin_destination.png',
        ),
        BitmapDescriptor.asset(
          ImageConfiguration(size: Size(38, 44)),
          'assets/Badge.png',
        ),
      ]);

      setState(() {
        sourceIcon = iconResult[0];
        destinationIcon = iconResult[1];
        currentLocation = iconResult[2];
      });
    } catch (e) {
      print(e);
    }
  }

  final PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polyPoints = [];

  void getPolyline() async {
    try {
      PolylineResult polylineResult = await polylinePoints
          .getRouteBetweenCoordinates(
            googleApiKey: 'GOOGLE_MAP_KEY',
            request: PolylineRequest(
              origin: PointLatLng(
                sourceLocation.latitude,
                sourceLocation.longitude,
              ),
              destination: PointLatLng(
                destinationLocation.latitude,
                destinationLocation.longitude,
              ),
              mode: TravelMode.driving,
              optimizeWaypoints: true,
            ),
          );
      if (polylineResult.points.isNotEmpty) {
        setState(() {
          polyPoints =
              polylineResult.points
                  .map((point) => LatLng(point.latitude, point.longitude))
                  .toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final Location location = Location();
  LocationData? locationData;

  void getCurrentLocation() async {
    try {
      LocationData currentLoc = await location.getLocation();
      setState(() {
        locationData = currentLoc;
      });

      final GoogleMapController controller = await _googleMapController.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLoc.latitude!, currentLoc.longitude!),
            zoom: 16,
            tilt: 59,
            bearing: -70,
          ),
        ),
      );
      location.onLocationChanged.listen((LocationData newLocation)async{
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocation.latitude!, newLocation.longitude!),
              zoom: 16,
              tilt: 59,
              bearing: -70,
            ),
          ),
        );

        setState(() {
          locationData=newLocation;
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
