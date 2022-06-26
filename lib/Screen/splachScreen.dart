import 'dart:async';

import 'package:facemosque/Screen/homescreen.dart';
import 'package:facemosque/providers/buttonclick.dart';
import 'package:facemosque/providers/fatchdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  Timer? timer;
  @override
  void initState() {
    
    Provider.of<FatchData>(context, listen: false).fatchandsetallmosque();
    Provider.of<FatchData>(context, listen: false).readdata();
    timer = Timer.periodic(const Duration(hours: 3), (Timer t) {
      Provider.of<FatchData>(context, listen: false).fatchandsetallmosque(); });

    Provider.of<Buttonclickp>(context, listen: false).storereplacetoloc(null);
    Provider.of<Buttonclickp>(context, listen: false).readDaysWeek();
    Provider.of<Buttonclickp>(context, listen: false).getreplacetoloc();
    Provider.of<Buttonclickp>(context, listen: false).getreplacetoevent();
    Provider.of<Buttonclickp>(context, listen: false).readlanguage();
    Future.delayed(const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(1),
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              height: sizedphone.height * 0.3,
              width: sizedphone.width,
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
            
                color: Theme.of(context).primaryColor,
              
              height: sizedphone.height * 0.2,
              width: sizedphone.width,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(
                height: sizedphone.height * 0.1,
              ),
              SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? const Color(0xFFEACE09)
                          : Theme.of(context).primaryColor,
                    ),
                  );
                },
              ),
              SizedBox(
                height: sizedphone.height * 0.1,
              ),
              const Text('Wecome to Facemosque'),
            ],
          ),
        ],
      )),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: const Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
