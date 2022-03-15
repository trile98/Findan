import 'dart:convert';

import 'package:findan/src/DataProvider/database.dart';
import 'package:findan/src/Repository/Models/messageDto.dart';
import 'package:findan/src/Repository/Models/novel_info.dart';
import 'package:findan/src/ValueFolder/custom_enums.dart';

class SearchService{

  Future<MessageDto> getListOfNovel(String keyword, String typeOfSearch) async{
    List<NovelInfo> listResult = [];
    List<NovelInfo> listFromDB = [];

    MessageDto messageDto = MessageDto(messageCode: 0);

    try {
      var arrayOfKeywordSplitBySpace = splitKeywordBySpace(keyword);
      var arrayOfKeyWordSplitByComma = splitKeywordByComma(keyword);

      if (typeOfSearch == SearchOptionsEnum.Name.name) {
        //----------------> name will always search by keyword and sort by number of matches

        listFromDB = await Database().getAllDataByKeywordFromNameTable(
            arrayOfKeywordSplitBySpace);

        List<Map<String, Object>> tempMap = [];
        int checkMatched = 0;

        if (listFromDB.isNotEmpty) {
          for (var item in listFromDB) {
            checkMatched = 0;
            for (var kwInList in arrayOfKeyWordSplitByComma) {
              if (item.nameInfo!.name.contains(kwInList)) {
                checkMatched++;
              }
            }
            if (checkMatched > 0)
              tempMap.add({"matchNumber": checkMatched, "object": item});
          }

          if (tempMap.isNotEmpty) {
            tempMap.sort((a, b) =>
            ((b["matchNumber"] as int).compareTo((a["matchNumber"] as int))));
            for (int i = 0; i < tempMap.length; i++) {
              listResult.add(tempMap[i]["object"] as NovelInfo);
            }
          }
        }
      }
      else if (typeOfSearch == SearchOptionsEnum.Description.name) {
        listFromDB = await Database().getAllDataByKeywordFromDetailTable(
            arrayOfKeywordSplitBySpace, typeOfSearch);

        if (listFromDB.isNotEmpty) {
          for (var item in listFromDB) {
            for (var kwInList in arrayOfKeyWordSplitByComma) {
              if (item.detailInfo!.description.contains(kwInList)) {
                listResult.add(item);
                break;
              }
            }
          }
        }
      } else if (typeOfSearch == SearchOptionsEnum.Overview.name) {
        listFromDB = await Database().getAllDataByKeywordFromDetailTable(
            arrayOfKeywordSplitBySpace, typeOfSearch);

        if (listFromDB.isNotEmpty) {
          for (var item in listFromDB) {
            for (var kwInList in arrayOfKeyWordSplitByComma) {
              if (item.detailInfo!.overView!.contains(kwInList)) {
                listResult.add(item);
                break;
              }
            }
          }
        }
      }
      else { //genre
        listFromDB = await Database().getAllDataByKeywordFromDetailTable(
            arrayOfKeywordSplitBySpace, typeOfSearch);
        List<Map<String, Object>> tempMap = [];
        int checkMatched = 0;
        if (listFromDB.isNotEmpty) {
          //----> search novels which contain all genre first, then search novels which contain some of genre.
          for (var item in listFromDB) {
            checkMatched = 0;
            for (var kwInList in arrayOfKeyWordSplitByComma) {
              if (item.detailInfo!.genre!.contains(kwInList)) {
                checkMatched++;
              }
            }
            if (checkMatched > 0)
              tempMap.add({"matchNumber": checkMatched, "object": item});
          }

          if (tempMap.isNotEmpty) {
            tempMap.sort((a, b) =>
            ((b["matchNumber"] as int).compareTo((a["matchNumber"] as int))));
            for (int i = 0; i < tempMap.length; i++) {
              listResult.add(tempMap[i]["object"] as NovelInfo);
            }
          }
        }
      }

      messageDto.messageCode = 1;
      messageDto.attachedObject = jsonConvertListNovel(listResult);

      return messageDto;
    }on Exception catch(e){
      messageDto.messageCode = 0;
      messageDto.message = e.toString();
      return messageDto;
    }
  }

  Map<String,dynamic> jsonConvertListNovel(List<NovelInfo> list){
    Map<String,dynamic> result = {};

    for(int i = 0;i<list.length;i++){
      result[i.toString()] = list[i].toJson();
    }

    return result;
  }

  List<String> splitKeywordBySpace(String kw){
    List<String> listResult = [];

    String kwWithoutComma = kw.replaceAll(",", " ").replaceAll(".", " ").replaceAll("\n", " ").replaceAll("  ", " ");

    listResult = kwWithoutComma.split(" ");

    return listResult;
  }

  List<String> splitKeywordByComma(String kw){
    List<String> listResult = [];

    String kwWithoutComma = kw.replaceAll(".", ",").replaceAll("\n", ",").replaceAll("  ", " ").replaceAll(",,", ",");

    listResult = kwWithoutComma.split(",");

    return listResult;
  }
}