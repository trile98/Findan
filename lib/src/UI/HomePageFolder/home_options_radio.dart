
import 'package:findan/src/ValueFolder/custom_enums.dart';
import 'package:findan/src/ValueFolder/custom_maps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeOptionsRadio extends StatefulWidget{
  HomeOptionsRadio({Key? key}) : super(key: key);

   var selectedValue;

  @override
  HomeOptionsRadioState createState() {
    return HomeOptionsRadioState();
  }

}



class HomeOptionsRadioState extends State<HomeOptionsRadio> {
  SearchOptionsEnum? recentRadioItem = SearchOptionsEnum.Name;


  @override
  Widget build(BuildContext context) {
    widget.selectedValue = recentRadioItem;

    return AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 500),
        child: Column(
          children: [
            ListTile(
              title: Text(CustomMaps.searchOptionsMap[describeEnum(SearchOptionsEnum.Name)].toString()),
              leading: Radio<SearchOptionsEnum>(
                value: SearchOptionsEnum.Name,
                groupValue: recentRadioItem,
                onChanged: (SearchOptionsEnum? item){
                  setState(() {
                    recentRadioItem = item;
                    widget.selectedValue = item;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(CustomMaps.searchOptionsMap[describeEnum(SearchOptionsEnum.Description)].toString()),
              leading: Radio<SearchOptionsEnum>(
                value: SearchOptionsEnum.Description,
                groupValue: recentRadioItem,
                onChanged: (SearchOptionsEnum? item){
                  setState(() {
                    recentRadioItem = item;
                    widget.selectedValue = item;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(CustomMaps.searchOptionsMap[describeEnum(SearchOptionsEnum.Genre)].toString()),
              leading: Radio<SearchOptionsEnum>(
                value: SearchOptionsEnum.Genre,
                groupValue: recentRadioItem,
                onChanged: (SearchOptionsEnum? item){
                  setState(() {
                    recentRadioItem = item;
                    widget.selectedValue = item;

                  });
                },
              ),
            ),
            ListTile(
              title: Text(CustomMaps.searchOptionsMap[describeEnum(SearchOptionsEnum.Overview)].toString()),
              leading: Radio<SearchOptionsEnum>(
                value: SearchOptionsEnum.Overview,
                groupValue: recentRadioItem,
                onChanged: (SearchOptionsEnum? item){
                  setState(() {
                    recentRadioItem = item;
                    widget.selectedValue = item;

                  });
                },
              ),
            )
          ],
        ),
    );
  }



}

