import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';

import 'package:http/http.dart' as http;

class DialogApi {
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlNDJiMDhjZTZmZjBkMDc5NDM0ZDYzYSIsIm5hbWUiOiJQZXR5YSIsImVtYWlsIjoiRmx1dHRlcjFAdGVzdC5pbyIsImlhdCI6MTU4MTUxNDYxOH0.0DoKJgKXZ-dePz0fqURbIOW3JcD7LXnk3F5W_Ot6lAw';
  static const String baseUrl = '10.0.2.2:3003';
  final _httpClient = new HttpClient();
  
Future<MessageListModel> getDialog(String dialogId) async {
  var queryParameters = {
  'dialog': dialogId,
};

  var uri = Uri.http(baseUrl,'messages', queryParameters);

  http.Response response = await _getRequest(uri);

  MessageListModel list = MessageListModel.fromJSON(json.decode(response.body));

  return list;
}

Future<http.Response> _getRequest(Uri uri) async {
  http.Response response = await http.Client().get(uri, 
  headers: {'Content-type': 'application/json', 'authorization': 'Bearer $token'});

  return response;
  }

}

DialogApi dialogApi = DialogApi();