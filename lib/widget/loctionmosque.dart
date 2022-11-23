import 'dart:ffi';

import 'package:facemosque/providers/fatchdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:provider/provider.dart';
import 'package:mapbox_search/mapbox_search.dart';

class LoctionMosque extends StatefulWidget {
  @override
  State<LoctionMosque> createState() => _LoctionMosqueState();
}

class _LoctionMosqueState extends State<LoctionMosque> {
  late MapController mapController;
  final MAPBOX_KEY = '';
  List<MapBoxPlace> places = [];

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    //when user push any icon other ster it
    // well disable map
    mapController.dispose();
    super.dispose();
  }

  Future placesSearch(String apiKey) async {
    var placesService = PlacesSearch(
      apiKey: apiKey,
      limit: 5,
    );

    var places = await placesService.getPlaces(
      "Reichenhainer Strasse. 51",
    );

    for (var element in places!) {
      print(element.geometry!.coordinates);
    }
  }

  /*Future placesSearch(String apiKey, String Address, String House) async {
    var placesService = PlacesSearch(
      apiKey: apiKey,
      limit: 5,
    );

    print(Address + ". " + House);
    places = (await placesService.getPlaces(Address + ". " + House))!;
  }*/

  @override
  Widget build(BuildContext context) {
    double zoom = 18.0;
    var sizedphone = MediaQuery.of(context).size;

    latlong.LatLng l = Provider.of<FatchData>(context).latlng1;

    return Stack(
      children: [
        new FlutterMap(
          mapController: mapController,
          options: new MapOptions(
            //  debugMultiFingerGestureWinner: true,
            //  allowPanningOnScrollingParent: true,

            //set camera map from l
            center: l,
            zoom: zoom,
            maxZoom: 18,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZmFjZW1vc3F1ZSIsImEiOiJja2dwOTVkdzQwM21hMnZzMjQ1amJhaWxmIn0.fqW1E4WO3RSMu3tAPkz25g',
            ),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 80,
                  height: 80,
                  point: l,
                  builder: (ctx) => const Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.red,
                      )),
            ]),
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              margin: EdgeInsets.all(5),
              height: sizedphone.height * 0.06,
              width: sizedphone.width * 0.1,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(40)),
              child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    zoom = zoom - 1;
                    mapController.move(l, zoom);
                    print(zoom);
                  },
                  icon: Icon(Icons.zoom_out))),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              margin: EdgeInsets.all(5),
              height: sizedphone.height * 0.06,
              width: sizedphone.width * 0.1,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(40)),
              child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    if (zoom < 18) {
                      zoom = zoom + 1;
                      mapController.move(l, zoom);
                      print(zoom);
                    }
                  },
                  icon: Icon(Icons.zoom_in))),
        ),
      ],
    );
  }
}
