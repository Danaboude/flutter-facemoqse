import 'package:facemosque/providers/messagesetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/buttonclick.dart';
import '../providers/messagefromtaipc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class contactUs extends StatefulWidget {
  static const routeName = '/contactUs';

  @override
  State<contactUs> createState() => _contactUs();
}

class _contactUs extends State<contactUs> {
  final _NameController = TextEditingController();
  final _emailController = TextEditingController();
  final _TypeController = TextEditingController();
  final _PhoneController = TextEditingController();
  final _MessageController = TextEditingController();
  String _errorMessage = '';

  String dropdownvalue = 'Suggestions';

  // List of items in our dropdown menu
  var items = [
    'Complain',
    'Suggestions',
  ];
  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    Map language = Provider.of<Buttonclickp>(context).languagepro;
    String _value = "";

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Wrap(spacing: 10, runSpacing: 10, children: [
                  Text(
                    "Contact US",
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  TextFormField(
                    controller: _NameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Your Name",
                        hintText: " Please Write your Name"),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                        hintText: ""),
                    onChanged: (value) {
                      _value = value;
                    },
                  ),
                  DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),

                  // After selecting the desired option,it will
                  // change button value to selected value

                  TextFormField(
                    controller: _PhoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Your Phone Number",
                        hintText: "Optional"),
                  ),
                  Text("Message:"),
                  TextField(
                    controller: _MessageController,
                    maxLines: 10,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (EmailValidator.validate(_value, false)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Invalid Email, Please write a valid Email")));
                      } else {
                        final Email send_email = Email(
                          body: 'body of email',
                          subject: 'subject of email',
                          recipients: ['ibrahimalnasser@outlook.com'],
                          
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(send_email);
                      }
                    },
                    child: Text("Submit"),
                  )
                ])))));
  }
}
