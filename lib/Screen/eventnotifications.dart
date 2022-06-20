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
        decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(40)),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(12),
        alignment: Alignment.topCenter,
        child: Text(language['eventnotifications'], style: Theme.of(context).textTheme.headline1,),
      )
      ],
    );
    
  }
} 