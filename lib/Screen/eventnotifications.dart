import 'package:facemosque/providers/buttonclick.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventNotifications extends StatelessWidget {
  const EventNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Map language= Provider.of<Buttonclickp>(context).languagepro;
    return Column(
      children: [
      Container(
        alignment: Alignment.topCenter,
        child: Text(language['eventnotifications'],style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      )
      ],
    );
    
  }
} 