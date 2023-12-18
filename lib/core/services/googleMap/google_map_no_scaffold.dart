import 'dart:async';

import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_import;
import 'package:permission_handler/permission_handler.dart';

class GoogleMapWithoutScaffold extends StatefulWidget {
  final dynamic cubit;

  const GoogleMapWithoutScaffold({super.key, required this.cubit});

  @override
  State<GoogleMapWithoutScaffold> createState() => _GoogleMapWithoutScaffoldState();
}

class _GoogleMapWithoutScaffoldState extends State<GoogleMapWithoutScaffold> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    requestLocation();
    // _getLocation();
    super.initState();
  }

  Future<void> _moveCameraToMyLocation() async {
    final currentLocation = await getCurrentLocation();
    final cameraUpdate = CameraUpdate.newLatLngZoom(
      currentLocation,
      11.0, // adjust zoom level as needed
    );
    _markers[0] = Marker(markerId: const MarkerId('myMarker'), position: LatLng(currentLocation.latitude, currentLocation.longitude));

    final GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(cameraUpdate);
    _getLocation();
    setState(() {});
  }

  void _getLocation({LatLng? currentLocation}) async {
    final location = location_import.Location();
    List<Placemark>? placeMarks;
    debugPrint('object');
    try {
      if (currentLocation == null) {
        await location.getLocation().then((value) {
          currentLocation = LatLng(value.latitude!, value.longitude!);
        });
      }

      placeMarks = await placemarkFromCoordinates(
        currentLocation!.latitude,
        currentLocation!.longitude,
      );
      locationCache = '${placeMarks[0].locality}';
      widget.cubit.changeElevatorType();

      debugPrint('currentLocation ${placeMarks[0].locality}');
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<LatLng> getCurrentLocation() async {
    final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('(location.toJson() ${location.toJson()}');
    return LatLng(location.latitude, location.longitude);
  }

  void requestLocation() async {
    final status = await Permission.location.request();
    if (status.isDenied) showToast('You must allow us to locate you');
  }

  final List<Marker> _markers = [
    Marker(
      markerId: const MarkerId('myMarker'),
      position: cairoLatLng,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.screenHeight * .36,
          decoration: BoxDecoration(border: Border.all(color: AppColors.grey)),
          child: GoogleMap(
            mapType: MapType.terrain,
            markers: Set.from(_markers),
            initialCameraPosition: CameraPosition(
              target: cairoLatLng,
              zoom: 11,
            ),
            onTap: (argument) {
              _markers[0] = Marker(markerId: const MarkerId('myMarker'), position: LatLng(argument.latitude, argument.longitude));
              _getLocation(currentLocation: argument);
              setState(() {});
            },
            onCameraMove: (position) {
              _markers[0] = Marker(markerId: const MarkerId('myMarker'), position: LatLng(position.target.latitude, position.target.longitude));
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        10.ESH(),
        CustomTextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined),
              5.ESW(),
              Text(
                'Detect my location',
                style: Styles.style16700.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
          onPress: () => _moveCameraToMyLocation(),
        ),
      ],
    );
  }
}
