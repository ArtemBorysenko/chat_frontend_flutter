import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/api/dialog_api.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/api/message_api.dart';
import 'package:chat_frontend_flutter/src/app/api/dialog_api.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/socket_bloc.dart';

import 'package:sqflite/sqflite.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketBloc {
  static final SocketBloc _socketBloc = SocketBloc._();

  factory SocketBloc() {
    print("factory SocketBloc");
    return _socketBloc;
  }

  SocketBloc._() {
    print("1 SocketBloc function");

    _socket = IO.io('http://10.0.2.2:3003/', <String, dynamic>{
      'transports': ['websocket'],
    });
  }

  static IO.Socket _socket;

  IO.Socket get socket => _socket;

  // SocketBloc() {
  //   // if (_socket == null) {
  //   // print("socket constructor");
    // _socket = IO.io('http://10.0.2.2:3003/', <String, dynamic>{
    //   'transports': ['websocket'],
    // });
  //   // }
  //   print("socket constructor");
  // }

  serverNewMessage() {
    socket.on('SERVER:MESSAGE_NEW', (data) {
      print("socket message $data");
    });
    socket.emit('USER:MESSAGE_NEW', 'command USER:MESSA GE_NEW');
  }

  socketDisconnect() {
    _socket.disconnect();
  }

  void dispose() {
    print("socket distructor");
    // _socket=null;
  }
}

SocketBloc socketBloc = SocketBloc();
