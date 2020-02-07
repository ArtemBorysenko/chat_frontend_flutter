class DialogModel {
  final String author;
  final String partner;
  final String updatedAt;

  DialogModel(this.author, this.partner, this.updatedAt);

  DialogModel.fromJSON(Map<String, dynamic> json)
    : partner = json["_id"],
      author  = json["author"]["_id"],
      updatedAt  = json["updatedAt"];

}