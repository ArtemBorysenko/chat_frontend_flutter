import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';

import 'package:http/http.dart' as http;

class SigninApi {

  static const String baseUrl = '10.0.2.2:3003';
  final _httpClient = new HttpClient();
  
Future<String> login(String email, String password) async {
  Map<String, String> bodyParameters = {
    "email": email,
    "password": password,
  };

  var uri = Uri.http(baseUrl,'/auth/signin');

  await _getRequest(uri, bodyParameters);
}

Future<http.Response> _getRequest(Uri uri, Map<String, String> bodyParameters) async {
  http.Response response = await http.Client().post(uri,
  body: bodyParameters);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', response.body);

  print('AccessToken: ${response.body}');

  return response;
  }
}

SigninApi signinApi = SigninApi();