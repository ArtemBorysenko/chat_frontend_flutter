import 'package:chat_frontend_flutter/src/app/models/message_model.dart';

class MessageListModel {
  List<MessageModel> messages = <MessageModel>[];

  MessageListModel.fromJSON(List<dynamic> json){
    messages = json.map((item) {
      return MessageModel.fromJSON(item);
    }).toList();
  }

}