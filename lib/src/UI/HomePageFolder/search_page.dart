
import 'dart:async';
import 'dart:isolate';

import 'package:findan/src/BLOC/searchService.dart';
import 'package:findan/src/BLOC/search_bloc.dart';
import 'package:findan/src/Repository/Models/messageDto.dart';
import 'package:findan/src/Repository/Models/novel_info.dart';
import 'package:findan/src/ValueFolder/custom_enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

import 'home_options_radio.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeSearch();
  }

}



class HomeSearch extends StatefulWidget {
  const HomeSearch({Key? key}) : super(key: key);

  @override
  HomeSearchState createState() => HomeSearchState();

}

class HomeSearchState extends State<HomeSearch> with SingleTickerProviderStateMixin{

  static void searchIsolate(Map<String, Object> map)async{

    await Firebase.initializeApp();

    SendPort sendPort = map["sendport"] as SendPort;
    try {

      var item = map["content"] as Map;

      var keyword = item["keyword"];
      var type = item["typeSearch"];

      SearchService service = SearchService();

      MessageDto messageDto = await service.getListOfNovel(keyword, type);

      if(messageDto.messageCode == 1)
        sendPort.send({"message": messageDto.messageCode,"err":"","list":messageDto.attachedObject});
      else
        sendPort.send({"message": messageDto.messageCode,"err":messageDto.message,"list":""});

    }on Exception catch( e){
      sendPort.send({"message": 0,"err":e.toString()});
    }

  }


  var radioLayout = HomeOptionsRadio();

  SearchBLOC searchBLOC = SearchBLOC();

  TextEditingController searchControler = TextEditingController();

  late AnimationController homeSearchAnimController;
  late Animation<Offset> offSetAnim;

  late final FocusNode _focusNode = FocusNode();

  var mainColumn = <Widget>[];


  @override
  void dispose() {
    searchBLOC.dispose();
    super.dispose();
  }

  void setUpMainContent(){
    Widget searchWidget =
        SlideTransition(
            position: offSetAnim,
            child: StreamBuilder(
              stream: searchBLOC.searchInputStream,
              builder: (streamBuildercontext,snapshot)
              {


                return Center(
                child: Padding(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            keyboardType: TextInputType.multiline,
                            controller: searchControler,
                            decoration: InputDecoration(
                                errorText: snapshot.hasError ? snapshot.error
                                    .toString() : null
                            ),
                            maxLines: 3,
                            minLines: 1,
                            autofocus: false,
                          )
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),

                        onPressed: () async {
                          if (!searchBLOC.isSearchNull(searchControler.text)) {
                            print("run dialog");
                            showLoadingDialog(streamBuildercontext);
                          }
                        },
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                ),
              );
              }
            )
        );

      mainColumn.add(searchWidget);
  }

  @override
  void initState() {
    super.initState();


    homeSearchAnimController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    offSetAnim = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, -1.0)
    ).animate(homeSearchAnimController);

    _focusNode.addListener(() {if(_focusNode.hasFocus) homeSearchAnimController.forward();});

    homeSearchAnimController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          mainColumn.add(radioLayout);
          print("completed");
        });
      }
    });

    setUpMainContent();


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: mainColumn,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  void showLoadingDialog(BuildContext bContext) async{
    showDialog(context: bContext, builder: (BuildContext dialogContext) {

      return const SimpleDialog(
        title: Text("Dang tim kiem"),
        children: [
          SpinKitRing(color: Colors.black, size: 50.0,)
        ],
      );
    });


    ReceivePort receivePort = new ReceivePort();
     await FlutterIsolate.spawn(searchIsolate, {"content":{"keyword":searchControler.text, "typeSearch":(radioLayout.selectedValue as SearchOptionsEnum).name, "a":100},"sendport":receivePort.sendPort});

    var receiveItem = await receivePort.first;

    if((receiveItem["message"] as int) == 1){
      Navigator.of(bContext).pop();
      var l = (receiveItem["list"] as Map<String,dynamic>);

      List<NovelInfo> result = [];

      for(var i in l.entries){
        result.add(NovelInfo.fromJson(i.value));

      }


    }

   /* });*/
  }


  // static void testIsolate(Map<String, Object> map)async{
  //   SendPort sendPort = map["sendport"] as SendPort;
  //   try {
  //
  //
  //     var a = 10;
  //     var item = map["content"] as Map;
  //
  //     print(item["typeSearch"]);
  //
  //     var total = 0;
  //     for (int i = 0; i <= a; i++) {
  //       total += i;
  //
  //       print(i);
  //     }
  //     Future.delayed(new Duration(seconds: 10));
  //
  //     sendPort.send({"message": "finish","err":""});
  //   }on Exception catch( e){
  //     sendPort.send({"message": "fail","err":e.toString()});
  //   }
  //
  // }
}



