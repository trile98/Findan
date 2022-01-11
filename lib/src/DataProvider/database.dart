import 'dart:async';
import 'dart:core';
import 'package:findan/src/Repository/Models/novel_detail_info.dart';
import 'package:findan/src/Repository/Models/novel_name_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Database{
    // var dbRef = FirebaseDatabase.instance.reference();


    Future<List<NovelDetailInfo>> getAllData() async{
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      List<NovelNameInfo> NameList = [];
      List<NovelDetailInfo> DetailList = [];
      var NameInfo, DetailInfo;


      // await dbRef.child("nameInfo").once().then((snapshot){
      //     for(var item in snapshot.value){
      //       if(item != null) {
      //         NameInfo = NovelNameInfo(id: item["id"] as int,
      //             link: item["link"],
      //             name: item["name"]);
      //         NameList.add(NameInfo);
      //       }
      //     }
      // });

      await firestore.collection("detailInfo")

        .where("descriptionKeyword",)
        .get()
        .then((querySnapshot) {
          var docs = querySnapshot.docs;
          for(var item in docs){
                DetailInfo = NovelDetailInfo(id: item["id"],
                    description: item["description"],
                    overView: item["overView"],
                    referenceId: item["referId"]);
                DetailList.add(DetailInfo);

              }
      });

      return DetailList;
    }


}