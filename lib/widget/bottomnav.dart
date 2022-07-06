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

    const items = <Widget> [
      Icon(
        Icons.home,
        size: 30,
      ),
      Icon(
        Icons.star,
        size: 30,
      ),
      Icon(
          Icons.notifications_active,
          size: 30,
        ),
      
      Icon(
        Icons.settings,
        size: 30,
      ),

    ];
    int inde = Provider.of<Buttonclickp>(context).indexnavigationbottmbar;
    return CurvedNavigationBar(

        animationDuration:const Duration(milliseconds: 500),
        backgroundColor: Colors.white,
       // buttonBackgroundColor:const Color(0xFFB7F8DB),
        color:Theme.of(context).primaryColor,
        
        index: inde,
        height: 60,
        items: items,
        onTap: (index) {
          
            // Navigator.of(context).pop();
              inde = index;
          
              Provider.of<Buttonclickp>(context, listen: false).indexNavigationBar(inde);
             
            });
  }
}