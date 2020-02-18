import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';

import 'package:http/http.dart' as http;

class SigninApi {

  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlNGE2MGQ0NWZlNDQ1MjBmYjg4Y2M2NCIsIm5hbWUiOiJQZXR5YSIsImVtYWlsIjoiZmx1dHRlcjFAdGVzdC5pbyIsImlhdCI6MTU4MTkzMjc4Nn0.TpROgfrAqWb_VVudaTUZ7aBZQ8zOQfBf_D8PuIQZI34';
  static const String baseUrl = '10.0.2.2:3003';
  final _httpClient = new HttpClient();
  
Future<String> login(String login, String password) async {
  Map<String, String> bodyParameters = {
    "email": login,
    "password": password,
  };

  var uri = Uri.http(baseUrl,'/auth/signin');

  http.Response token = await _getRequest(uri, bodyParameters);

  

  print('AccessToken: ${token.body}');

  return token.body;
}

Future<http.Response> _getRequest(Uri uri, Map<String, String> bodyParameters) async {
  http.Response response = await http.Client().post(uri,
 body: bodyParameters)  ;

  return response;
  }

}

SigninApi signinApi = SigninApi();