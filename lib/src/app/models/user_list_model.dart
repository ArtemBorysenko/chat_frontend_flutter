import 'package:chat_frontend_flutter/src/app/models/user_model.dart';

class UserListModel {
  List<UserModel> users = <UserModel>[];

  UserListModel.fromJSON(List<dynamic> json){
    users = json.map((item) {
      return UserModel.fromJSON(item);
    }).toList();
  }
}