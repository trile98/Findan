class NovelNameInfo{
  final int id;
  final List<Object?> link;
  final String name;

  NovelNameInfo({ required this.id, required this.link, required this.name });

  int get getId =>  id;
  List<Object?> get getLink => link;
  String get getName => name;

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "name" : name
  };

  NovelNameInfo.fromJson(Map<String,dynamic> js):
      id = js["id"],
      link = js["link"],
      name = js["name"];
}