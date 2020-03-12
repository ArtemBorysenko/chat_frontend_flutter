import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/core/database/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MessageApi {

  static const String baseUrl = '10.0.2.2:3003';//chat-backend-koa.herokuapp.com
  final _httpClient = new HttpClient();
  
Future<MessageListModel> create(String dialogId, String text) async {
  Map<String, String> bodyParameters = {
    "dialog_id": dialogId,
    "text": text,
  };

  var uri = Uri.http(baseUrl,'api/v1/messages');

  http.Response response = await _getRequest(uri, bodyParameters);
  
  MessageListModel messageList = MessageListModel.fromJSON(json.decode(response.body));

  return messageList;
}

Future<http.Response> _getRequest(Uri uri, Map<String, String> bodyParameters) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('accessToken');

  http.Response response = await http.Client().post(uri,
  headers: {'authorization': 'Bearer $token'},
  body: bodyParameters);

  return response;
  }
}

MessageApi messageApi = MessageApi();