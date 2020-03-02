import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/models/dialogs_model.dart';
import 'package:chat_frontend_flutter/src/app/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialogs_api.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class DialogsBloc {
    
  _socketStatus() {
    print('socket run');
  }

// --> GET /socket.io/?EIO=3&transport=polling 404 1ms - 10.0.2.2 no proxy and with
socketFunc(){
IO.Socket socket = IO.io('https://chat-backend-koa.herokuapp.com/', <String, dynamic>{
    'transports': ['websocket'],
  });

socket.emit('connection', "connn");

  socket.on('send_message', (message) {
     print('send_message ${message}');
    });

  socket.emit('send_message', "_socketStatus");

  socket.emit('disconnect', "(_) => print('disconnect')");

  // socket.disconnect();
}

  StreamController<List<DialogModel>> _syncController =
      StreamController<List<DialogModel>>.broadcast();
  Stream<List<DialogModel>> get outDialogsBloc => _syncController.stream;

  StreamController<List<DialogModel>> _cmdController =
      StreamController<List<DialogModel>>.broadcast();
  StreamSink get getDialogsBloc => _cmdController.sink;

  DialogListModel _dialogsList;

  DialogsBloc() {

    dialogsApi.getDialogs().then((list) {
      _dialogsList = list;
    _syncController.sink
          .add(UnmodifiableListView<DialogModel>(_dialogsList.dialogs));
    });
  
    // socketFunc();
  }

  DialogListModel initionalData() {
    DialogListModel data;
    dialogsApi.getDialogs().then((list) {
      data = list;
    });
    // print(data);
    return data;
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
