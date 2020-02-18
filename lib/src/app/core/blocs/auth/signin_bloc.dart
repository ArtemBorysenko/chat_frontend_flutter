import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/data/api/auth/signin_api.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialog_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;

class SigninBloc {
  StreamController _syncController =
      StreamController<String>.broadcast();
  Stream get outDialogBloc => _syncController.stream;

  StreamController _cmdController =
      StreamController<String>.broadcast();
  StreamSink get getDialogBloc => _cmdController.sink;

  String token;
  Map<String, dynamic> values = { "toekn": "asdasd" };

  _incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
   print('Pressed $counter times.');
  await prefs.setInt('counter', counter);
}

  SigninBloc(String login, String password) {
    signinApi.login(login, password).then((token) {
      token = token;
      _syncController.sink
          .add(token);
    });
    
    // SharedPreferences.setMockInitialValues (values);
    _incrementCounter();
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
