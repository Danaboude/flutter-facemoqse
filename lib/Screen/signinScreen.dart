import 'package:facemosque/providers/messagesetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/buttonclick.dart';
import '../providers/messagefromtaipc.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nomberController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firestnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    final argsmessage =
        ModalRoute.of(context)!.settings.arguments as MessageFromTaipc;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                RaisedButton(
                  child: Text(language['Register']),
                  onPressed: () {
                    try {
                      Provider.of<MessageSetting>(context, listen: false)
                          .senddatauserforevent(
                              _firestnameController.text,
                              _lastnameController.text,
                              _nomberController.text,
                              argsmessage);
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: Text('Success'),
                          content: Text('You\'r Register Success'),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                           shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                          title: Text('Erorr'),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  child: Text(language['Cancel']),
                  onPressed: () => Navigator.of(context).pop(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
