import 'package:facemosque/providers/buttonclick.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventNotifications extends StatelessWidget {
  const EventNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //call Map(languagepro) from provider (Buttonclickp) return en language as default
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              // set color(icon app grean) form theme initlizt in main.dart
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40)),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          child: Text(
            //show value(ar,en) of key eventnotifications
            language['eventnotifications'],
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ],
    );
  }
}
