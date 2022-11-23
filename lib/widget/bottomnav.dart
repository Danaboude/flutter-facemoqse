import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:facemosque/Screen/eventnotifications.dart';
import 'package:facemosque/Screen/homescreen.dart';
import 'package:facemosque/Screen/musqScreen.dart';
import 'package:facemosque/Screen/settingsscreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

/*class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  */
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    int inde = Provider.of<Buttonclickp>(context).indexnavigationbottmbar;
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFF0e8028),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Mosques',
            backgroundColor: Color(0xFF0e8028),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
            backgroundColor: Color(0xFF0e8028),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color(0xFF0e8028),
          ),
        ],
        currentIndex: inde,
        selectedItemColor: Color(0xffD1B000),
        onTap: (index) {
          //when user push any icon it well update screan
          inde = index;
          Provider.of<Buttonclickp>(context, listen: false)
              .indexNavigationBar(inde);
        });
  }
}

/*
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

  */