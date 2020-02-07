import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  static String tag = "Login Page";
  
  @override
  State<StatefulWidget> createState() => _RegistrationPageState();

}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context){

    final Widget email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(hintText: 'Email',),
    );

    final Widget fullname = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(hintText: 'Fullname',),
    );

    final Widget password = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Password',),
    );


    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            email,
            fullname,
            password,
          ]
        ),
      )
    );
  }
}