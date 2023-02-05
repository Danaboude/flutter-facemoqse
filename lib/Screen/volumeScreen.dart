import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../providers/buttonclick.dart';
import '../providers/respray.dart';

class VolumeScreen extends StatefulWidget {
  static const routeName = '/volume';

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  double _valslider = 100;

  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;

    return Scaffold(
      appBar: AppBar(leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:const Icon(Icons.arrow_back_ios)),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: sizedphone.height * 0.2,
            ),
            Container(
                height: sizedphone.height * 0.2,
                width: sizedphone.width * 0.3,
                child: Image.asset('assets/images/volume.png')),
            SizedBox(
              height: sizedphone.height * 0.1,
            ),
            SfSlider(
              onChanged: (value) {
                setState(() {
                  _valslider = value;
                });
              },
              value: _valslider,
              max: 100,
              min: 0,
              interval: 25,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              stepSize: 1,
            ),
            SizedBox(
              height: sizedphone.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    child: Text(language['Change Volume']),
                    onPressed: () async {
                      await Provider.of<Respray>(context, listen: false)
                          .sendudp('volume ${_valslider.toInt()}');
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                ElevatedButton(
                    child: Text(language['Mute']),
                    onPressed: () async {
                      _valslider = 0;
                      await Provider.of<Respray>(context, listen: false)
                          .sendudp('muted');
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(13)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
