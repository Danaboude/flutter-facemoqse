import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';
import '../providers/respray.dart';

class Themea {
  String theme;
  Themea({
    required this.theme,
  });
}

class ThemeScreen extends StatelessWidget {
  static const routeName = '/theme';

  @override
  Widget build(BuildContext context) {
    Map language = Provider.of<Buttonclickp>(context).languagepro;

    List<Themea> l = [
      //show word in en or ar as lebal
      Themea(theme: language['Black']),
      Themea(theme: language['White'])
    ];
    var sizedphone = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: sizedphone.height * 0.2,
                ),
                Image.asset('assets/images/theme.png'),
                SizedBox(
                  height: sizedphone.height * 0.1,
                ),
                SizedBox(
                  height: sizedphone.height * 0.14,
                  width: sizedphone.width * 0.8,
                  child: PopupMenuButton<Themea>(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text(
                        language['Select'],
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    onSelected: (Themea select) {
                      //if language ar
                      if (select.theme == language['White']) {
                        //it well change to en
                        Provider.of<Buttonclickp>(context, listen: false)
                            .storetheme(true);
                        //if language en
                      } else if (select.theme == language['Black']) {
                        //it well change to ar
                        Provider.of<Buttonclickp>(context, listen: false)
                            .storetheme(false);
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
                          .map((item) => PopupMenuItem<Themea>(
                                value: item,
                                child: Text(
                                  item.theme,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ))
                          .toList();
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text(language['Change Theme']),
                    onPressed: () async {
                      if (Provider.of<Buttonclickp>(context, listen: false)
                          .themeselected) {
                        await Provider.of<Respray>(context, listen: false)
                            .sendudp('White');
                      }else{
                         await Provider.of<Respray>(context, listen: false)
                            .sendudp('Black');
                        
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
