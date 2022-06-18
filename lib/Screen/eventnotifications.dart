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
        decoration: BoxDecoration(color: Color(0xFF1ea345),
                borderRadius: BorderRadius.circular(40)),
            margin: const EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        child: Text(language['eventnotifications'],style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      )
      ],
    );
    
  }
} 