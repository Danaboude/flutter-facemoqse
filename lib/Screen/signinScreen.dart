import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/buttonclick.dart';






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


    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: SafeArea(child: 
      Flexible(
        child: Form(
          key: _formKey,
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            SizedBox(height: sizedphone.height*0.02),
            Align(alignment: Alignment.topCenter,child:Text(language['Register'],style: Theme.of(context).textTheme.headline2) ,),
            SizedBox(height: sizedphone.height*0.1),
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
                          if (val!.isEmpty)
                            return 'fill TextFild';
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
                          if (val!.isEmpty)
                            return 'fill TextFild';
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
                          if (val!.isEmpty)
                            return 'fill TextFild';
                          return null;
                        },
                       
                      ),
                    ),
                    SizedBox(height: sizedphone.height*0.1,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                      child: Text(language['Register']),
                      onPressed:submit ,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                      RaisedButton(
                      child: Text(language['Cancel']),
                      onPressed:()=>Navigator.of(context).pop() ,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                   ],)
              
              
            ],
          ),
        ),
      )
      ),
    );
    
  }

  void submit() {

  }
}