import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';
import '../providers/respray.dart';

class Language {
  String lang;
  Language({
    required this.lang,
  });
}

class LanguageScreen extends StatelessWidget {
  static const routeName = '/language';

  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;

    Map language = Provider.of<Buttonclickp>(context).languagepro;

    List<Language> l = [
      //show word in en or ar as lebal
      Language(lang: language['englich']),
      Language(lang: language['arabic'])
    ];
    return Scaffold(
      appBar: AppBar(leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:const Icon(Icons.arrow_back_ios)),),
      body: SafeArea(
        child: Column(
          children: [
            //SizedBox(),
            Container(
              alignment: Alignment.center,
              width: sizedphone.width * 0.9,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Text(
                language['language'],
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Image.asset(
              'assets/images/lang.png'
            ),
            SizedBox(
              height: sizedphone.height * 0.14,
              width: sizedphone.width * 0.8,
              child: PopupMenuButton<Language>(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    language['selectlanguage'],
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                onSelected: (Language select) {
                  //if language ar
                  if (select.lang == 'عربي' || select.lang == 'Arabic') {
                    //it well change to en
                    // Provider.of<Buttonclickp>(context, listen: false)
                    //     .storelanguageformosque(true);
                    //if language en
                  } else if (select.lang == 'انكليزي' ||
                      select.lang == 'englich') {
                    //it well change to ar
                    // Provider.of<Buttonclickp>(context, listen: false)
                    //     .storelanguageformosque(false);
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
                      .map((item) => PopupMenuItem<Language>(
                            value: item,
                            child: Text(
                              item.lang,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ))
                      .toList();
                },
              ),
            ),
             ElevatedButton(
                    child: Text(language['Change Language']),
                    onPressed: () {
                      if (Provider.of<Buttonclickp>(context, listen: false)
                          .languageformosqueselected) {
                        Provider.of<Respray>(context, listen: false)
                            .sendudp('Arabic');
                      } else {
                        Provider.of<Respray>(context, listen: false)
                            .sendudp('English');
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
    );
  }
}
