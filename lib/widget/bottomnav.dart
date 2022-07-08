import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    //list of Icon have 4 Icon
     List<Icon> items = <Icon>[
      Icon(
        //if you want to set color for icon 
      //  color: Color(0xffC29B0C),
        Icons.home,
        size: 30,
      ),
      Icon(
       //if you want to set color for icon 
      //  color: Color(0xffC29B0C),
        Icons.star,
        size: 30,
      ),
      Icon(
      //if you want to set color for icon 
      //  color: Color(0xffC29B0C),
        Icons.notifications_active,
        size: 30,
      ),
      Icon(
      //if you want to set color for icon 
      //  color: Color(0xffC29B0C),
        Icons.settings,
        size: 30,
      ),
    ];
    // indexnavigationbottmbar when user push Home icon index=0
    //or star icon index=1 ...
    int inde = Provider.of<Buttonclickp>(context).indexnavigationbottmbar;
    return CurvedNavigationBar(
      
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
        //give inde to CurvedNavigationBar when user push any icon it well update screan
        index: inde,
        height: 60,
        items: items,
        onTap: (index) {
          //when user push any icon it well update screan
          inde = index;
          Provider.of<Buttonclickp>(context, listen: false)
              .indexNavigationBar(inde);
        });
  }
}
