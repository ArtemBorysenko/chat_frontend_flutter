import 'package:chat_frontend_flutter/src/app/core/database/models/dialogs_model.dart';

class DialogListModel {
  List<DialogModel> dialogs = <DialogModel>[];

  DialogListModel.fromJSON(List<dynamic> json){
    dialogs = json.map((item) {
      return DialogModel.fromJSON(item);
    }).toList();
  }
  //  : dialogs = (json[0])
  //               .map((item) { 
  //                 print(item);
  //                 return item;}).toList();

  // Return the dialog by its id
  // DialogModel findById(String dialog) => dialogs.firstWhere((g) => g.dialog == dialog);
}