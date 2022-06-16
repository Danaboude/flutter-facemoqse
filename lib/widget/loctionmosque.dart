/*import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMosque extends StatefulWidget {
  const LocationMosque({Key? key}) : super(key: key);

  @override
  State<LocationMosque> createState() => _LocationMosque();
}

class _LocationMosque extends State<LocationMosque> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42, -122.96), zoom: 2);
  Set<Marker> marker = Set();

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      initialCameraPosition: initialCameraPosition,
      markers: marker,
        myLocationEnabled: true,

      zoomControlsEnabled: false,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller){
        googleMapController=controller;
      },
    );
  }
}*/
