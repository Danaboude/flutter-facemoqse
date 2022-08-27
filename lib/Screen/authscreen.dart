import 'package:facemosque/Screen/adminControlScreen.dart';
import 'package:facemosque/Screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/buttonclick.dart';
class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deciceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration:
                  BoxDecoration(boxShadow: [BoxShadow(color: Colors.white12)]),
              height: deciceSize.height,
              width: deciceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deciceSize.height * 0.04,
                  ),
                  Flexible(
                      child: Image.asset(
                    'assets/images/logoa.png',
                    height: deciceSize.height * 0.3,
                    width: deciceSize.width * 0.9,
                  )),
                  Flexible(
                    child: AuthCard(),
                    flex: deciceSize.width > 600 ? 2 : 6,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () =>
                  Navigator.of(context).pushNamed(HomeScreen.routeName),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  State<AuthCard> createState() => _AuthCardState();
}

enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  AuthMode _authMode = AuthMode.Login;

  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _datapickerController = TextEditingController();
  final _macController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAimaton;
  @override
  void initState() {
    super.initState();
    Provider.of<Auth>(context, listen: false).readuser();
    _usernameController.text = 'mbd';
    _passwordController.text = '123456';
    // getDeviceName();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.15),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAimaton = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  /*
  void getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceName = iosInfo.utsname.machine;
      }
    } catch (e) {
      print(e);
    }
  }
 */

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> submit() async {
  

    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_usernameController.text, _passwordController.text);

      Navigator.of(context).pushReplacementNamed(AdminControlScreen.routeName);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> register() async {

    try {
      await Provider.of<Auth>(context, listen: false).register(
          _usernameController.text,
          _fnameController.text,
          _lnameController.text,
          _passwordController.text,
          _emailController.text,
          _datapickerController.text,
          _macController.text);
      Navigator.of(context).pushReplacementNamed(AdminControlScreen.routeName);

      // Navigator.of(context).pop();

    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deciceSize = MediaQuery.of(context).size;
    // String token=Provider.of<Auth>(context).token;
        Map language = Provider.of<Buttonclickp>(context).languagepro;


    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.SignUp
            ? deciceSize.height * 0.9
            : deciceSize.height * 0.4,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.SignUp
              ? deciceSize.height * 0.9
              : deciceSize.height * 0.5,
        ),
        width: deciceSize.width * 0.9,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText:language ['username'],
                  fillColor: Theme.of(context).primaryColor,
                  filled: false,
                ),
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val!.isEmpty) return language['enterusername'];
                  return null;
                },
               
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.SignUp ? 25 : 0,
                  maxHeight: _authMode == AuthMode.SignUp ? 80 : 0,
                ),
                child: FadeTransition(
                  opacity: _opacityAimaton,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration:
                           InputDecoration(labelText: language['firstname']),
                      controller: _fnameController,
                      // obscureText: true,
                      validator: _authMode == AuthMode.SignUp
                          ? (val) {
                              if (val == '') return language['setyouname'];
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.SignUp ? 25 : 0,
                  maxHeight: _authMode == AuthMode.SignUp ? 50 : 0,
                ),
                child: FadeTransition(
                  opacity: _opacityAimaton,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration:  InputDecoration(labelText: language['lastname']),
                      controller: _lnameController,
                      // obscureText: true,
                      validator: _authMode == AuthMode.SignUp
                          ? (val) {
                              if (val == '') return language['setyoulastname'];
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: language['Password']),
                obscureText: true,
                controller: _passwordController,
                validator: (val) {
                  if (val!.isEmpty || val.length < 5)
                    return language['passowrdisshort'];
                  return null;
                },
              
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.SignUp ? 25 : 0,
                  maxHeight: _authMode == AuthMode.SignUp ? 50 : 0,
                ),
                child: FadeTransition(
                  opacity: _opacityAimaton,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration:
                           InputDecoration(labelText:language ['Confirm Password']),
                      obscureText: true,
                      validator: _authMode == AuthMode.SignUp
                          ? (val) {
                              if (val != _passwordController.text)
                                return language['Password do not match!'];
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.SignUp ? 25 : 0,
                  maxHeight: _authMode == AuthMode.SignUp ? 50 : 0,
                ),
                child: FadeTransition(
                  opacity: _opacityAimaton,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration:  InputDecoration(
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
                      validator: _authMode == AuthMode.SignUp
                          ? (val) {
                              if (val == '') return language['set You\'r Date'];
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.SignUp ? 25 : 0,
                  maxHeight: _authMode == AuthMode.SignUp ? 50 : 0,
                ),
                child: FadeTransition(
                  opacity: _opacityAimaton,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration:  InputDecoration(labelText: language['E-mail']),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val!.isEmpty || !val.contains('@'))
                          return language['Invalid Email'];
                        return null;
                      },
                    
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
                constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.SignUp ? 25 : 0,
                  maxHeight: _authMode == AuthMode.SignUp ? 50 : 0,
                ),
                child: FadeTransition(
                  opacity: _opacityAimaton,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.SignUp,
                      decoration: const InputDecoration(labelText: 'MAC'),
                      controller: _macController,
                      // obscureText: true,
                      validator: _authMode == AuthMode.SignUp
                          ? (val) {
                              if (val == '') return language['set You\'r MAC'];
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (_isLoading) CircularProgressIndicator(),
              RaisedButton(
                child: Text(_authMode == AuthMode.Login ?language ['LOGIN'] : language['SIGNUP']),
                onPressed: _authMode == AuthMode.Login ? submit : register,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _authMode == AuthMode.Login ? language['SIGNUP']:language ['LOGIN'] ,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                //color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
            Map language = Provider.of<Buttonclickp>(context).languagepro;

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title:  Center(child: Text(language['An Error Occurred'])),
              content: Text(errorMessage.toString()),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child:  Text(language['OK']),
                )
              ],
            ));
  }
}
