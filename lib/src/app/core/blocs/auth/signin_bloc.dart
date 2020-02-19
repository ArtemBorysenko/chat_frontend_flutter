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

  SigninBloc(String email, String password) {
    signinApi.login(email, password).then((token) {
      token = token;
      _syncController.sink
          .add(token);
    });
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
