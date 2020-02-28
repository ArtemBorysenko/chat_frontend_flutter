import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/core/blocs/auth/signup_bloc.dart';


class RegistrationPage extends StatefulWidget {
  static String tag = "Login Page";
  
  @override
  State<StatefulWidget> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  String emailValue = "";
  String fullnameValue = "";
  String passwordValue = "";

  @override
  Widget build(BuildContext context){

  final SignupBloc signupBloc = Provider.of<SignupBloc>(context);

        final Widget fullname = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(hintText: 'Fullname',),
            onChanged: (String str){
                    setState((){
                      fullnameValue = str;
                    });
                  }
    );

    final Widget email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(hintText: 'Email',),
            onChanged: (String str){
                    setState((){
                      emailValue = str;
                    });
                  }
    );

    final Widget password = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Password',),
            onChanged: (String str){
                    setState((){
                      passwordValue = str;
                    });
                  }
    );

    final Widget singup = RaisedButton(
      child: Text("Sing Up"),
      onPressed: () { 
        signupBloc.registration(emailValue, fullnameValue, passwordValue);
      }
    );

    final Widget streamBuild = StreamBuilder(
      stream: signupBloc.outDialogBloc,
      builder: (BuildContext context, snapshot){
        if (!snapshot.hasData) return new Text('Loading...');
        return new  ListTile(
                        title: new Text('Login: ${snapshot.data.fullname}'),
                        subtitle: new Text(snapshot.data.email),
                      );
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                  fullname,
                  email,
                  password,
                  singup,
                  streamBuild,
            ],
          ),
        ),
      )
    );
  }
}