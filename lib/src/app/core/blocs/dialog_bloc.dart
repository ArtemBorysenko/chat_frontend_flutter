import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:chat_frontend_flutter/src/app/models/message_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialogs_api.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialog_api.dart';

class DialogBloc {
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

  void dispose() {
    _syncController.close();
    _cmdController.close();
  }
}
