import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/api/auth/signin_api.dart';
import 'package:chat_frontend_flutter/src/app/api/dialog_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;

class SigninBloc {

  // final IO.Socket _socket = IO.io('http://10.0.2.2:3003/', <String, dynamic>{
  //   'transports': ['websocket'],
  // });

  // IO.Socket get socket => _socket;

  String accessToken;

  StreamController _syncController =
      StreamController<String>.broadcast();
  Stream get outDialogBloc => _syncController.stream;

  StreamController _cmdController =
      StreamController<String>.broadcast();
  StreamSink get getDialogBloc => _cmdController.sink;

  Map<String, dynamic> values = { "token": "asdasd" };

  SigninBloc(String email, String password) {
    signinApi.login(email, password).then((token) async {
      accessToken = token;
      // print(token);
      
      // _syncController.sink
      //     .add(token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("accessToken", token);
        //  print("prefs.getString('accessToken') : ${prefs.getString('accessToken')}");
    });
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
