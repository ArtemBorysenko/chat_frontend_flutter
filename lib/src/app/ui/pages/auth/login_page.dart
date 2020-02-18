import 'package:flutter/material.dart';

import 'package:chat_frontend_flutter/src/app/data/api/auth/signin_api.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/auth/signin_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  static String tag = "Login Page";
  
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  String loginValue = "";
  String passwordValue = "";

  @override
  Widget build(BuildContext context){

    final Widget email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Email',),
      onChanged: (String str){
                    setState((){
                      loginValue = str;
                    });
                  }
    );

    final Widget password = TextField(
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Password',),
      onChanged: (String str){
                    setState((){
                      passwordValue = str;
                    });
                  }
    );


    final Widget button = RaisedButton(
      child: Text("Sign In"),
      onPressed: () { 
        SigninBloc signinBloc = SigninBloc(loginValue, passwordValue);
      },
    );


     _incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setInt('counter', 0);
  int counter = (prefs.getInt('counter') ?? 0) + 1;
   print('Pressed $counter times.');
  await prefs.setInt('counter', counter);

  //       final prefs = await SharedPreferences.getInstance();
  //       final key = 'my_int_key';
  //       final value = 42;
  //       prefs.setInt(key, value);
  //       print('saved $value');

  //       final prefs = await SharedPreferences.getInstance();
  //       final key = 'my_int_key';
  //       final value = prefs.getInt(key) ?? 0;
  //       print('read: $value');
      };


    final Widget increment = RaisedButton(
      child: Text("Increment"),
      onPressed: () { 
      // SharedPreferences.setMockInitialValues ({"1": "23"});
    _incrementCounter();
      }
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                  email,
                  password,
                  button,
                  increment,
                ]
          ),
        ),
      )
    );
  }
}