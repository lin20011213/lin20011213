import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'QR.dart';

class StoragePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StorageState();
}

class StorageState extends State {
  var _textFieldController = new TextEditingController();
  var _storageString = '';

  /***利用Sqflite資料庫儲存資料*/
  saveString() async {
    final db = await getDataBase('my_db.db');
    //寫入字串
    db.transaction((trx) {
      trx.rawInsert(
          'INSERT INTO user(name) VALUES("${_textFieldController.value.text.toString()}")');
    });
  }

  /***獲取存在Sqflite資料庫中的資料*/
  Future getString() async {
    final db = await getDataBase('my_db.db');
    var dbPath = db.path;
    setState(() {
      db.rawQuery('SELECT * FROM user').then((List<Map> lists) {
        print('----------------$lists');
        var listSize = lists.length;
        //獲取資料庫中的最後一條資料
        _storageString = lists[listSize - 1]['name'] +
            "\n現在資料庫中一共有${listSize}條資料" +
            "\n資料庫的儲存路徑為${dbPath}";
      });
    });
  }

  /*** 初始化資料庫儲存路徑*/

  Future<Database> getDataBase(String dbName) async {
    //獲取應用檔案目錄類似於Ios的NSDocumentDirectory和Android上的 AppData目錄
    final fileDirectory = await getApplicationDocumentsDirectory();

    //獲取儲存路徑
    final dbPath = fileDirectory.path;

    //構建資料庫物件
    Database database = await openDatabase(dbPath + "/" + dbName, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT)");
        });

    return database;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('資料儲存'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Sqflite資料庫儲存", textAlign: TextAlign.center),
          TextField(
            controller: _textFieldController,
          ),
          MaterialButton(
            onPressed: saveString,
            child: new Text("儲存"),
            color: Colors.cyan,
          ),
          MaterialButton(
            onPressed: getString,
            child: new Text("獲取"),
            color: Colors.deepOrange,
          ),
          Text('從Sqflite資料庫中獲取的值為  $_storageString'),
        ],
      ),
    );
  }
}
