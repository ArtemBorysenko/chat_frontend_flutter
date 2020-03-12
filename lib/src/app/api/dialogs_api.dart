import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class DialogsApi {
  // String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlNGJmYTc1YjExZWVmMDAxN2NjNWM1NCIsIm5hbWUiOiJIZXJva3UiLCJlbWFpbCI6Imhlcm9rdVRFU1RAdGVzdC5pbyIsImlhdCI6MTU4MjAzNzYyNX0.9nK5nngIy_MiwszPvNHNJ4JjDRKvxR0n-Vw6AZacjx0';
  static const String baseUrl = '10.0.2.2:3003';//chat-backend-koa.herokuapp.com
  final _httpClient = new HttpClient();

Future<DialogListModel> getDialogs() async {
  var uri = Uri.http(baseUrl,'api/v1/dialogs');
  
  http.Response response = await _getRequest(uri);

  DialogListModel list = DialogListModel.fromJSON(json.decode(response.body));

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

DialogsApi dialogsApi = DialogsApi();