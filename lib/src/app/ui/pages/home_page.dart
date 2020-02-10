import 'package:chat_frontend_flutter/src/app/data/api/dialogs_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/ui/pages/dialogs_page.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/auth/login_page.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/auth/registration_page.dart';

import 'package:http/http.dart' as http;



class HomePage extends StatelessWidget {
  

    final TextEditingController controller = new TextEditingController();
    String result = "";

  @override
  Widget build(BuildContext context) {

  final DialogsBloc dialogsBloc = Provider.of<DialogsBloc>(context);


    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                _openPageLogin(context);
              },
            ),
            RaisedButton(
              child: Text('Registration'),
              onPressed: () {
                _openPageRegistration(context);
              },
            ),
            RaisedButton(
              child: Text('Dialogs'),
              onPressed: () {
                _openPageDialogs(context, dialogsBloc);
              },
            ),
                ]
        ),
      ),
    );
}

}


  void _openPageLogin(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()
    ));
  }

    void _openPageRegistration(BuildContext context) {
    Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => RegistrationPage()
    ));
  }

void _openPageDialogs(BuildContext context, DialogsBloc dialogsBloc) async {
                 
     Navigator
        .of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Provider<DialogsBloc>(
        create: (context) => DialogsBloc(),
        dispose: (context, value) => value.dispose(),
        child: DialogsPage(),
      );
    }));
  dialogsBloc.getDialogsBloc.add(null);
  }

  // void _openPageDialogs(BuildContext context) async {
  //   dialogsApi.getDialogs();
  // }

  