
import 'dart:async';
import 'dart:isolate';

import 'package:findan/src/BLOC/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_options_radio.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return HomeSearch();
  }

}


class HomeSearch extends StatefulWidget {
  HomeSearch({Key? key}) : super(key: key);

  @override
  HomeSearchState createState() => HomeSearchState();

}

class HomeSearchState extends State<HomeSearch> with SingleTickerProviderStateMixin{

   static void testIsolate(SendPort sendPort)async{
     var port = new ReceivePort();
     var a = 10;

     sendPort.send(port.sendPort);
      var item = await port.first;

      print(item["typeSearch"]);

    var total = 0;
    for(int i= 0 ; i<= a; i++){
      total+= i;

      print(i);
    }
    Future.delayed(new Duration(seconds: 10));
    print("${total} test total");

    var contx = item["context"] as BuildContext;

    Navigator.pop(contx);
  }

  var radioLayout = HomeOptionsRadio();

  SearchBLOC searchBLOC = new SearchBLOC();

  TextEditingController searchControler = new TextEditingController();

  late AnimationController homeSearchAnimController;
  late Animation<Offset> offSetAnim;

  late final FocusNode _focusNode = FocusNode();

  var mainColumn = <Widget>[];

  void setUpMainContent(){
    Widget searchWidget =
        SlideTransition(
            position: offSetAnim,
            child: StreamBuilder(
              stream: searchBLOC.searchInputStream,
              builder: (streamBuildercontext,snapshot)=>  Center(
                child: Padding(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            keyboardType: TextInputType.multiline,
                            controller: searchControler,
                            decoration: InputDecoration(
                              errorText: snapshot.hasError ? snapshot.error.toString() : null
                            ),
                            maxLines: 3,
                            minLines: 1,
                            autofocus: false,
                          )
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),

                        onPressed: () async {
                          if(!searchBLOC.isSearchNull(searchControler.text)){
                            print("run dialog");
                            showLoadingDialog(streamBuildercontext);
                          }
                        },
                      )
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                ),
              )
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
    var isolate = await Isolate.spawn(testIsolate, receivePort.sendPort);


       //   if(message == "finished") //means completed
       // var check = await sendPort;
       // print("${check} checksendport");

    SendPort sendPort = await receivePort.first;
    sendPort.send({"keyword":searchControler.text, "typeSearch":radioLayout.selectedValue, "a":100, "context":bContext});


   /* });*/
  }


}



