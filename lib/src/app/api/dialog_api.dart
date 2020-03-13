import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/message_list_model.dart';

import 'package:http/http.dart' as http;

class DialogApi {

  static const String baseUrl = '10.0.2.2:3003';//chat-backend-koa.herokuapp.com
  final _httpClient = new HttpClient();
  
Future<MessageListModel> getDialog(String partnerId) async {
  var queryParameters = {
  'partner': partnerId,
};

  var uri = Uri.http(baseUrl,'api/v2/messages', queryParameters);//TODO v2

  http.Response response = await _getRequest(uri);
  // print(response.body);

  MessageListModel list = MessageListModel.fromJSON(json.decode(response.body));

  return list;
}

Future<http.Response> _getRequest(Uri uri) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('accessToken');
  // print(token);

  http.Response response = await http.Client().get(uri, 
  headers: {'Content-type': 'application/json', 'authorization': 'Bearer $token'});


  return response;
  }

}

DialogApi dialogApi = DialogApi();