import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/core/database/models/user_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/api/auth/signup_api.dart';
import 'package:chat_frontend_flutter/src/app/api/dialog_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:socket_io_client/socket_io_client.dart' as IO;

class SignupBloc {
  StreamController _syncController =
      StreamController<UserModel>.broadcast();
  Stream get outDialogBloc => _syncController.stream;

  StreamController _cmdController =
      StreamController<UserModel>.broadcast();
  StreamSink get getDialogBloc => _cmdController.sink;

  registration(String email, String fullname, String password){
    signupApi.registration(email, fullname, password).then((user) {
      user = user;
      _syncController.sink
          .add(user);
    });
  }

  SignupBloc() {
    
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
