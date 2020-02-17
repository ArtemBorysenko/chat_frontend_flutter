class DialogModel {
  final String id;
  final String author;
  final String partner;
  final String lastMessage;

  DialogModel(this.id, this.author, this.partner, this.lastMessage);

  DialogModel.fromJSON(Map<String, dynamic> json)
    : id = json["_id"],
      author  = json["author"]["fullname"],
      partner =  json["partner"]["fullname"],
      lastMessage = json["lastMessage"]["text"];
      
}