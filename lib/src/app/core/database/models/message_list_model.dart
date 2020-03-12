import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';

class MessageListModel {
  List<MessageModel> messages = <MessageModel>[];

  MessageListModel.fromJSON(List<dynamic> json){
    // print(json);
    messages = json.map((item) {
      return MessageModel.fromJSON(item);
    }).toList();
  }

  add(MessageListModel json){
    MessageModel msg = new MessageModel(json.messages[0].id, json.messages[0].text,
      json.messages[0].reader,
      json.messages[0].lastSeen,
      json.messages[0].dialog,
      json.messages[0].user);

    messages.add(msg);
  }
}