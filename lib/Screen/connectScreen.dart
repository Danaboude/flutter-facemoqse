import 'package:facemosque/providers/respray.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';

class ConnectScreen extends StatelessWidget {
  static const routeName = '/connect';

  @override
  Widget build(BuildContext context) {
    List<String> ips = Provider.of<Respray>(context).Ips;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    var sizedphone = MediaQuery.of(context).size;
    final List<bool> _selected =
        List.generate(ips.length, (i) => false); // Fill it with false initially
    GroupButtonController settingController = GroupButtonController();

    String ipselected = '';
    print(ips);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
            Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () =>
                  Navigator.of(context).pop(),
            ),
          ),
          SizedBox(
            height: sizedphone.height * 0.06,
          ),
          Align(
            child: Text(
              language['Serach for Respray IP'],
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(
            height: sizedphone.height * 0.05,
          ),
          Container(
            height: sizedphone.height * 0.67,
            width: sizedphone.width,
            decoration: BoxDecoration(),
            child: ListView(children: [
              GroupButton(
                controller: settingController,
                isRadio: true,
                options: GroupButtonOptions(
                    borderRadius: BorderRadius.circular(25),
                    groupingType: GroupingType.column,
                    buttonHeight: sizedphone.height * 0.1,
                    buttonWidth: sizedphone.width * 0.9,
                    unselectedTextStyle:
                        TextStyle(fontSize: 18, color: Colors.black),
                    selectedTextStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                onSelected: (index, isSelected, t) {
                  ipselected = index.toString();
                  print('$ipselected button is selected');
                },
                buttons: ips,
              ),
            ]),
          ),
          SizedBox(
            height: sizedphone.height * 0.04,
          ),
          ElevatedButton(
              child: Text(language['Choose ip']),
              onPressed: () async {
                Provider.of<Respray>(context, listen: false)
                    .setipaddress(ipselected);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(13)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )))),
        ],
      )),
    );
  }
}
