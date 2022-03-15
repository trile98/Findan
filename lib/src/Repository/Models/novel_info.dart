import 'package:findan/src/Repository/Models/novel_detail_info.dart';
import 'package:findan/src/Repository/Models/novel_name_info.dart';


class NovelInfo{
  NovelNameInfo? nameInfo;
  NovelDetailInfo? detailInfo;

  NovelInfo({nameInfo, detailInfo});

  NovelNameInfo? get getNovelName => this.nameInfo;
  NovelDetailInfo? get getNovelDetail => this.detailInfo;

  set setNovelName(NovelNameInfo name) => this.nameInfo = name;
  set setNovelDetail(NovelDetailInfo detail) => this.detailInfo = detail;

  Map<String, dynamic> toJson() => {
    "nameInfo": nameInfo!.toJson(),
    "detailInfo": detailInfo!.toJson()
  };

  NovelInfo.fromJson(Map<String,dynamic> js) : nameInfo = NovelNameInfo.fromJson(js["nameInfo"]) , detailInfo = NovelDetailInfo.fromJson(js["detailInfo"]);
}