
import 'package:findan/src/ValueFolder/custom_maps.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeState();

}

class HomeState extends State<HomePage>{

  var unfocusBtnStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(100,50)),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Color(CustomMaps.colorMap["buttonThemeColor"] as int))
          )
      )
  );

  var focusBtnStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(100,50)),
      backgroundColor: MaterialStateProperty.all(Color(CustomMaps.colorMap["buttonThemeColor"] as int)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Color(CustomMaps.colorMap["buttonThemeColor"] as int))
          )
      )
  );

  bool firstBtnClick = true;
  bool secondBtnClick = false;
  bool thirdBtnClick = false;
  bool forthBtnClick = false;
  bool fifthBtnClick = false;

  changeTextStyle(bool clicked){
    return clicked? TextStyle(color: Colors.white):TextStyle(color: Color(CustomMaps.colorMap["buttonThemeColor"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return

      Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 100,left: 15),
          decoration: BoxDecoration(color: Color(CustomMaps.colorMap["themeColor"] as int), borderRadius:  BorderRadius.only(topLeft: Radius.circular(18))) ,
        ),

        Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width-20,
                  child:  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      OutlinedButton(
                        onPressed: (){
                          setState((){
                              firstBtnClick = true;
                              secondBtnClick = false;
                              thirdBtnClick = false;
                              forthBtnClick = false;
                              fifthBtnClick = false;
                          });
                        },
                        style: firstBtnClick? focusBtnStyle : unfocusBtnStyle,
                        child: Text("co dai", style: changeTextStyle(firstBtnClick))
                      ),
                      SizedBox(width: 20),
                      OutlinedButton(
                          onPressed: (){
                            setState(() {
                              firstBtnClick = false;
                              secondBtnClick = true;
                              thirdBtnClick = false;
                              forthBtnClick = false;
                              fifthBtnClick = false;
                            });

                          },
                          style: secondBtnClick? focusBtnStyle : unfocusBtnStyle,
                        child: Text("co dai",style: changeTextStyle(secondBtnClick) ),
                      ),
                      SizedBox(width: 20),
                      OutlinedButton(
                          onPressed: (){
                            setState((){
                              firstBtnClick = false;
                              secondBtnClick = false;
                              thirdBtnClick = true;
                              forthBtnClick = false;
                              fifthBtnClick = false;
                            });
                          },
                          style: thirdBtnClick? focusBtnStyle : unfocusBtnStyle,
                          child: Text("co dai", style: changeTextStyle(thirdBtnClick))
                      ),
                      SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: (){
                          setState(() {
                            firstBtnClick = false;
                            secondBtnClick = false;
                            thirdBtnClick = false;
                            forthBtnClick = true;
                            fifthBtnClick = false;
                          });

                        },
                        style: forthBtnClick? focusBtnStyle : unfocusBtnStyle,
                        child: Text("co dai",style: changeTextStyle(forthBtnClick) ),
                      ),
                      SizedBox(width: 20),
                      OutlinedButton(
                          onPressed: (){
                            setState((){
                              firstBtnClick = false;
                              secondBtnClick = false;
                              thirdBtnClick = false;
                              forthBtnClick = false;
                              fifthBtnClick = true;
                            });
                          },
                          style: fifthBtnClick? focusBtnStyle : unfocusBtnStyle,
                          child: Text("co dai", style: changeTextStyle(fifthBtnClick))
                      ),
                      SizedBox(width: 20),


                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text("abc"),
                      Text("bcd")
                    ],
                  ),
                ),

              ],
            )
        )
      ],
    );
  }

}