import 'dart:core';
import 'package:findan/src/Repository/Models/novel_detail_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'DataProvider/database.dart';
import 'UI/HomePageFolder/home_page.dart';


Future<void> main() async {
  runApp(MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //  Database().getAllData().then((list) {
  //    for(NovelDetailInfo item in list){
  //      print(item.description);
  //    }
  //  });
  
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Findan",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: HomePage()
      ),
    );
  }

}



