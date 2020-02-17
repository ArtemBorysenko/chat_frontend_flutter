
class MessageModel {
  final String id;
  final String text;
  final bool reader;  
  final String lastSeen;
  final String dialog;
  final String user;

  MessageModel(this.id, this.text, this.reader, this.lastSeen, this.dialog, this.user);

  MessageModel.fromJSON(Map<String, dynamic> json)
    : id = json["_id"],
      text  = json["text"],
      reader = json["readed"],
      lastSeen = json["user"]["last_seen"],
      dialog = json["dialog"]["_id"],
      user  = json["user"]["fullname"];
      
}