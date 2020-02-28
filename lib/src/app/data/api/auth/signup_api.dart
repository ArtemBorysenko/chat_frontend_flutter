import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/user_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';

import 'package:http/http.dart' as http;

class SigninApi {

  static const String baseUrl = 'chat-backend-koa.herokuapp.com';//chat-backend-koa.herokuapp.com
  final _httpClient = new HttpClient();
  
Future<UserModel> registration(String email, String fullname, String password) async {
  Map<String, String> bodyParameters = {
    "email": email,
    "fullname": fullname,
    "password": password,
  };

  var uri = Uri.http(baseUrl,'/auth/signup');

  http.Response response = await _getRequest(uri, bodyParameters);

  UserModel userList = UserModel.fromJSON(json.decode(response.body));

  return userList;
}


Future<http.Response> _getRequest(Uri uri, Map<String, String> bodyParameters) async {
  http.Response response = await http.Client().post(uri,
  body: bodyParameters);

  print('New User: ${response.body}');

  return response;
  }
}

SigninApi signupApi = SigninApi();