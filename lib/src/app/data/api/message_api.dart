import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_model.dart';

import 'package:http/http.dart' as http;

class MessageApi {

  static const String baseUrl = '10.0.2.2:3003';//chat-backend-koa.herokuapp.com
  final _httpClient = new HttpClient();
  
Future<MessageModel> create(String dialogId, String text) async {
  Map<String, String> bodyParameters = {
    "dialog_id": dialogId,
    "text": text,
  };

  var uri = Uri.http(baseUrl,'/messages/');

  http.Response response = await _getRequest(uri, bodyParameters);

  MessageModel messageList = MessageModel.fromJSON(json.decode(response.body));

  return messageList;
}


Future<http.Response> _getRequest(Uri uri, Map<String, String> bodyParameters) async {
  http.Response response = await http.Client().post(uri,
  body: bodyParameters);

  return response;
  }
}

MessageApi messageApi = MessageApi();