class NovelDetailInfo{
  int id;
  String description;
  String? overView;
  int referenceId;
  String? genre;

  NovelDetailInfo({required this.id, required this.description,  this.overView, required this.referenceId, this.genre });

  Map<String, dynamic> toJson() =>{
    "id":id,
    "description":description,
    "overView":overView,
    "referenceId":referenceId,
    "genre": genre
  };

  NovelDetailInfo.fromJson(Map<String,dynamic> js):
      id = js["id"],
      description = js["description"],
      overView = js["overView"],
      referenceId = js["referenceId"],
      genre = js["genre"];
}