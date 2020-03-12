import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/api/dialog_api.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/socket_bloc.dart';

import 'package:sqflite/sqflite.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class DialogsBloc {
  // static SocketBloc socketBloc = new SocketBloc();
  final IO.Socket _socket = socketBloc.socket;

  // DialogsBloc._();

  // static final DialogsBloc db = DialogsBloc._();

  //  DialogsBloc _dialogsBloc;

  // DialogsBloc get dialogsBloc {
  //   if (_dialogsBloc != null) return _dialogsBloc;
  //   // if _database is null we instantiate it
  //   _dialogsBloc = db;
  //   dialogsApi.getDialogs().then((list) {
  //     _dialogsList = list;
  //     _syncController.sink
  //         .add(UnmodifiableListView<DialogModel>(_dialogsList.dialogs));
  //   });
  //   return _dialogsBloc;
  // }

  // IO.Socket get socket => _socket;
  
  String partnerId;

  StreamController<List<DialogModel>> _syncController =
      StreamController<List<DialogModel>>.broadcast();
  Stream<List<DialogModel>> get outDialogsBloc => _syncController.stream;

  StreamController<List<DialogModel>> _cmdController =
      StreamController<List<DialogModel>>.broadcast();
  StreamSink get getDialogsBloc => _cmdController.sink;

  DialogListModel _dialogsList;

  DialogsBloc() {
    print('DialogsBloc constructor');
    dialogsApi.getDialogs().then((list) {
      _dialogsList = list;
      _syncController.sink
          .add(UnmodifiableListView<DialogModel>(_dialogsList.dialogs));
    });
    // dialogApi.getDialog(partnerId).then((data){
    //     // _syncController.sink
    //     //   .add(UnmodifiableListView<DialogModel>(_dialogsList.dialogs));
    // });
  }

  DialogListModel initionalData() {
    DialogListModel data;
    dialogsApi.getDialogs().then((list) {
      data = list;
    });
    return data;
  }

  void dispose() {
    print('DialogsBloc distructor');
    _syncController.close();
    _cmdController.close();
    socketBloc.dispose();
  }
}
