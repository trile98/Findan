import 'dart:async';
import 'dart:core';
import 'package:findan/src/Repository/Models/novel_detail_info.dart';
import 'package:findan/src/Repository/Models/novel_name_info.dart';
import 'package:findan/src/Repository/Models/novel_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findan/src/ValueFolder/custom_enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Database{
    // var dbRef = FirebaseDatabase.instance.reference();

    Database() {
    }

    // Future<List<NovelDetailInfo>> getAllData() async{
    //   FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    //   List<NovelNameInfo> NameList = [];
    //   List<NovelDetailInfo> DetailList = [];
    //   var NameInfo, DetailInfo;
    //
    //
    //   // await dbRef.child("nameInfo").once().then((snapshot){
    //   //     for(var item in snapshot.value){
    //   //       if(item != null) {
    //   //         NameInfo = NovelNameInfo(id: item["id"] as int,
    //   //             link: item["link"],
    //   //             name: item["name"]);
    //   //         NameList.add(NameInfo);
    //   //       }
    //   //     }
    //   // });
    //
    //   var a = "bình thường".split(" ");
    //
    //   await firestore.collection("detailInfo")
    //
    //     .where("descriptionKeyword",arrayContainsAny: a)
    //     .get()
    //     .then((querySnapshot) {
    //       var docs = querySnapshot.docs;
    //       for(var item in docs){
    //             DetailInfo = NovelDetailInfo(id: item["id"],
    //                 description: item["description"],
    //                 overView: item["overView"],
    //                 referenceId: item["referId"]);
    //             DetailList.add(DetailInfo);
    //
    //           }
    //   });
    //
    //   return DetailList;
    // }

    Future<List<NovelInfo>> getAllDataByKeywordFromDetailTable(List<String> keyword, String typeOfSearch) async{
      FirebaseFirestore firestoreIns = FirebaseFirestore.instance;

      List<NovelInfo> listOfNovel = [];
      NovelInfo novel;
      List<int> listOfRefId = [];
      String field = "";

      if(typeOfSearch == SearchOptionsEnum.Description.name){
        field = "descriptionKeyword";
      }else if(typeOfSearch == SearchOptionsEnum.Overview.name){
        field = "overViewKeyword";
      }else{
        field = "genreKeyword";
      }



      await firestoreIns.collection("detailInfo")
          .where(field,arrayContainsAny: keyword)
          .get()
          .then((querySnapshot) {
        var docs = querySnapshot.docs;
        for(var item in docs){
          novel = new NovelInfo();

          novel.detailInfo = NovelDetailInfo(
              id: item["id"],
              description: item["description"],
              overView: item["overView"],
              referenceId: item["referId"],
              genre: item["genre"]
          );
              
          listOfNovel.add(novel);
          listOfRefId.add(item["referId"]);
        }
        print(listOfNovel.length);
      });

      print('detail: ${listOfNovel.length}');

      if(listOfRefId.isNotEmpty) {
        await firestoreIns.collection("nameInfo")
            .where("id", whereIn: listOfRefId)
            .get()
            .then((querySnapshot) {
          var docs = querySnapshot.docs;
          for (var item in docs) {
            for (NovelInfo novel in listOfNovel) {
              if (novel.detailInfo!.referenceId == item["id"]) {
                var index = listOfNovel.indexOf(novel);
                listOfNovel[index].nameInfo = NovelNameInfo(
                    id: item["id"], link: item["link"], name: item["name"]);
              }
            }
          }
        });
      }
      print("finish db");
      return listOfNovel;
    }

    Future<List<NovelInfo>> getAllDataByKeywordFromNameTable(List<String> keyword) async{
      FirebaseFirestore firestoreIns = FirebaseFirestore.instance;

      List<NovelInfo> listOfNovel = [];
      NovelInfo novel;
      List<int> listOfRefId = [];


      await firestoreIns.collection("nameInfo")
          .where("nameKeyword",arrayContainsAny: keyword)
          .get()
          .then((querySnapshot) {
        var docs = querySnapshot.docs;
        for(var item in docs){
          novel = new NovelInfo();

          novel.nameInfo = NovelNameInfo(
              id: item["id"],
              link: item["link"],
              name: item["name"]
          );

          listOfNovel.add(novel);
          listOfRefId.add(item["id"]);
        }
      });


      if(listOfRefId.isNotEmpty) {
        await firestoreIns.collection("detailInfo")
            .where("referId", whereIn: listOfRefId)
            .get()
            .then((querySnapshot) {
          var docs = querySnapshot.docs;
          for (var item in docs) {
            for (NovelInfo novel in listOfNovel) {
              if (novel.nameInfo!.id == item["referId"]) {
                var index = listOfNovel.indexOf(novel);
                listOfNovel[index].detailInfo = NovelDetailInfo(
                    id: item["id"],
                    description: item["description"],
                    overView: item["overView"],
                    referenceId: item["referId"],
                    genre: item["genre"]
                );
              }
            }
          }
        });
      }
      return listOfNovel;
    }

}