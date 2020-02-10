import 'dart:async';
import 'dart:collection';

import 'package:chat_frontend_flutter/src/app/models/dialogs_model.dart';
import 'package:chat_frontend_flutter/src/app/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/data/api/dialogs_api.dart';

class DialogsBloc {

  StreamController<List<DialogModel>> _syncController = StreamController<List<DialogModel>>.broadcast();
  Stream<List<DialogModel>> get outDialogsBloc => _syncController.stream;

  StreamController<List<DialogModel>> _cmdController = StreamController<List<DialogModel>>.broadcast();
  StreamSink get getDialogsBloc => _cmdController.sink;
  
  DialogListModel _dialogsList;

  DialogsBloc() {
    dialogsApi.getDialogs().then((list){
       _dialogsList = list;
    });

    _cmdController.stream.listen((_){
      _syncController.sink.add(UnmodifiableListView<DialogModel>(_dialogsList.dialogs));
      // print(_dialogsList.dialogs);
    });
  }

  DialogListModel initionalData () {
    DialogListModel data;
    dialogsApi.getDialogs().then((list){
        data = list;
    });
    print(data);
     return data;
  }

  void dispose(){
    _syncController.close();
    _cmdController.close();
  }

}
