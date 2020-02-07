import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = "Login Page";
  
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context){

    final Widget email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Email',),
    );

    final Widget password = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Password',),
    );

    final Widget button = IconButton(
      icon: Icon(Icons.volume_up),
      onPressed: () => { 
        print("sadas")
      },
    );

    final Widget button2 = RaisedButton(
      child: Text("button2"),
      onPressed: () => { 
        print("sadas")
      },
    );


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                email,
                password,
                button,
                button2,
              ]
        ),
      )
    );
  }
}