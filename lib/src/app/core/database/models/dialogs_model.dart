class DialogModel {
  final String id;
  final String author;
  final String authorId;
  final String partner;
  final String partnerId;
  final String lastMessage;

  DialogModel(this.id, this.author, this.partner, this.lastMessage, this.authorId, this.partnerId);

  DialogModel.fromJSON(Map<String, dynamic> json)
    : id = json["_id"],
      author  = json["author"]["fullname"],
      authorId  = json["author"]["_id"],
      partner =  json["partner"]["fullname"],
      partnerId =  json["partner"]["_id"],
      lastMessage = json["lastMessage"]["text"];
      
}