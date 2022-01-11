class NovelNameInfo{
  final int id;
  final List<Object?> link;
  final String name;

  NovelNameInfo({ required this.id, required this.link, required this.name });

  int get getId =>  id;
  List<Object?> get getLink => link;
  String get getName => name;
}