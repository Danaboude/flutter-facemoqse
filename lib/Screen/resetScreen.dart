import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';
import '../providers/respray.dart';
  class Reset {
  String reset;
  Reset({
    required this.reset,
  });
}

class ResetScreen extends StatelessWidget {
  static const routeName = '/reset';


  @override
  Widget build(BuildContext context) {
        Map language = Provider.of<Buttonclickp>(context).languagepro;

     List<Reset> l = [
      //show word in en or ar as lebal
      Reset(reset: language['Reset']),
      Reset(reset:language['Default'])
    ];
    var sizedphone = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(height: sizedphone.height*0.2,),
              Container(height: sizedphone.height*0.2,width: sizedphone.width*0.3,child: Image.asset('assets/images/reset.png')),
              SizedBox(height: sizedphone.height*0.1,),
               SizedBox(
                height: sizedphone.height * 0.14,
                width: sizedphone.width * 0.8,
                child: PopupMenuButton<Reset>(
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      language['Select'],
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  onSelected: (Reset select) {
                    //if language ar
                    if (select.reset == language['Reset']) {
                      //it well change to en
                      Provider.of<Buttonclickp>(context, listen: false)
                          .storereset(true);
                      //if language en
                    } else if (select.reset == language['Default']) {
                      //it well change to ar
                      Provider.of<Buttonclickp>(context, listen: false)
                          .storereset(false);
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
                        .map((item) => PopupMenuItem<Reset>(
                              value: item,
                              child: Text(
                                item.reset,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ))
                        .toList();
                  },
                ),),
                ElevatedButton(
                child: Text(language['Reset Mode']),
                onPressed: () async {
                        if (Provider.of<Buttonclickp>(context, listen: false)
                          .resetselected) {
                        await Provider.of<Respray>(context, listen: false)
                            .sendudp('reset');
                      }else{
                         await Provider.of<Respray>(context, listen: false)
                            .sendudp('default');
                        
                      }
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(13)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )))),

              
            ],),
          ),
        ),
      ),
    );
  }
}
