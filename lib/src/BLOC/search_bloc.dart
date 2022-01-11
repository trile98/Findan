import 'dart:async';

import 'package:findan/src/ValueFolder/custom_maps.dart';


class SearchBLOC{
  StreamController searchInputController = new StreamController<List<String>>.broadcast();


  Stream get searchInputStream => searchInputController.stream.asBroadcastStream();

  bool isSearchNull(String searchContent){
    if(searchContent == null || searchContent.isEmpty || searchContent.trim() == ""){
      searchInputController.sink.addError(CustomMaps.messageMap["searchNullInvalidMessage"].toString());
      return true;
    }

    return false;
  }
}