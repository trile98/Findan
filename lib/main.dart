import 'dart:core';
import 'package:findan/src/Repository/Models/novel_detail_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/DataProvider/database.dart';
import 'src/UI/HomePageFolder/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   // Database().getAllData().then((list) {
   //   for(NovelDetailInfo item in list){
   //     print(item.description);
   //   }
   // });
  runApp(MyApp());

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



