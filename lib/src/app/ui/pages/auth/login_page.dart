import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/ui/pages/dialogs_page.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/api/auth/signin_api.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/auth/signin_bloc.dart';

class LoginPage extends StatefulWidget {
  static String tag = "Login Page";
  
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  String emailValue = "";
  String passwordValue = "";

  @override
  Widget build(BuildContext context){

    final Widget email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Email',),
      onChanged: (String str){
                    setState((){
                      emailValue = str;
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
        SigninBloc signinBloc = SigninBloc(emailValue, passwordValue);
        
        // if(signinBloc.accessToken.isEmpty) return 1;//TODO
        // else 
    //     Navigator
    //     .of(context)
    //     .push(MaterialPageRoute(builder: (BuildContext context) {
    //       return Provider<DialogsBloc>(
    //       create: (context) => DialogsBloc(),
    //       dispose: (context, value) => value.dispose(),
    //       child: DialogsPage(),
    //    );
    // }));
      },
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
                ]
          ),
        ),
      )
    );
  }
}