import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/core/database/models/user_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  static const String baseUrl = '10.0.2.2:3003';//chat-backend-koa.herokuapp.com

Future<UserListModel> getUsers() async {
  var uri = Uri.http(baseUrl,'api/v1/user/find/');
  
  http.Response response = await _getRequest(uri);

  UserListModel list = UserListModel.fromJSON(json.decode(response.body));

  return list;
}

Future<http.Response> _getRequest(Uri uri) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('accessToken');

  http.Response response = await http.Client().get(uri, 
  headers: {'Content-type': 'application/x-www-form-urlencoded', 'authorization': 'Bearer $token'});

  return response;
  }
}

UsersApi usersApi = UsersApi();