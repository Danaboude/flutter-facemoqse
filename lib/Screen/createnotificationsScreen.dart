import 'package:facemosque/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';
import '../providers/http_exception.dart';

class CreatenotificationsScreen extends StatefulWidget {
  static const routeName = '/evetnotification';

  @override
  State<CreatenotificationsScreen> createState() =>
      _CreatenotificationsScreen();
}

enum MassageMode { Even, NoEven }

class _CreatenotificationsScreen extends State<CreatenotificationsScreen> {
  final _titleController = TextEditingController();
  final _datapickerController = TextEditingController();
  final _numberController = TextEditingController();
  final _TimeController = TextEditingController();
  final _MessageController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey();

  MassageMode _massageMode = MassageMode.NoEven;
  bool switchstate = false;
  void _switchMassageMode(bool b) {
    if (_massageMode == MassageMode.Even) {
      setState(() {
        _massageMode = MassageMode.NoEven;
        switchstate = b;
        _TimeController.clear();
        _numberController.clear();
        _datapickerController.clear();
      });
    } else {
      setState(() {
        _massageMode = MassageMode.Even;
        switchstate = b;
      });
    }
  }

 

  @override
  Widget build(BuildContext context) {
    bool status = false;
    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
                Container(
           
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () =>
                  Navigator.of(context).pop(),
            ),
          ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(language['Event Noititcations'],
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(height: sizedphone.height * 0.01),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: language['Title'],
                    fillColor: Theme.of(context).primaryColor,
                    filled: false,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    if (val!.isEmpty) return language['fill TextFild'];
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _MessageController,
                  decoration: InputDecoration(
                    labelText: language['Message'],
                    fillColor: Theme.of(context).primaryColor,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val!.isEmpty) return throw HttpException( language['fill TextFild']);
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
                  Row(
                    children: [
                      Text(language['Event']),
                      Switch(
                        value: switchstate,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (b) => _switchMassageMode(b),
                      ),
                    ],
                  ),
                  SizedBox(),
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 150.0,
                    child: ElevatedButton(
                        child: Text(language['SEND']),
                        onPressed: () {
                          try {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<Auth>(context, listen: false).sendtotaipc(
                                _titleController.text,
                                _MessageController.text,
                                switchstate,
                                _TimeController.text,
                                _datapickerController.text,
                                _numberController.text);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                title: Text(language['Success']),
                                content:
                                    Text(language['You\'r Register Success']),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                            });}
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
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(13)),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))),
                  ),
                ],
              ),
              Visibility(
                visible: switchstate,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    enabled: _massageMode == MassageMode.Even,
                    decoration: InputDecoration(
                        labelText: language['Maximum number Persons']),
                    controller: _numberController,
                    keyboardType: TextInputType.number,
        
                    // obscureText: true,
                    validator: _massageMode == MassageMode.Even
                        ? (val) {
                            if (val == '') return language['set Number'];
                            return null;
                          }
                        : null,
                  ),
                ),
              ),
              Visibility(
                visible: switchstate,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    enabled: _massageMode == MassageMode.Even,
                    decoration: InputDecoration(
                        labelText: language['Date of Brith YYYY-MM-DD']),
                    controller: _datapickerController,
                    keyboardType: TextInputType.none,
                    onTap: () async {
                      DateTime? newdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1,
                              DateTime.now().month, DateTime.now().day));
                      if (newdate == null) return;
                      DateFormat formatter = DateFormat('yyyy-MM-dd');
        
                      _datapickerController.text = formatter.format(newdate);
                    },
                    // obscureText: true,
                    validator: _massageMode == MassageMode.Even
                        ? (val) {
                            if (val == '') return language['set You\'r Date'];
                            return null;
                          }
                        : null,
                  ),
                ),
              ),
              Visibility(
                visible: switchstate,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    enabled: _massageMode == MassageMode.Even,
                    decoration:
                        InputDecoration(labelText: language['Date of time']),
                    controller: _TimeController,
                    keyboardType: TextInputType.none,
                    onTap: () async {
                      var timep = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (timep == null) return;
        
                      _TimeController.text = '${timep.hour}:${timep.minute}';
                    },
                    // obscureText: true,
                    validator: _massageMode == MassageMode.Even
                        ? (val) {
                            if (val == '') return language['set a Time'];
                            return null;
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
