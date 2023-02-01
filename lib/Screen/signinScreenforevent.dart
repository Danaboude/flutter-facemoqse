import 'package:facemosque/providers/messagesetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/buttonclick.dart';
import '../providers/fatchdata.dart';
import '../providers/messagefromtaipc.dart';
import '../providers/mosques.dart';

class SigninScreenforEvent extends StatefulWidget {
  static const routeName = '/signinforEvent';

  @override
  State<SigninScreenforEvent> createState() => _SigninScreenforEventtate();
}

class _SigninScreenforEventtate extends State<SigninScreenforEvent> {
  final _nomberController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firestnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    final argsmessage =
        ModalRoute.of(context)!.settings.arguments as MessageFromTaipc;
     Mosques       mosquesforevent = Provider.of<FatchData>(context).mosqueFollowevent;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:const Icon(Icons.arrow_back_ios)),),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: sizedphone.height * 0.02),
            Align(
              alignment: Alignment.topCenter,
              child: Text(language['Register'],
                  style: Theme.of(context).textTheme.headline2),
            ),
            SizedBox(height: sizedphone.height * 0.1),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _firestnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  fillColor: Theme.of(context).primaryColor,
                  filled: false,
                ),
                keyboardType: TextInputType.name,
                validator: (val) {
                  if (val!.isEmpty) return 'fill TextFild';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  fillColor: Theme.of(context).primaryColor,
                  filled: false,
                ),
                keyboardType: TextInputType.name,
                validator: (val) {
                  if (val!.isEmpty) return 'fill TextFild';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _nomberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  fillColor: Theme.of(context).primaryColor,
                  filled: false,
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) return 'fill TextFild';
                  return null;
                },
              ),
            ),
            SizedBox(
              height: sizedphone.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(language['Register']),
                  onPressed: () async{
                    try {
                   
                   String m= await  Provider.of<MessageSetting>(context, listen: false)
                          .senddatauserforevent(
                              _firestnameController.text,
                              _lastnameController.text,
                              _nomberController.text,
                              argsmessage,mosquesforevent.mosqueid);
                           
                      if (m=='"200"') {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: Text(language['Success']),
                            content: Text(language['You\'r Register Success']),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                       
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            title: Text(language['Erorr']),
                            content:language['Sorry, you cannot register'],
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(language['yes']),
                              ),
                            ],
                          ),
                        );
                
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          title: Text(language['Erorr']),
                          content: Text(e.toString()),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text(language['yes']),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      shadowColor: Theme.of(context).primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
                ElevatedButton(
                  child: Text(language['Cancel']),
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      shadowColor: Theme.of(context).primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
