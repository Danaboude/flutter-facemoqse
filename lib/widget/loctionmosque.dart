import 'package:facemosque/providers/fatchdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:provider/provider.dart';

class LoctionMosque extends StatefulWidget {
  @override
  State<LoctionMosque> createState() => _LoctionMosqueState();
}

class _LoctionMosqueState extends State<LoctionMosque> {
  late MapController mapController;
  @override
  void initState() {
mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    latlong.LatLng l = Provider.of<FatchData>(context).latlng1;
   
    return new FlutterMap(
      mapController: mapController,
      options: new MapOptions(
        center: l,
        zoom: 20.0,
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
      
    );
  }
}
