import 'package:chat_frontend_flutter/src/app/models/dialogs_model.dart';

class TEST_DialogModelList {
  List<DialogModel> dialogs = <DialogModel>[];

  TEST_DialogModelList.fromJSON(List<Map<String, dynamic>> json)
   : dialogs = json[0]["_id"]; 

  TEST_DialogModelList.ListFromJSON(List<Map<String, dynamic>> json)
   : dialogs = (json[0] as List<dynamic>)
                .map((item) { 
                  // print(item);
                  return item;}).toList();


  // Return the dialog by its id
  // DialogModel findById(String dialog) => dialogs.firstWhere((g) => g.dialog == dialog);
}