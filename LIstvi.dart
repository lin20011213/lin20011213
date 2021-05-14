import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'DB.dart';
import 'QR.dart';



var list = [];
var listrect =[];
var listcost =[];
var listpro =[];

class listview extends StatelessWidget {
  @override
    Widget build(BuildContext context) {


    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, index){
          return ListTile(
            title: Text(list[index]+listrect[index]),
            subtitle: Text("價格：+${listcost[index]}+ 蛋白質：+${listpro[index]}+ 蛋白質：+${listpro[index]}"),
            onTap: () {
              // do something
            },
            onLongPress: (){
              list.removeAt(index);
              listrect.removeAt(index);
              listcost.remove(index);
              listpro.removeAt(index);
              listview();
            },

          );
        }
    );
  }
}