import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/data/api/message_api.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;

class SigninBloc {
  StreamController _syncController =
      StreamController<String>.broadcast();
  Stream get outDialogBloc => _syncController.stream;

  StreamController _cmdController =
      StreamController<String>.broadcast();
  StreamSink get getDialogBloc => _cmdController.sink;

  create(dialogId, text){
    messageApi.create(dialogId, text).then((message) {
      _syncController.sink
          .add(message);
    });
  }

  SigninBloc(String email, String password) {
    
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
