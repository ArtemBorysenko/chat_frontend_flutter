import 'package:chat_frontend_flutter/src/app/models/message_model.dart';

class MessageListModel {
  List<MessageModel> messages = <MessageModel>[];

  MessageListModel.fromJSON(List<dynamic> json){
    messages = json.map((item) {
      return MessageModel.fromJSON(item);
    }).toList();
  }

  add(dynamic json){
    print('message 1 ${json.messages[0].id}');
    MessageModel msg = new MessageModel(json.messages[0].id, json.messages[0].text,
      json.messages[0].reader,
      json.messages[0].lastSeen,
      json.messages[0].dialog,
      json.messages[0].user);

    print('message 2 $msg');


    messages.add(msg);
  }
}