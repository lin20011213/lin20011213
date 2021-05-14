import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'DB.dart';
import 'LIstvi.dart';


var qid =0;
var listthing;
var cost=0;
String qrest="",qname="";
int qprotein=0;
class food {
  final int id;
  final String name;
  final String rest;
  final int cost;
  final int protein;

  food({this.id, this.name, this.rest, this.cost,this.protein});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rest': rest,
      'cost': cost,
      'protein': protein,
    };
  }

  @override
  String toString() {

    return "Food{\n  id: $id\n  name: $name\n  rest: $rest\n  cost: $cost\n protein: $protein\n}\n\n";
  }
}




class scanqr extends StatefulWidget {
  scanqr({Key key}) : super(key: key);

  _scanqrState createState() => _scanqrState();
}

class _scanqrState extends State<scanqr> {
  String barcode = "";
  var data= food(
      id:0,
      name:"",
      rest:"",
      cost:0,
      protein:0,
  );
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('紀錄小幫手'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(data.name),
              MaterialButton(
                onPressed: scan,
                child: Text("Scan"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }


  Future scan() async {
    try {
      int i=0;
      String barcode = await scanner.scan();
      qname="";
      for( i=0;barcode[i] != '%';i++){
        qname+=barcode[i];
      }
      if(qname=="炒飯"){
        qid++;
        qrest="興仁";
        cost=25;
        qprotein=20;
      }
      if(qname=="炒麵"){
        qid++;
        qrest="興仁";
        cost=40;
        qprotein=20;
      }
      var data= food(
        id:qid,
        name:qname,
        rest:qrest,
        cost:cost,
        protein:qprotein,
      );

      list.add(qname);
      listrect.add(qrest);
      listcost.add(cost);
      listpro.add(qprotein);
      await FoodDB.insertData(data);

      print(await FoodDB.showAllData(qid));
      print(qid);


      setState(() => {
        this.barcode = barcode,
      });
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }}
    on FormatException {
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }}}