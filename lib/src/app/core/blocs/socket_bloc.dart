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
    print("CONSTRUCTOR SocketBloc function");
  }

  static final IO.Socket _socket = IO.io('http://10.0.2.2:3003', <String, dynamic>{
      'transports': ['websocket'],
    });

  IO.Socket get socket => _socket;

  static StreamController<String> _cmdController;
  Stream get getSocketBloc => _cmdController.stream;

  closeStream() {
    print('closeStream');
    _cmdController.close();
  }

  serverNewMessage() {
    _cmdController = StreamController<String>.broadcast();

     _socket.on('connect', (_) {
  print('connect');
  socket.emit('msg', 'test');
});

    _socket.on('SERVER:MESSAGE_NEW', (data) {
      print('SOCKET newMsg 1');
     _cmdController.sink.add(data);
      print('SOCKET newMsg 2');
    });

    // socket.emit('USER:MESSAGE_NEW', 'command USER:MESSAGE_NEW');

    // return await _newMsg;
    //   print('SOCKET newMsg : $newMsg');
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
