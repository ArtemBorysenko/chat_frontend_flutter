import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_frontend_flutter/src/app/models/dialogs_list_model.dart';
import 'package:chat_frontend_flutter/src/app/models/test_model.dart';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class DialogsApi {
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlMjE5NTlhMTJhMjg3MmE2NWQ4YTYwMSIsIm5hbWUiOiJQZXR5YSIsImVtYWlsIjoidGVzdDNAdGVzdC5pbyIsImlhdCI6MTU3OTUzMzM0Nn0.-VQu9RWsXweDB0fM4TfcT2CCyd4LGp7By7e5_Bcs1NM';
  static const String baseUrl = '10.0.2.2:3003';
  final _httpClient = new HttpClient();


// Future<DialogModelList> getDialogsTEST() async {
//   var uri = Uri.http(baseUrl,'');

//   var response = await _getRequest(uri);

//   DialogModelList list = DialogModelList.fromJSON(json.decode(response));

//   return list;
// }

Future<DialogListModel> getDialogs() async {
  var uri = Uri.http(baseUrl,'dialogs');

//   var response = await http.get(uri, headers: {
//     HttpHeaders.authorizationHeader: 'Bearer $token',
//     HttpHeaders.contentTypeHeader: 'application/json',
//     // HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
// });
  
  http.Response response = await _getRequest(uri);
  // print(response.body);

  // print(response.body);

  DialogListModel list = DialogListModel.fromJSON(json.decode(response.body));

  // var afterJson = json.decode(response.body).cast<String, dynamic>();
  // print(list);

  return list;
}

Future<http.Response> _getRequest(Uri uri) async {
  http.Response response = await http.Client().get(uri, 
  headers: {'Content-type': 'application/json', 'authorization': 'Bearer $token'});

  return response;
  }

}

DialogsApi dialogsApi = DialogsApi();