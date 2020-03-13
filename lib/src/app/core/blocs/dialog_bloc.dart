import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/api/message_api.dart';
import 'package:chat_frontend_flutter/src/app/api/dialog_api.dart';
import 'package:chat_frontend_flutter/src/app/core/blocs/socket_bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class DialogBloc {
  static SocketBloc socketBloc = new SocketBloc();
  final IO.Socket socket = socketBloc.socket;

  // IO.Socket socket = IO.io('http://10.0.2.2:3003/', <String, dynamic>{
  //   'transports': ['websocket'],
  // });

  StreamController<List<MessageModel>> _syncController =
      StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get outDialogBloc => _syncController.stream;

  StreamController<List<MessageModel>> _cmdController =
      StreamController<List<MessageModel>>.broadcast();
  StreamSink get getDialogBloc => _cmdController.sink;

  MessageListModel _dialogsList;

  String data;
  MessageListModel message;

  DialogBloc(String dialogId) {
    dialogApi.getDialog(dialogId).then((list) {
      _dialogsList = list;
      _syncController.sink
          .add(UnmodifiableListView<MessageModel>(_dialogsList.messages));
    });
  }

  create(dialogId, text) async {
    await socketBloc.serverNewMessage();
    await messageApi.create(dialogId, text);

    // data = await socketBloc.serverNewMessage();
    // data = socketBloc.newMsg;
    socketBloc.getSocketBloc.listen((event) {
      // print('DIALOG data : $event');

      MessageListModel messageList =
          MessageListModel.fromJSON(json.decode('[$event]'));
      _dialogsList.add(messageList);
      print('_dialogsList length : ${_dialogsList.messages.length}');

      _syncController.sink
          .add(UnmodifiableListView<MessageModel>(_dialogsList.messages));

      socketBloc.closeStream();
    });
  }

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
