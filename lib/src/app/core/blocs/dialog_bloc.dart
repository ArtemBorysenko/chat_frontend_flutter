import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/data/api/message_api.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialog_api.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class DialogBloc {
  IO.Socket socket = IO.io('http://10.0.2.2:3003/', <String, dynamic>{
    'transports': ['websocket'],
  });

  StreamController<List<MessageModel>> _syncController =
      StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get outDialogBloc => _syncController.stream;

  StreamController<List<MessageModel>> _cmdController =
      StreamController<List<MessageModel>>.broadcast();
  StreamSink get getDialogBloc => _cmdController.sink;

  MessageListModel _dialogsList;

  DialogBloc(String dialogId) {
    dialogApi.getDialog(dialogId).then((list) {
      _dialogsList = list;
      _syncController.sink
          .add(UnmodifiableListView<MessageModel>(_dialogsList.messages));
    });
  }

  create(dialogId, text) {
    messageApi.create(dialogId, text).then((message) {

      socket.on('SERVER:MESSAGE_NEW', (data) {
        MessageListModel messageList =
            MessageListModel.fromJSON(json.decode('[$data]'));
        _dialogsList.add(messageList);

        _syncController.sink
          .add(UnmodifiableListView<MessageModel>(_dialogsList.messages));
      });

      socket.emit('USER:MESSAGE_NEW', 'command USER:MESSA GE_NEW');
    });
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
    socket.disconnect();
  }
}
