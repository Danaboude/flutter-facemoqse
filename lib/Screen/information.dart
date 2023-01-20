import 'package:facemosque/Screen/adminControlScreen.dart';
import 'package:facemosque/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';

class Information extends StatelessWidget {
    static const routeName = '/information';

  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        User user = Provider.of<Auth>(context).user!;
            Map language = Provider.of<Buttonclickp>(context).languagepro;


    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Align(
            alignment: Alignment.topLeft,
            child:  IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AdminControlScreen.routeName);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
          ),
          Center(child: Text(language['Mosque Name'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.name),),
          Center(child: Text(language['Mosque ID'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.mosqueid),),
          Center(child: Text(language['Address'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.street+' '+user.mosques.houseno+','+user.mosques.zip),),
          Center(child: Text('Mac',style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.mac),),
          Center(child: Text(language['Prauer_Method'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.asr_method),),
          Center(child: Text(language['StatUs'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.status),),
          Center(child: Text(language['Date Of Start'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.dateofstart),),
          Center(child: Text(language['Actibation Code'],style: TextStyle(fontWeight: FontWeight.bold),)),
          Center(child: Text(user.mosques.activationcode),),

        ]),
      ),
    );
  }
}
