import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'package:chat_frontend_flutter/src/app/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/models/dialogs_model.dart';
import 'package:chat_frontend_flutter/src/app/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/models/user_list_model.dart';

import 'package:chat_frontend_flutter/src/app/data/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/data/api/users_api.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class UsersBloc {


  StreamController<List<UserModel>> _syncController =
      StreamController<List<UserModel>>.broadcast();
  Stream<List<UserModel>> get outDialogsBloc => _syncController.stream;

  StreamController<List<UserModel>> _cmdController =
      StreamController<List<UserModel>>.broadcast();
  StreamSink get getDialogsBloc => _cmdController.sink;

  UserListModel _usersist;

  UsersBloc() {
    usersApi.getUsers().then((list) {
      _usersist = list;
      _syncController.sink
          .add(UnmodifiableListView<UserModel>(_usersist.users));
    });
  }

  UserListModel initionalData() {
    UserListModel data;
    usersApi.getUsers().then((list) {
      data = list;
    });
    return data;
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
