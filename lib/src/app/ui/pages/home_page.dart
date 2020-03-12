import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_frontend_flutter/src/app/ui/pages/dialogs_page.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialogs_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/users_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/auth/signup_bloc.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/dialog_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chat_frontend_flutter/src/app/ui/pages/auth/login_page.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/auth/registration_page.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/dialog_page.dart';
import 'package:chat_frontend_flutter/src/app/ui/pages/users_page.dart';

class HomePage extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {

    // _func(context);

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
                  _openPageDialogs(context);
                },
              ),
              RaisedButton(
                child: Text('Users'),
                onPressed: () {
                  // _openPageUser(context);
                  _func(context);
                },
              ),
            ]),
      ),
    );
  }
}

_func(context) async {
  final prefs = await SharedPreferences.getInstance();
  print("prefs.getString('accessToken') : ${prefs.getString('accessToken')}");
  if (prefs.getString('accessToken') != null) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Provider<DialogsBloc>(
        create: (context) => DialogsBloc(),
        dispose: (context, value) => value.dispose(),
        child: DialogsPage(),
      );
    }));
  }
}

void _openPageLogin(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
}

void _openPageRegistration(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return Provider<SignupBloc>(
      create: (context) => SignupBloc(),
      dispose: (context, value) => value.dispose(),
      child: RegistrationPage(),
    );
  }));
}

void _openPageDialogs(BuildContext context) async {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    // return DialogsPage();
    return Provider<DialogsBloc>(
      create: (context) => DialogsBloc(),
      dispose: (context, value) => value.dispose(),
      child: DialogsPage(),
    );
  }));
}

void _openPageUser(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return Provider<UsersBloc>(
      create: (context) => UsersBloc(),
      dispose: (context, value) => value.dispose(),
      child: UsersPage(),
    );
  }));

  // Navigator.of(context)
  //     .push(MaterialPageRoute(builder: (BuildContext context) => DialogPage()));
}

// void _openPageDialogs(BuildContext context) async {
//   dialogsApi.getDialogs();
// }
