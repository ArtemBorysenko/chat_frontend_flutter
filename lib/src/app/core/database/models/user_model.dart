class UserModel {
  final String id;
  final String email;
  final String fullname;
  final String lastSeen;

  UserModel(this.id, this.email, this.fullname, this.lastSeen);

  UserModel.fromJSON(Map<String, dynamic> json)
    : id = json["_id"],
      email  = json["email"],
      fullname = json["fullname"],
      lastSeen  = json["last_seen"];
}