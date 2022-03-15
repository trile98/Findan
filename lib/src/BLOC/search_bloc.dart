import 'dart:async';

import 'package:findan/src/Repository/Models/novel_info.dart';
import 'package:findan/src/ValueFolder/custom_maps.dart';
import 'package:findan/src/DataProvider/database.dart';

class SearchBLOC{
  StreamController<List<String>> searchInputController = new StreamController<List<String>>.broadcast();


  Stream get searchInputStream => searchInputController.stream;

  bool isSearchNull(String searchContent){
    if(searchContent == null || searchContent.isEmpty || searchContent.trim() == ""){
      searchInputController.sink.addError(CustomMaps.messageMap["searchNullInvalidMessage"].toString());
      return true;
    }

    return false;
  }



  void dispose(){
    searchInputController.close();
  }
}