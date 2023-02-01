import 'package:facemosque/providers/respray.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';

class Screen {
  String screen;
  Screen({
    required this.screen,
  });
}

class ScreenScreen extends StatelessWidget {
  static const routeName = '/screen';

  @override
  Widget build(BuildContext context) {
    Map language = Provider.of<Buttonclickp>(context).languagepro;

    List<Screen> l = [
      //show word in en or ar as lebal
      Screen(screen: language['Always On']),
      Screen(screen: language['Default'])
    ];
    var sizedphone = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:const Icon(Icons.arrow_back_ios)),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: sizedphone.height * 0.2,
                ),
                Container(
                    height: sizedphone.height * 0.2,
                    width: sizedphone.width * 0.3,
                    child: Image.asset('assets/images/screen.png')),
                SizedBox(
                  height: sizedphone.height * 0.1,
                ),
                SizedBox(
                  height: sizedphone.height * 0.14,
                  width: sizedphone.width * 0.8,
                  child: PopupMenuButton<Screen>(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        language['Select'],
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    onSelected: (Screen select) {
                      //if language ar
                      if (select.screen == language['Always On']) {
                        //it well change to en
                        // Provider.of<Buttonclickp>(context, listen: false)
                        //     .storeScreen(true);
                        //if language en
                      } else if (select.screen == language['Default']) {
                        //it well change to ar
                        // Provider.of<Buttonclickp>(context, listen: false)
                        //     .storeScreen(false);
                      }
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    itemBuilder: (context) {
                      // l have 2 object en and ar well show in list
                      return l
                          .map((item) => PopupMenuItem<Screen>(
                                value: item,
                                child: Text(
                                  item.screen,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ))
                          .toList();
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text(language['Change Screen Mode']),
                    onPressed: () {
                      if (Provider.of<Buttonclickp>(context, listen: false)
                          .screenselected) {
                        Provider.of<Respray>(context, listen: false)
                            .sendudp('sleep_def');
                      } else {
                        Provider.of<Respray>(context, listen: false)
                            .sendudp('sleep_no');
                      }
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
            ),
          ),
        ),
      ),
    );
  }
}
