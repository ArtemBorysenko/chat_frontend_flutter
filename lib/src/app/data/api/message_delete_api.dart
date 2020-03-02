import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/message_list_model.dart';
import 'package:chat_frontend_flutter/src/app/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MessageApi {
  static const String baseUrl = '10.0.2.2:3003';

  Future<MessageModel> create(String messageId) async {
    Map<String, String> queryParameters = {
      "message_id": messageId,
    };

    var uri =
        Uri.http(baseUrl, '/messages/?id=${queryParameters['message_id']}');

    http.Response response = await _getRequest(uri, queryParameters);

    MessageModel messageList =
        MessageModel.fromJSON(json.decode(response.body));

    return messageList;
  }

  Future<http.Response> _getRequest(
      Uri uri, Map<String, String> bodyParameters) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('accessToken');

    http.Response response = await http.Client().delete(
      uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'authorization': 'Bearer $token'
      },
    );

    return response;
  }
}

MessageApi messageApi = MessageApi();
